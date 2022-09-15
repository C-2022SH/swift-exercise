//
//  ViewController.swift
//  StoryboardStudy
//
//  Created by Sohyun Jeong on 2022/09/12.
//

import UIKit

// 얘가 일단은 ViewModel 의 역할을 했으면 좋겠는데,,
class ViewController: UIViewController {
    @IBOutlet weak var tableView : UITableView?
    private var tableModel = TableDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 기본 셀을 등록하는 경우, 이런 식으로 해도 된다!!
        // self.tableView?.register(UITableView.self, forCellReuseIdentifier: "TitleCell")
        
        tableModel.setup()
        
        // 커스텀 셀을 등록하는 경우
        self.tableView?.register(UINib(nibName: "UITableViewCell_title", bundle: nil), forCellReuseIdentifier: "UITableViewCell_title")
        self.tableView?.register(UINib(nibName: "UITableViewCell_subTitle", bundle: nil), forCellReuseIdentifier: "UITableViewCell_subTitle")
        self.tableView?.register(UINib(nibName: "UITableViewCell_textContent", bundle: nil), forCellReuseIdentifier: "UITableViewCell_textContent")
        self.tableView?.register(UINib(nibName: "UITableViewCell_imageContent", bundle: nil), forCellReuseIdentifier: "UITableViewCell_imageContent")
        self.tableView?.register(UINib(nibName: "UITableViewCell_divider", bundle: nil), forCellReuseIdentifier: "UITableViewCell_divider")
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableData = tableModel.getTableData(index: indexPath.row)
        
        switch tableData.cellType {
        case TableCellType.none:
            return notSetCell()
            
        case TableCellType.title:
            let tableData = tableData as! TableTitle
            guard let titleCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell_title", for: indexPath) as? UITableViewCell_title else {
                return notSetCell()
            }
            titleCell.setup(title: tableData.title, desc: tableData.desc, bgColor: tableData.bgColor)
            return titleCell
            
        case TableCellType.subTitle:
            let tableData = tableData  as! TableSubTitle
            guard let subTitleCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell_subTitle", for: indexPath) as? UITableViewCell_subTitle else {
                return notSetCell()
            }
            subTitleCell.setup(content: tableData.title, bgColor: tableData.bgColor)
            return subTitleCell
            
        case TableCellType.text:
            let tableData = tableData  as! TableContent_text
            guard let contentCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell_textContent", for: indexPath) as? UITableViewCell_textContent else {
                return notSetCell()
            }
            contentCell.setup(content: tableData.content, bgColor: tableData.bgColor)
            return contentCell
            
        case TableCellType.image:
            let tableData = tableData  as! TableContent_image
            guard let contentCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell_imageContent", for: indexPath) as? UITableViewCell_imageContent else {
                return notSetCell()
            }
            contentCell.setup(image: tableData.image, caption: tableData.caption)
            return contentCell
            
        case TableCellType.divider:
            guard let contentCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell_divider", for: indexPath) as? UITableViewCell_divider else {
                return notSetCell()
            }
            
            return contentCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = tableModel.getTableData(index: indexPath.row)
        
        if data.cellHeight == 0 {
            return UITableView.automaticDimension
        } else {
            return data.cellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.getDataListCount()
    }
    
    func notSetCell() -> UITableViewCell {
        print("table cell generation failed")
        return UITableViewCell()
    }
}

