//
//  ViewController.swift
//  NASAPicOftheDAy
//
//  Created by Ruthwick S Rai on 12/02/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var picOfTheDayView: UITableView!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var pickerView: UIView!
    @IBOutlet var retryBtn: UIButton!
    
    
    var picOfTheDayDetails : PicOfTheDay?
    let loader = LoadingView()
    let toolbar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupView()
        let today = Date().string(format: "YYYY-MM-dd")
        self.getPicOfTheDay(today)
    }
    
    func getPicOfTheDay(_ date:String){
        self.loader.add(withText: "Loading...", into: self.view)
        self.retryBtn.isHidden = true
        NASAAPIClient.getDataFromAPI(at: date) { (response) in
            guard let imageUrl = response["url"] else {
                print ("Error getting image url")
                DispatchQueue.main.async {
                self.loader.dismissLoadingView()
                self.showAlert(title: "Error", message: "Something went wrong please try again later!", style: .alert)
                    self.retryBtn.isHidden = false
                }
                return
            }
            
            NASAAPIClient.downloadImage(at: imageUrl, completion: { (success, image) in
                
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
                    DispatchQueue.main.async {
                    self.loader.dismissLoadingView()
                    self.showAlert(title: "Error", message: "Something went wrong please try again later!", style: .alert)
                        self.retryBtn.isHidden = false
                    }
                }
            })
        }
        
    }
    
    @IBAction func doneTapped(_ sender: UIButton) {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        self.getPicOfTheDay(datePicker.date.string(format: "YYYY-MM-dd"))
        self.pickerView.isHidden = true
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        self.pickerView.isHidden = true
    }
    
    @IBAction func retryClicked(_ sender: UIButton) {
        let today = Date().string(format: "YYYY-MM-dd")
        self.getPicOfTheDay(today)
    }
    
    
}
