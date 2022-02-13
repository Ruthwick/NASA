//
//  ViewController+Extension.swift
//  NASAPicOftheDAy
//
//  Created by Ruthwick S Rai on 13/02/22.
//

import Foundation
import UIKit

extension ViewController{
    func setupView(){
        //Configure NavigationBar
        if self.traitCollection.userInterfaceStyle == .dark {
            // User Interface is Dark
            self.navigationController?.navigationBar.tintColor = .white
        } else {
            // User Interface is Light
            self.navigationController?.navigationBar.tintColor = .black
        }
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
        self.performSegue(withIdentifier: "fav", sender: nil)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
           // Trait collection has already changed
        
        if self.traitCollection.userInterfaceStyle == .dark {
            // User Interface is Dark
            self.navigationController?.navigationBar.tintColor = .white
        } else {
            // User Interface is Light 
            self.navigationController?.navigationBar.tintColor = .black
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
