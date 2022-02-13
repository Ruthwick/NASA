//
//  JSONManager.swift
//  NASAPicOftheDAy
//
//  Created by Ruthwick S Rai on 13/02/22.
//

import Foundation
import UIKit

struct FavJSONManager {
    
    func saveData(_ favs:[PicOfTheDay]) {
        do {
            let keyed_archiver: NSData = try NSKeyedArchiver.archivedData(withRootObject: favs, requiringSecureCoding: false) as NSData
            // Write/Set Data
            UserDefaults.standard.set(keyed_archiver, forKey: "fav")
            UserDefaults.standard.synchronize()
        } catch {
            print("Unable to Encode Array of Notes (\(error))")
        }
    }
    
    
    func retriveArray() -> [PicOfTheDay]{
        let theData: Data? = UserDefaults.standard.data(forKey: "fav")
        if theData != nil {
            do {
                let favsList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(theData!) as? [PicOfTheDay] ?? []
                return favsList
            }catch {
                debugPrint("Error unwrapping")
                return []
            }
        }else {
            debugPrint("Error feching")
            return []
        }
    }
    
}


struct CacheJSONManager {
    
    func saveData(_ favs:PicOfTheDay) {
        do {
            let keyed_archiver: NSData = try NSKeyedArchiver.archivedData(withRootObject: favs, requiringSecureCoding: false) as NSData
            // Write/Set Data
            UserDefaults.standard.set(keyed_archiver, forKey: "cache")
            UserDefaults.standard.synchronize()
        } catch {
            print("Unable to Encode Array of Notes (\(error))")
        }
    }
    
    
    func retriveCacheData() -> PicOfTheDay?{
        let theData: Data? = UserDefaults.standard.data(forKey: "cache")
        if theData != nil {
            do {
                let favsList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(theData!) as? PicOfTheDay ?? PicOfTheDay.init(["":""], UIImage.init())
                return favsList
            }catch {
                debugPrint("Error unwrapping")
                return PicOfTheDay.init(["":""], UIImage.init())
            }
        }else {
            debugPrint("Error feching")
            return PicOfTheDay.init(["":""], UIImage.init())
        }
    }
    
}
