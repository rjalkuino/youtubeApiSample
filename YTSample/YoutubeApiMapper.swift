//
//  YoutubeApiMapper.swift
//  YTSample
//
//  Created by robert john alkuino on 1/3/17.
//  Copyright © 2017 thousandminds. All rights reserved.
//

import ObjectMapper

class YoutubeApiMapper: Mappable {
    var thumbnailUrl: String?
    var title: String?
    var id: String?
    var description: String?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        thumbnailUrl <- map["snippet.thumbnails.default.url"]
        title        <- map["snippet.title"]
        id           <- map["id.videoId"]
        description  <- map["snippet.description"]
    }
}
