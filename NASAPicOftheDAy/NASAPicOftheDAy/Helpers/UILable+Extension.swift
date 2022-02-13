//
//  UILable+Extension.swift
//  NASAPicOftheDAy
//
//  Created by Ruthwick S Rai on 13/02/22.
//

import Foundation
import UIKit
extension UILabel{
    var optimalHeight : CGFloat
        {
            get
            {
                let label = UILabel(frame: CGRect(x:0,y: 0, width:self.frame.width,height: CGFloat.greatestFiniteMagnitude))
                label.numberOfLines = 0
                label.lineBreakMode = self.lineBreakMode
                label.font = self.font
                label.text = self.text

                label.sizeToFit()

                return label.frame.height
            }
        }
}
