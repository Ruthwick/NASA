//
//  PicOfTheDay.swift
//  NASAPicOftheDAy
//
//  Created by Ruthwick S Rai on 12/02/22.
//

import Foundation
import UIKit

class PicOfTheDay: NSObject, NSCoding {
    
    var date: String
    var explanation: String
    var title: String
    var media_type: String
    var url: String
    var image: UIImage?
    
    init(_ data: [String: String],_ image:UIImage) {
        self.image = image
        self.date = data["date"] ?? ""
        self.explanation = data["explanation"] ?? ""
        self.title = data["title"] ?? ""
        self.media_type = data["media_type"] ?? ""
        self.url = data["url"] ?? ""
    }
    
    @objc func encode(with encoder: NSCoder) {
        encoder.encode(image, forKey:"image")
        encoder.encode(date, forKey:"date")
        encoder.encode(explanation, forKey:"explanation")
        encoder.encode(title, forKey:"title")
        encoder.encode(media_type, forKey:"media_type")
        encoder.encode(url, forKey:"url")
    }
    
    required init (coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.media_type = aDecoder.decodeObject(forKey: "media_type") as! String
        self.url = aDecoder.decodeObject(forKey: "url") as! String
        self.image = aDecoder.decodeObject(forKey: "image") as? UIImage
        self.date = aDecoder.decodeObject(forKey: "date") as! String
        self.explanation = aDecoder.decodeObject(forKey: "explanation") as! String
    }
    
}
