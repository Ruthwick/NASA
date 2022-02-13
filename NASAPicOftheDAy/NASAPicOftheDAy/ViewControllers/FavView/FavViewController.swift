//
//  FavViewController.swift
//  NASAPicOftheDAy
//
//  Created by Ruthwick S Rai on 13/02/22.
//

import UIKit

class FavViewController: UIViewController {
    @IBOutlet var favListTable: UITableView!
    var favList = [PicOfTheDay]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    func setupView(){
        // Configure TableView
        self.favListTable.isHidden = true
        self.favListTable.dataSource = self
        self.favListTable.delegate = self
        // cell intialisation
        self.registerTableViewCells()
    }
    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "FavTableViewCell",
                                  bundle: nil)
        self.favListTable.register(textFieldCell,
                                   forCellReuseIdentifier: "FavTableViewCell")
    }
}
// Mark: Set table view properties
extension FavViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavTableViewCell", for: indexPath) as! FavTableViewCell
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
}
