//
//  ViewController+Extension.swift
//  NASAPicOftheDAy
//
//  Created by Ruthwick S Rai on 13/02/22.
//

import Foundation
import UIKit
import WebKit

extension ViewController{
    func setupView(){
        //Retry button setup
        self.retryBtn.isHidden = true
        self.retryBtn.layer.cornerRadius = 2
        if #available(iOS 13.0, *) {
            self.retryBtn.layer.borderColor = UIColor.label.cgColor
        } else {
            self.retryBtn.layer.borderColor = UIColor.black.cgColor
        }
        self.retryBtn.layer.borderWidth = 2
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
        
        //DatePicker setup 
        self.datePicker.maximumDate = Date()
    }
    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "PicOfTheDayCell",
                                  bundle: nil)
        self.picOfTheDayView.register(textFieldCell,
                                      forCellReuseIdentifier: "PicOfTheDayCell")
    }
    
    
    @objc func didTapSearchButton(sender: AnyObject){
        debugPrint("Search Clicked")
        self.pickerView.isHidden = false
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
        cell.webView.isHidden = true
        if self.picOfTheDayDetails?.media_type.lowercased() == "video"{
            cell.webView.isHidden = false
            let myURL = URL(string: (self.picOfTheDayDetails?.url ?? ""))
            let youtubeRequest = URLRequest(url: myURL!)
            cell.webView.load(youtubeRequest)
        }
        cell.dateLabel.text =  self.picOfTheDayDetails?.date
        cell.imageTitle.text =  self.picOfTheDayDetails?.title
        cell.imageExplanation.text =  self.picOfTheDayDetails?.explanation
        cell.mainHolderViewHeight.constant = cell.imageExplanation.optimalHeight + 250
        if (!(self.picOfTheDayDetails?.title.isEmpty ?? true)) && FavJSONManager().retriveArray().contains(where: {$0.date == self.picOfTheDayDetails?.date}){
            cell.favButton.setImage(UIImage.init(named: "like-of-filled-heart"), for: .normal)
        }else {
            cell.favButton.setImage(UIImage.init(named:"icons8-heart-50"), for: .normal)
        }
        cell.favButton.addTarget(self, action: #selector(favPic(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let holderView = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        let labelView = UILabel.init(frame: CGRect(x: 0, y: 5, width: tableView.frame.width, height: 20))
        labelView.text = Date().dayDifference(self.picOfTheDayDetails?.date ?? "")
        labelView.textAlignment = .center
        holderView.addSubview(labelView)
        labelView.clipsToBounds = true
        holderView.clipsToBounds = true
        return holderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    @objc func favPic(sender: UIButton){
        var favArray = FavJSONManager().retriveArray()
        if favArray.contains(where: {$0.date == self.picOfTheDayDetails?.date}){
            self.showRemovePrompt(title:"Remove?" , message: "Do you want to remove this picture from favourties.", completion: { _ in
                debugPrint("Remove")
                let index = favArray.firstIndex(where:{$0.date == self.picOfTheDayDetails?.date})
                favArray.remove(at: index ?? 0)
                FavJSONManager().saveData(favArray)
                self.picOfTheDayView.reloadData()
            })
            return
        }
        favArray.append(self.picOfTheDayDetails!)
        FavJSONManager().saveData(favArray)
        self.showAlert(title: "Favourited!", message: "", style: .alert)
        self.picOfTheDayView.reloadData()
    }
    
}
