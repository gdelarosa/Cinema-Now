//
//  Movie.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 1/10/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//

import Foundation

enum Genre: Int {
    case action = 28
    case adventure = 12
    case animation = 16
    case comedy = 35
    case crime = 80
    case documentary = 99
    case drama = 18
    case family = 10751
    case fantasy = 14
    case history = 36
    case horror = 27
    case music = 10402
    //case mystery
    case romance = 10749
    case scienceFiction = 878
    case tVMovie = 10770
    case thriller = 53
    case war = 10752
    case western = 37
    
    var list: String {
        switch self {
        case .action: return "action"
        case .adventure: return "adventure"
        case .animation: return "animation"
        case .comedy: return "comedy"
        case .crime: return "crime"
        case .documentary: return "documentary"
        case .drama: return "drama"
        case .family: return "family"
        case .fantasy: return "fantasy"
        case .history: return "history"
        case .horror: return "horror"
        case .music: return "music"
        case .romance: return "romance"
        case .scienceFiction: return "science fiction"
        case .tVMovie: return "TV Movie"
        case .thriller: return "thriller"
        case .war: return "war"
        case .western: return "western"
        default:
            return "Empty"
        }
    }
    
    static var allValues = [Genre]() 
}

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
    
    //TV
    let first_air_date: String?
    let name: String?
    var birthday: String?
}

