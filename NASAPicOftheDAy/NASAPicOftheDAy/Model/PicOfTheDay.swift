//
//  PicOfTheDay.swift
//  NASAPicOftheDAy
//
//  Created by Ruthwick S Rai on 12/02/22.
//

import Foundation
import UIKit

class PicOfTheDay {
    
    var date: String
    var explanation: String
    var title: String 
    var image: UIImage?
    
    init(_ data: [String: String],_ image:UIImage) {
        self.image = image
        self.date = data["date"] ?? ""
        self.explanation = data["explanation"] ?? ""
        self.title = data["title"] ?? ""
    }
}
