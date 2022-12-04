//
//  SelectColor.metal
//  CaramelCamera
//
//  Created by Sohyun Jeong on 2022/12/03.
//
#include <CoreImage/CoreImage.h>

using namespace metal;

enum SelectColorType {
    reds, yellows, greens, cyans, blues, magentas, whites, neutrals, blacks
};

// cyan magenta yellow black

float getMin(float a, float b)
{
    if(a < b)
        return a;

    return b;
}

float getMax(float a, float b)
{
    if(a < b)
        return b;

    return a;
}

float getAbs(float a)
{
    if(a >= 0)
        return a;

    return -a;
}

float clipColor(float x, float min, float max)
{
    if(x < min)
        return min;
    else if(x > max)
        return max;
    else
        return x;
}

float colorScaleRGB(float max, float med)
{
    return max - med;
}

float colorScaleCMY(float med, float min)
{
    return med - min;
}

float colorScaleWhite(float min)
{
    return 2 * min - 1;
}

float colorScaleNeutral(float max, float min)
{
    return 1 - (getAbs(max - 0.5f) + getAbs(min - 0.5f));
}

float colorScaleBlack(float max)
{
    return 1 - 2 * max;
}

float getColorAdjustment(float sourceColor, float k, float adjustment, float colorScale)
{
    float clippedValue = clipColor(((-1 - adjustment) * k - adjustment) * (1 - sourceColor), -sourceColor, 1 - sourceColor);
    return clippedValue * colorScale;
}

float4 applySelectColorFilter(float4 targetColor,
                              float4 reds, float4 yellows, float4 greens, float4 cyans, float4 blues, float4 magentas,
                              float4 whites, float4 neutrals, float4 blacks)
{
    float rg = getMax(targetColor.r, targetColor.g);
    float max = getMax(rg, targetColor.b);
    
    float min = getMin(targetColor.r, targetColor.g);
    min = getMin(min, targetColor.b);
    
    float med = getMin(rg, targetColor.b);
    if(med == min)
        med = getMin(targetColor.r, targetColor.g);

    float4 output = targetColor;

    // 타입이 맞을 경우, 그 타입(ex red)에서 그 색에 맞는 조절값을 가지고 와서 적용한다
    if(max == targetColor.r)
    {
        // red
        output.r += getColorAdjustment(targetColor.r, reds[3], reds[0], colorScaleRGB(max, med));
        output.g += getColorAdjustment(targetColor.g, reds[3], reds[1], colorScaleRGB(max, med));
        output.b += getColorAdjustment(targetColor.b, reds[3], reds[2], colorScaleRGB(max, med));
    }
    if(max == targetColor.g)
    {
        // green
        output.r += getColorAdjustment(targetColor.r, greens[3], greens[0], colorScaleRGB(max, med));
        output.g += getColorAdjustment(targetColor.g, greens[3], greens[1], colorScaleRGB(max, med));
        output.b += getColorAdjustment(targetColor.b, greens[3], greens[2], colorScaleRGB(max, med));
    }
    if(max == targetColor.b)
    {
        // blue
        output.r += getColorAdjustment(targetColor.r, blues[3], blues[0], colorScaleRGB(max, med));
        output.g += getColorAdjustment(targetColor.g, blues[3], blues[1], colorScaleRGB(max, med));
        output.b += getColorAdjustment(targetColor.b, blues[3], blues[2], colorScaleRGB(max, med));
    }
    if(min == targetColor.r)
    {
        // cyan
        output.r += getColorAdjustment(targetColor.r, cyans[3], cyans[0], colorScaleCMY(med, min));
        output.g += getColorAdjustment(targetColor.g, cyans[3], cyans[1], colorScaleCMY(med, min));
        output.b += getColorAdjustment(targetColor.b, cyans[3], cyans[2], colorScaleCMY(med, min));
    }
    if(min == targetColor.g)
    {
        // magentas
        output.r += getColorAdjustment(targetColor.r, magentas[3], magentas[0], colorScaleCMY(med, min));
        output.g += getColorAdjustment(targetColor.g, magentas[3], magentas[1], colorScaleCMY(med, min));
        output.b += getColorAdjustment(targetColor.b, magentas[3], magentas[2], colorScaleCMY(med, min));
    }
    if(min == targetColor.b)
    {
        // yellow
        output.r += getColorAdjustment(targetColor.r, yellows[3], yellows[0], colorScaleCMY(med, min));
        output.g += getColorAdjustment(targetColor.g, yellows[3], yellows[1], colorScaleCMY(med, min));
        output.b += getColorAdjustment(targetColor.b, yellows[3], yellows[2], colorScaleCMY(med, min));
    }
    if(targetColor.r > 0.5f && targetColor.g > 0.5f && targetColor.b > 0.5f)
    {
        // white
        output.r += getColorAdjustment(targetColor.r, whites[3], whites[0], colorScaleWhite(min));
        output.g += getColorAdjustment(targetColor.g, whites[3], whites[1], colorScaleWhite(min));
        output.b += getColorAdjustment(targetColor.b, whites[3], whites[2], colorScaleWhite(min));
    }
    if(targetColor.r != 0 && targetColor.g != 0 && targetColor.b != 0 &&
            targetColor.r != 1 && targetColor.g != 1 && targetColor.b != 1)
    {
        // neutral
        output.r += getColorAdjustment(targetColor.r, neutrals[3], neutrals[0], colorScaleNeutral(max, min));
        output.g += getColorAdjustment(targetColor.g, neutrals[3], neutrals[1], colorScaleNeutral(max, min));
        output.b += getColorAdjustment(targetColor.b, neutrals[3], neutrals[2], colorScaleNeutral(max, min));
    }
    if(targetColor.r < 0.5f && targetColor.g < 0.5f && targetColor.b < 0.5f)
    {
        // black
        output.r += getColorAdjustment(targetColor.r, blacks[3], blacks[0], colorScaleBlack(max));
        output.g += getColorAdjustment(targetColor.g, blacks[3], blacks[1], colorScaleBlack(max));
        output.b += getColorAdjustment(targetColor.b, blacks[3], blacks[2], colorScaleBlack(max));
    }

    return output;
}

extern "C" float4 selectColor(coreimage::sample_t s,
                              float red0,float red1,float red2,float red3,
                              float yellow0,float yellow1,float yellow2,float yellow3,
                              float green0,float green1,float green2,float green3,
                              float cyan0,float cyan1,float cyan2,float cyan3,
                              float blue0,float blue1,float blue2,float blue3,
                              float magenta0,float magenta1,float magenta2,float magenta3,
                              float white0,float white1,float white2,float white3,
                              float neutral0,float neutral1,float neutral2,float neutral3,
                              float black0,float black1,float black2,float black3) {
    float4 reds = {red0, red1, red2, red3};
    float4 yellows = {yellow0, yellow1, yellow2, yellow3};
    float4 greens = {green0, green1, green2, green3};
    float4 cyans = {cyan0, cyan1, cyan2, cyan3};
    float4 blues = {blue0, blue1, blue2, blue3};
    float4 magentas = {magenta0, magenta1, magenta2, magenta3};
    float4 whites = {white0, white1, white2, white3};
    float4 neutrals = {neutral0, neutral1, neutral2, neutral3};
    float4 blacks = {black0, black1, black2, black3};
    
    return applySelectColorFilter(s, reds, yellows, greens, cyans, blues, magentas, whites, neutrals, blacks);
}
