//
//  YoutubeTableViewCell.swift
//  YTSample
//
//  Created by robert john alkuino on 1/6/17.
//  Copyright © 2017 thousandminds. All rights reserved.
//

import UIKit
import SDWebImage

class YoutubeTableViewCell: UITableViewCell {
    
    let thumbnail = UIImageView()
    let title = UILabel()

    required override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        thumbnail.frame = CGRect(x:10,y:10,width:100,height:80)
        addSubview(thumbnail)
        
        title.font = UIFont.boldSystemFont(ofSize: 15.0)
        title.numberOfLines = 0
        title.frame = CGRect(x:120,y:10,width:self.frame.width - 120,height:80)
        addSubview(title)
    }
    
    func bind(cellInfo:YoutubeApiModel) {
        title.text = cellInfo.title
        thumbnail.sd_setImage(with: NSURL(string: cellInfo.thumbnailUrl!) as URL!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
