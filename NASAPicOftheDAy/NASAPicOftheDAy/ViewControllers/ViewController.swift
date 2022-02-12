//
//  ViewController.swift
//  NASAPicOftheDAy
//
//  Created by Ruthwick S Rai on 12/02/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var picOfTheDayView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .black
        // Do any additional setup after loading the view.
        self.setupView()
    }
    
    func setupView(){
        //Configure NavigationBar
        let searchImage    = UIImage.init(named: "icons8-search-50")
        let heartImg  = UIImage.init(named: "icons8-heart-50")
        
        let searchButton   = UIBarButtonItem(image: searchImage,  style: .plain, target: self, action: #selector(didTapSearchButton(sender:)))
        let favButton = UIBarButtonItem(image: heartImg,  style: .plain, target: self, action: #selector(didTapfavButton(sender:)))
        
        self.navigationItem.rightBarButtonItems = [favButton,searchButton]
        
        // Configure TableView
        self.picOfTheDayView.dataSource = self
        self.picOfTheDayView.delegate = self
        self.picOfTheDayView.rowHeight = 100
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
