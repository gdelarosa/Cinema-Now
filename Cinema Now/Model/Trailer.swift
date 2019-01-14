//
//  Trailer.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 1/10/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//

import Foundation

struct Trailer: Decodable {
    var items: [Items]?
    var etag: String?
    
}

struct Items: Decodable {
    var etag: String?
    var id: Id?
    var snippet: Snippet?
    var channelTitle: String?
    var status: Status?
}

struct Id: Decodable {
    var playlistId: String?
}

struct Snippet: Decodable {
    var channelId: String?
    var title: String?
    var description: String?
    var thumbnails: VideoThumbnails?
}

struct VideoThumbnails: Decodable {
    var medium: Thumbnails?
    var high: Thumbnails?
}

struct Thumbnails: Decodable {
    var url: String?
    var width: Int?
    var height: Int?
}

struct Status: Decodable {
    var privacyStatus: String?
}
