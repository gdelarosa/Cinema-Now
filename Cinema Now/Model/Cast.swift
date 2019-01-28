//
//  Cast.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 1/27/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//

import Foundation

//struct Cast: Codable {
//    let cast_id: Int?
//    let character: String?
//    let credit_id: String?
//    let name: String?
//    let profile_path: String?
//}

struct Cast: Codable {
    let castID: Int
    let character, creditID: String
    let gender, id: Int
    let name: String
    let order: Int
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case gender, id, name, order
        case profilePath = "profile_path"
    }
}

struct Crew: Codable {
    let creditID, department: String
    let gender, id: Int
    let job, name: String
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case creditID = "credit_id"
        case department, gender, id, job, name
        case profilePath = "profile_path"
    }
}
