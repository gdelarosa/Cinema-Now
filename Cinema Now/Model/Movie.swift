//
//  Movie.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 1/10/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//

import Foundation

struct Movie: Codable {
    
    let title: String?
    let language: String?
    let backdrop_path: String?
    
    let poster: String?
    let overview: String?
    let release_date: String?
    
    let adult: Bool?
    let video: Bool?
    
    let id: Int?
    let genre_ids: [Int]?
    let popularity: Double?
}

struct Dates: Codable {
    var max: String?
    var min: String?
}
