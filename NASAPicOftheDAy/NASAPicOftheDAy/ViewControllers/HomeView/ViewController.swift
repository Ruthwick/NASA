//
//  ViewController.swift
//  NASAPicOftheDAy
//
//  Created by Ruthwick S Rai on 12/02/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var picOfTheDayView: UITableView!
    var picOfTheDayDetails : PicOfTheDay?
    let loader = LoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.loader.add(withText: "Loading...", into: self.view)
        self.setupView()
        self.getPicOfTheDay("2022-02-12")
    }
    
    func getPicOfTheDay(_ date:String){
        
        NASAAPIClient.getDataFromAPI(at: date) { (response) in
            NASAAPIClient.downloadImage(at: response["url"]!, completion: { (success, image) in
                
                if success == true {
                    print("got image data from URL")
                    DispatchQueue.main.async {
                        self.picOfTheDayDetails = PicOfTheDay.init(response,image ?? UIImage.init()) 
                        self.picOfTheDayView.reloadData()
                        self.loader.dismissLoadingView()
                        self.picOfTheDayView.isHidden = false
                    }
                    
                } else {
                    print ("Error getting image")
                    self.loader.dismissLoadingView()
                    self.showAlert(title: "Error", message: "Something went wrong please try again later!", style: .alert)
                }
            })
        }
        
    }
    
}
