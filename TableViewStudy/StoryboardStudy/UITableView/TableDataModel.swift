//
//  DataModel.swift
//  StoryboardStudy
//
//  Created by Sohyun Jeong on 2022/09/13.
//

import Foundation
import UIKit

enum TableCellType {
    case none, title, subTitle, text, image, divider
}

class TableBase {
    public let cellHeight : CGFloat
    public let cellType : TableCellType
    
    init() {
        cellHeight = 0
        cellType = TableCellType.none
    }
    
    init(cellHeight : CGFloat, type : TableCellType) {
        self.cellHeight = cellHeight
        cellType = type
    }
    
    init(type : TableCellType) {
        cellHeight = 0
        cellType = type
    }
}

class TableTitle : TableBase {
    let title : String
    let desc : String
    let bgColor : UIColor
    
    init(title : String, desc : String, bgColor : UIColor) {
        self.title = title
        self.desc = desc
        self.bgColor = bgColor
        super.init(cellHeight: 0, type: TableCellType.title)
    }
}

class TableSubTitle : TableBase {
    let title : String
    let bgColor : UIColor
    
    init(title : String, bgColor : UIColor) {
        self.title = title
        self.bgColor = bgColor
        super.init(cellHeight: 56, type: TableCellType.subTitle)
    }
}

class TableContent_text : TableBase {
    let content : String
    let bgColor : UIColor

    init(content : String, bgColor : UIColor) {
        self.content = content
        self.bgColor = bgColor
        super.init(type: TableCellType.text)
    }
}

class TableContent_image : TableBase {
    let image : UIImage
    let caption : String?
    
    init(image : UIImage) {
        self.image = image
        caption = nil
        super.init(type: TableCellType.image)
    }
    
    init(image : UIImage, caption : String) {
        self.image = image
        self.caption = caption
        super.init(type: TableCellType.image)
    }
}

class TableDivider : TableBase {
    override init() {
        super.init(cellHeight: 56, type: TableCellType.divider)
    }
}

class TableDataModel {
    private var dataList : [TableBase] = []
    
    func setup() {
        // 서버가 없으니까 일단 이런 식으로다가,,
        dataList.append(TableTitle(title: "UITableView", desc: "A view that presents data using rows in a single column.", bgColor: UIColor.clear))
        dataList.append(TableDivider())
        
        dataList.append(TableSubTitle(title: "Declaration", bgColor: UIColor.clear))
        dataList.append(TableContent_text(content: "@MainActor class UITableView : UIScrollView", bgColor: UIColor.clear))
        
        dataList.append(TableSubTitle(title: "Overview", bgColor: UIColor.clear))
        dataList.append(TableContent_text(content: "Table views in iOS display rows of vertically scrolling content in a single column. Each row in the table contains one piece of your app’s content. For example, the Contacts app displays the name of each contact in a separate row, and the main page of the Settings app displays the available groups of settings. You can configure a table to display a single long list of rows, or you can group related rows into sections to make navigating the content easier.", bgColor: UIColor.clear))
        dataList.append(TableContent_image(image: UIImage(named: "tableViewImage1")!))
        dataList.append(TableContent_text(content: """
Tables are common in apps with data that’s highly structured or organized hierarchically. Apps that contain hierarchical data often use tables in conjunction with a navigation view controller, which facilitates navigation between different levels of the hierarchy. For example, the Settings app uses tables and a navigation controller to organize the system settings.
UITableView manages the basic appearance of the table, but your app provides the cells (UITableViewCell objects) that display the actual content. The standard cell configurations display a simple combination of text and images, but you can define custom cells that display any content you want. You can also supply header and footer views to provide additional information for groups of cells.
""", bgColor: UIColor.clear))
    }
    
    func getDataList() -> [TableBase] {
        return dataList
    }
    
    func getDataListCount() -> Int {
        return dataList.count
    }
    
    func getTableData(index : Int) -> TableBase {
        if index < dataList.count {
            return dataList[index]
        }
        
        return TableBase()
    }
}
