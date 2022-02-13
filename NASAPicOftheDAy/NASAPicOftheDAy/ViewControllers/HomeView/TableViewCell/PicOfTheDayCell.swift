//
//  PicOfTheDayCell.swift
//  NASAPicOftheDAy
//
//  Created by Ruthwick S Rai on 12/02/22.
//

import UIKit
import WebKit

class PicOfTheDayCell: UITableViewCell {
    @IBOutlet var webView: WKWebView!
    @IBOutlet var mainHolderView: UIView!
    @IBOutlet var mainHolderViewHeight: NSLayoutConstraint!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var imageExplanation: UILabel!
    @IBOutlet weak var picOfTheDay: UIImageView!
    @IBOutlet var favButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.webView.isHidden = true
        self.webView.stopLoading()
        self.mainHolderView.layer.cornerRadius = 10
        self.mainHolderView.layer.borderWidth = 2
        if self.traitCollection.userInterfaceStyle == .dark {
            // User Interface is Dark
            self.favButton.tintColor = .white
            self.mainHolderView.layer.borderColor = UIColor.white.cgColor
        } else {
            // User Interface is Light
            self.favButton.tintColor = .black
            self.mainHolderView.layer.borderColor = UIColor.black.cgColor
        }
    } 
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
           // Trait collection has already changed
        
        if self.traitCollection.userInterfaceStyle == .dark {
            // User Interface is Dark
            self.favButton.tintColor = .white
            self.mainHolderView.layer.borderColor = UIColor.white.cgColor
        } else {
            // User Interface is Light
            self.favButton.tintColor = .black
            self.mainHolderView.layer.borderColor = UIColor.black.cgColor
        }
    }
    
}
