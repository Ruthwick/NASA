//
//  FavTableViewCell.swift
//  NASAPicOftheDAy
//
//  Created by Ruthwick S Rai on 13/02/22.
//

import UIKit

class FavTableViewCell: UITableViewCell {
    @IBOutlet var mainView: UIView!
    @IBOutlet var favImage: UIImageView!
    @IBOutlet var favTitle: UILabel!
    @IBOutlet var removeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if self.traitCollection.userInterfaceStyle == .dark {
            // User Interface is Dark
            self.mainView.layer.borderColor = UIColor.white.cgColor
        } else {
            // User Interface is Light
            self.mainView.layer.borderColor = UIColor.black.cgColor
        }
        self.mainView.layer.borderWidth = 1
        self.mainView.layer.cornerRadius = 5
        self.removeBtn.layer.cornerRadius = 2
        self.removeBtn.layer.borderWidth = 1
        self.removeBtn.layer.borderColor = UIColor.blue.cgColor
        // Initialization code
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
           // Trait collection has already changed
        if self.traitCollection.userInterfaceStyle == .dark {
            // User Interface is Dark
            self.mainView.layer.borderColor = UIColor.white.cgColor
        } else {
            // User Interface is Light
            self.mainView.layer.borderColor = UIColor.black.cgColor
        }
    }
}
