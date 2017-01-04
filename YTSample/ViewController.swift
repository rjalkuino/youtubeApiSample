//
//  ViewController.swift
//  YTSample
//
//  Created by robert john alkuino on 12/28/16.
//  Copyright © 2016 thousandminds. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import SDWebImage

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
        tableviewVideoList.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        request(completion: { val in
            
            if let values = val {
                self.ytDatas = values
                self.tableviewVideoList.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    
    func request(completion: @escaping ([YoutubeApiMapper]?) -> Void) {
        
        let urlString = URL(string: baseURLString + "/youtube/v3/search")
        
        let parameters: Parameters = ["part": "snippet","channelId":"UCE_M8A5yxnLfW0KghEeajjw","key":"AIzaSyASbUWRlzaWcFPna8M1PmgaLWNzk1Jf0ns"]
        
        Alamofire.request(urlString!, method: .get, parameters: parameters, encoding: URLEncoding.default)
            .validate { request, response, data in
                return .success
            }
            .responseArray(keyPath: "items") { (response: DataResponse<[YoutubeApiMapper]>) in
                
                completion(response.result.value)
            }
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        let infos = ytDatas[indexPath.row]
        
        cell.textLabel?.text = infos.title! as String
        cell.imageView?.sd_setImage(with: NSURL(string: infos.thumbnailUrl!) as URL!)
        cell.detailTextLabel?.text = infos.description! as String
        
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