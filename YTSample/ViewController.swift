//
//  ViewController.swift
//  YTSample
//
//  Created by robert john alkuino on 12/28/16.
//  Copyright © 2016 thousandminds. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class ViewController: UIViewController {
    
    let playerView =  YTPlayerView()
    let baseURLString = "https://www.googleapis.com"
    var ytDatas:[YoutubeApiMapper] = []
    
    let tableviewVideoList = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        let videoPlayerY = view.frame.height/3
        
        playerView.frame = CGRect(x: 0,y: 0,width: view.frame.width,height: videoPlayerY)
        view.backgroundColor = UIColor.blue
        playerView.load(withVideoId: "gh6GT40zKCo")
        view.addSubview(playerView)
        
        tableviewVideoList.frame = CGRect(x:0,y:videoPlayerY,width:view.frame.width,height:view.frame.height - videoPlayerY)
        view.addSubview(tableviewVideoList)

        tableviewVideoList.delegate = self
        tableviewVideoList.dataSource = self
        tableviewVideoList.register(YoutubeTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let params = ["part": "snippet","channelId":"UCE_M8A5yxnLfW0KghEeajjw","key":"AIzaSyASbUWRlzaWcFPna8M1PmgaLWNzk1Jf0ns"]
        
        ApiService<YoutubeApiMapper>().request(keyPath:"items",urlEndpoint: "/youtube/v3/search", params: params, method: .get, completion: { json in
            if let jsonData = json {
                self.ytDatas = jsonData
                print(jsonData)
                self.tableviewVideoList.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        playerView.load(withVideoId: infos.id!)
    }
}
