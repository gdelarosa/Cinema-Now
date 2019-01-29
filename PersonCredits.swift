//
//  PersonCredits.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 1/28/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//

import Foundation

struct CastData:Codable {
    var poster_path:String?
    var id:Int?
}

struct CrewData:Codable {
    var poster_path:String?
    var id:Int?
}

struct PersonCredits:Codable {
    var id: Int?
    var cast:[CastData]?
    var crew:[CrewData]?
}
