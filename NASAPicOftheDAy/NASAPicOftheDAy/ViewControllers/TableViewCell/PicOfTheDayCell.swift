//
//  PicOfTheDayCell.swift
//  NASAPicOftheDAy
//
//  Created by Ruthwick S Rai on 12/02/22.
//

import UIKit

class PicOfTheDayCell: UITableViewCell {
    @IBOutlet var mainHolderView: UIView!
    @IBOutlet var mainHolderViewHeight: NSLayoutConstraint!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var imageExplanation: UILabel!
    @IBOutlet weak var picOfTheDay: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.mainHolderView.layer.cornerRadius = 5 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
