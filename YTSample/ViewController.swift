//
//  ViewController.swift
//  YTSample
//
//  Created by robert john alkuino on 12/28/16.
//  Copyright © 2016 thousandminds. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    let playerView =  YTPlayerView()
    let titleLabel = UILabel()
    let artistLabel = UILabel()
    var ytDatas:[YoutubeApiMapper] = []
    
    lazy var searchController:UISearchBar = UISearchBar(frame: CGRect.zero);
    var dividerView = UIView()
    
    let tableviewVideoList = UITableView()
    let urlParam = "karaoke"

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let videoPlayerY = self.view.frame.height/3
        let labelHeight = (self.view.frame.height * 0.2) / 2
        
        view.backgroundColor = UIColor.white
        playerView.load(withVideoId: "")
        view.addSubview(playerView)
        
        titleLabel.backgroundColor = UIColor.white
        titleLabel.numberOfLines = 0
        titleLabel.text = ""
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        
        artistLabel.backgroundColor = UIColor.white
        artistLabel.numberOfLines = 0
        artistLabel.text = ""
        artistLabel.textAlignment = .left
        artistLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        
        dividerView.backgroundColor = UIColor.black
        
        view.addSubview(titleLabel)
        view.addSubview(artistLabel)
        view.addSubview(dividerView)
        view.addSubview(tableviewVideoList)

        tableviewVideoList.delegate = self
        tableviewVideoList.dataSource = self
        tableviewVideoList.register(YoutubeTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        self.callApi(q: "")
        
        playerView.anchorAndFillEdge(.top, xPad: 0, yPad: (self.navigationController?.navigationBar.height)! , otherSize: videoPlayerY)
        titleLabel.align(.underMatchingRight, relativeTo: playerView, padding: 0, width: view.frame.width - 10, height: labelHeight)
        artistLabel.align(.underMatchingRight, relativeTo: titleLabel, padding: 0, width: view.frame.width - 10, height: labelHeight)
        dividerView.align(.underMatchingRight, relativeTo: artistLabel, padding: 0, width: view.frame.width, height: 2)
        tableviewVideoList.align(.underCentered, relativeTo: dividerView, padding: 0, width: view.frame.width , height: view.frame.height - playerView.frame.height - (titleLabel.frame.height * 2) - (self.navigationController?.navigationBar.height)! - 2)
        
        self.configureSearchController()
        
        
    }
    
    func callApi(q:String) {
        let params = ["part": "snippet","q":"karaoke " + q,"key":"AIzaSyASbUWRlzaWcFPna8M1PmgaLWNzk1Jf0ns"]
        
        ApiService<YoutubeApiMapper>().request(keyPath:"items",urlEndpoint: "/youtube/v3/search", params: params, method: .get, completion: { json in
            if let jsonData = json {
                self.ytDatas = jsonData
                self.searchController.endEditing(true)
                self.tableviewVideoList.reloadData()
            }
        })
    }
    
    
    func configureSearchController() {
        searchController.placeholder = "Search title or artist..";
        searchController.delegate = self;
        searchController.showsCancelButton = true;
        searchController.autocapitalizationType = .none
        searchController.tintColor = UIColor.black
        self.navigationItem.titleView = searchController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showWarningAlert(message:String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
extension ViewController: UISearchBarDelegate {
//    private func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
//        
//    }
//    
//    
//    private func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
//        print("searchBarTextDidBeginEditing")
//    }
//    
//    private func searchBarTextDidEndEditing(searchBar: UISearchBar) {
//        print("searchBarTextDidEndEditing")
//    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked")
        self.callApi(q: searchBar.text!)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarCancelButtonClicked")
        searchBar.endEditing(true)
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! YoutubeTableViewCell
        
        let infos = ytDatas[indexPath.row]
        cell.bind(cellInfo: infos)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ytDatas.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let infos = ytDatas[indexPath.row]
        if let id = infos.id {
            playerView.load(withVideoId: id)
            titleLabel.text = infos.title
            artistLabel.text = infos.description
        }
    }
}
