//
//  FavTableViewCell.swift
//  NASAPicOftheDAy
//
//  Created by Ruthwick S Rai on 13/02/22.
//

import UIKit
import WebKit

class FavTableViewCell: UITableViewCell {
    @IBOutlet var mainView: UIView!
    @IBOutlet var favImage: UIImageView!
    @IBOutlet var favTitle: UILabel!
    @IBOutlet var removeBtn: UIButton!
    @IBOutlet var explantionLbl: UILabel!
    @IBOutlet var webView: WKWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if self.traitCollection.userInterfaceStyle == .dark {
            // User Interface is Dark
            self.mainView.layer.borderColor = UIColor.white.cgColor
            self.removeBtn.tintColor = UIColor.white
        } else {
            // User Interface is Light
            self.mainView.layer.borderColor = UIColor.black.cgColor
            self.removeBtn.tintColor = UIColor.black
        }
        self.favImage.layer.cornerRadius = 2
        self.mainView.layer.borderWidth = 1
        self.mainView.layer.cornerRadius = 5 
        self.webView.isUserInteractionEnabled = false
        self.webView.stopLoading()
        // Initialization code
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
           // Trait collection has already changed
        if self.traitCollection.userInterfaceStyle == .dark {
            // User Interface is Dark
            self.mainView.layer.borderColor = UIColor.white.cgColor
            self.removeBtn.tintColor = UIColor.white
        } else {
            // User Interface is Light
            self.mainView.layer.borderColor = UIColor.black.cgColor
            self.removeBtn.tintColor = UIColor.black
        }
    }
}
