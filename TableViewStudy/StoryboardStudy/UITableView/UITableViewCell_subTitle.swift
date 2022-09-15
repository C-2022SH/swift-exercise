//
//  UITableViewCell_subTitle.swift
//  StoryboardStudy
//
//  Created by Sohyun Jeong on 2022/09/14.
//

import UIKit

class UITableViewCell_subTitle: UITableViewCell {
    @IBOutlet weak var subTitleLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(content: String, bgColor: UIColor) {
        subTitleLabel.text = content
    }
}
