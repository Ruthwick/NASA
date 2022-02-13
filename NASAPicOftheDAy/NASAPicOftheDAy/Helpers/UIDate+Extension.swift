//
//  UIDate+Extension.swift
//  NASAPicOftheDAy
//
//  Created by Ruthwick S Rai on 13/02/22.
//

import Foundation
extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
