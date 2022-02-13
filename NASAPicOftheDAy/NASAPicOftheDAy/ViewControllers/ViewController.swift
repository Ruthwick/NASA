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
    
    func setupView(){
        //Configure NavigationBar
        self.navigationController?.title = "Pic Of The Day"
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .black
        let searchImage    = UIImage.init(named: "icons8-search-50")
        let heartImg  = UIImage.init(named: "icons8-heart-50")
        
        let searchButton   = UIBarButtonItem(image: searchImage,  style: .plain, target: self, action: #selector(didTapSearchButton(sender:)))
        let favButton = UIBarButtonItem(image: heartImg,  style: .plain, target: self, action: #selector(didTapfavButton(sender:)))
        
        self.navigationItem.rightBarButtonItems = [favButton,searchButton]
        
        // Configure TableView
        self.picOfTheDayView.isHidden = true
        self.picOfTheDayView.dataSource = self
        self.picOfTheDayView.delegate = self
        self.picOfTheDayView.rowHeight = 44
        self.picOfTheDayView.estimatedRowHeight = UITableView.automaticDimension
        // cell intialisation
        self.registerTableViewCells()
    }
    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "PicOfTheDayCell",
                                  bundle: nil)
        self.picOfTheDayView.register(textFieldCell,
                                      forCellReuseIdentifier: "PicOfTheDayCell")
    }
    
    
    @objc func didTapSearchButton(sender: AnyObject){
        debugPrint("Search Clicked")
    }
    
    @objc func didTapfavButton(sender: AnyObject){
        debugPrint("Fav Clicked")
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

// Mark: Set table view properties
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PicOfTheDayCell", for: indexPath) as! PicOfTheDayCell
        cell.picOfTheDay.image = self.picOfTheDayDetails?.image
        cell.dateLabel.text =  self.picOfTheDayDetails?.date
        cell.imageTitle.text =  self.picOfTheDayDetails?.title
        cell.imageExplanation.text =  self.picOfTheDayDetails?.explanation
        cell.mainHolderViewHeight.constant = cell.imageExplanation.optimalHeight + 350
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
