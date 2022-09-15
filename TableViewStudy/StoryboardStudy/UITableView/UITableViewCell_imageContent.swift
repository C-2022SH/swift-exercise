//
//  UITableViewCell_imageContent.swift
//  StoryboardStudy
//
//  Created by Sohyun Jeong on 2022/09/15.
//

import UIKit

class UITableViewCell_imageContent: UITableViewCell {
    @IBOutlet weak var imageContent : UIImageView!
    @IBOutlet weak var caption : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(image : UIImage, caption : String?) {
        imageContent.image = image
        if let caption = caption {
            self.caption.text = caption
        } else {
            self.caption.isHidden = true
        }
    }
}
