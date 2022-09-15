//
//  UITableViewCell_title.swift
//  StoryboardStudy
//
//  Created by Sohyun Jeong on 2022/09/14.
//

import UIKit

class UITableViewCell_title: UITableViewCell {
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var descLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(title : String, desc : String, bgColor : UIColor) {
        titleLabel.text = title
        descLabel.text = desc
    }
}
