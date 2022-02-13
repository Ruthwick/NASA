//
//  FavViewController.swift
//  NASAPicOftheDAy
//
//  Created by Ruthwick S Rai on 13/02/22.
//

import UIKit 

protocol FavUpdateDelegate{
    func reloadMainPage()
}


class FavViewController: UIViewController {
    @IBOutlet var favListTable: UITableView!
    @IBOutlet var emptyFavLbl: UILabel!
    var favList = [PicOfTheDay]()
    var delegate : FavUpdateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.loadFavList()
    }
    
    func setupView(){
        // Configure TableView
        self.emptyFavLbl.isHidden = true
        self.favListTable.isHidden = true
        self.favListTable.dataSource = self
        self.favListTable.delegate = self
        self.favListTable.rowHeight = 44
        self.favListTable.estimatedRowHeight = UITableView.automaticDimension
        // cell intialisation
        self.registerTableViewCells()
    }
    
    func loadFavList(){
        
        let favs = FavJSONManager().retriveArray()
        if favs.count == 0{
            self.emptyFavLbl.isHidden = false
            self.favListTable.isHidden = true
        }else {
            self.favList = favs
            debugPrint("self.favList: \(self.favList)")
            self.favListTable.reloadData()
            self.favListTable.isHidden = false
        }
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
        return self.favList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavTableViewCell", for: indexPath) as! FavTableViewCell
        let favItems = self.favList[indexPath.row]
        cell.favTitle.text = favItems.title
        cell.favImage.image = favItems.image
        cell.webView.isHidden = true
        if favItems.media_type.lowercased() == "video"{
            cell.webView.isHidden = false
            let myURL = URL(string: (favItems.url))
            let youtubeRequest = URLRequest(url: myURL!)
            cell.webView.load(youtubeRequest)
        }
        cell.removeBtn.tag = indexPath.row
        cell.explantionLbl.text = favItems.explanation
        cell.removeBtn.addTarget(self, action: #selector(removeFav(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        let favItems = self.favList[indexPath.row]
        nextViewController?.picOfTheDayDetails = favItems
        let navContoller = UINavigationController.init(rootViewController: nextViewController!)
        navContoller.modalPresentationStyle = .fullScreen
        self.present(navContoller, animated: true, completion: nil)
    }
     

    @objc func removeFav(sender: UIButton){
        var favArray = FavJSONManager().retriveArray()
        self.showRemovePrompt(title:"Remove?" , message: "Do you want to remove this picture from favourites?", completion: { _ in
            debugPrint("Remove")
            favArray.remove(at: sender.tag)
            FavJSONManager().saveData(favArray)
            self.loadFavList()
            self.delegate?.reloadMainPage()
        })
    }
    
    
    
}
