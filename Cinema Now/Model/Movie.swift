//
//  Movie.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 1/10/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//

import Foundation

//enum genre: Int {
//
//    case Action = 28
//    case Adventure = 12
//    case Animation = 16
//    case Comedy = 35
//    case Crime = 80
//    case Documentary = 99
//    case Drama = 18
//    case Family = 10751
//    case Fantasy = 14
//    case History = 36
//    case Horror = 27
//    case Music = 10402
//    case Mystery = 9648
//    case Romance = 10749
//    case ScienceFiction = 878
//    case TVMovie = 10770
//    case Thriller = 53
//    case War = 10752
//    case Western = 37
//}

struct Movie: Codable {
    
    var profile_path: String?
    var poster_path: String?
    let title: String?
    let backdrop_path: String?
    
    let poster: String?
    let overview: String?
    let release_date: String?
    
    let video: Bool?
    
    let id: Int?
    let genre_ids: [Int]?
    let popularity: Double?
    var vote_average: Double?
}

