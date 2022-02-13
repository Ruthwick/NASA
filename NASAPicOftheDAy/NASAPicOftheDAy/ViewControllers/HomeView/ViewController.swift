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
        if self.picOfTheDayDetails == nil{
            self.getPicOfTheDay(today)
        }else {
            self.picOfTheDayView.reloadData()
            self.picOfTheDayView.isHidden = false
        }
    }
    
    func getPicOfTheDay(_ date:String){
        if Reachability.isConnectedToNetwork(){
            debugPrint("Internet Connection Available!")
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
                
                if response["media_type"]?.lowercased() == "video"{
                    DispatchQueue.main.async {
                        self.picOfTheDayDetails = PicOfTheDay.init(response,UIImage.init())
                        CacheJSONManager().saveData(self.picOfTheDayDetails!)
                        self.picOfTheDayView.reloadData()
                        self.loader.dismissLoadingView()
                        self.picOfTheDayView.isHidden = false
                    }
                    return
                }
                NASAAPIClient.downloadImage(at: imageUrl, completion: { (success, image) in
                    
                    if success == true {
                        print("got image data from URL")
                        DispatchQueue.main.async {
                            self.picOfTheDayDetails = PicOfTheDay.init(response,image ?? UIImage.init())
                            CacheJSONManager().saveData(self.picOfTheDayDetails!)
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
        }else{
            debugPrint("Internet Connection not Available!")
            self.showAlert(title: "No Internet available!", message: "Please make sure you are connected to the internet.", style: .alert)
            guard let cacheData = CacheJSONManager().retriveCacheData() else{
                self.retryBtn.isHidden = false
                self.picOfTheDayView.isHidden = true
                return
            }
            self.picOfTheDayDetails = cacheData
            self.picOfTheDayView.reloadData()
            self.retryBtn.isHidden = true
            self.picOfTheDayView.isHidden = false
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
