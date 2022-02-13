//
//  NASAAPIClient.swift
//  NASAPicOftheDAy
//
//  Created by Ruthwick S Rai on 12/02/22.
//

import Foundation
import UIKit

class NASAAPIClient {
    typealias JSON = [String : String]
    
    
    // Call this API to get data
    static func getDataFromAPI(at date: String, completion: @escaping (JSON) -> ()) {
        let urlString = "https://api.nasa.gov/planetary/apod?api_key=oVzWO0EjdNLWPocLIekkhqSyc3OLaiZh3ichwyWU&date=\(date)"
        let url = URL(string: urlString)
        guard let unwrappedURL = url else {return}
        
        let session = URLSession.shared
        let task = session.dataTask(with: unwrappedURL) { (data, response, error) in
            guard let unwrappedData = data else {return}
            do {
                let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as? JSON ?? ["":""]
                debugPrint(responseJSON["explanation"] ?? "")
                completion(responseJSON)
            } catch {
                debugPrint(error)
            }
        }
        task.resume()
        
    }
      
    // Call this function to download and show the image
    static func downloadImage(at urlString: String, completion: @escaping (Bool, UIImage?) -> ()) {
        let url = URL(string: urlString)
        guard let unwrappedURL = url else {return}
        let request = URLRequest(url: unwrappedURL)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else { completion(false, nil); return }
            completion(true, image)
        }
        task.resume()
    }
    
}
