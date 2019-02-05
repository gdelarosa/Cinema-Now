//
//  Videos.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 2/4/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//

import Foundation

struct Videos:Codable {
    var id:String?
    var key:String?
    var name:String?
}

struct VideoInfo:Codable {
    var id:Int?
    var results:[Videos]?
}
