//
//  UITableViewCell_textContent.swift
//  StoryboardStudy
//
//  Created by Sohyun Jeong on 2022/09/14.
//

import UIKit

class UITableViewCell_textContent: UITableViewCell {
    @IBOutlet weak var contentLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(content: String, bgColor: UIColor) {
        contentLabel.text = content
    }
}
