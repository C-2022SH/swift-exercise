//
//  RoundSquareUIView.swift
//  StoryboardStudy
//
//  Created by Sohyun Jeong on 2022/09/15.
//

import UIKit

@IBDesignable
class RoundSquareUIView: UIView {
    @IBInspectable var borderColor : UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
}
