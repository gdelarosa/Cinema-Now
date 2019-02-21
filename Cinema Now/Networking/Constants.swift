//
//  Constants.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 1/10/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//

import Foundation

var posterSizes = ["w92", "w154", "w185", "w342", "w500", "w780", "w1280", "original"]
var trailerQualitySettings: [String] = []
var person_id: Int?

struct Api {
    static let BASE_URL = "https://api.themoviedb.org/3"
    static let KEY = "Insert API KEY HERE"
    static let SCHEME = "https"
    static let HOST = "api.themoviedb.org"
    static let PATH = "/3"
    
    
    static let youtubeThumb = "https://img.youtube.com/vi/"
    static let youtubeLink = "https://www.youtube.com/watch?v="
}

struct ParameterKeys {
    static let API_KEY = "api_key"
    static let SESSION_ID = "session_id"
    static let PAGE = "page"
    static let TOTAL_RESULTS = "total_results"
    static let REGION = "region"
    static let MOVIE_ID = "movie_id"
    static let KNOWN_FOR = "known_for"
}

struct ImageKeys {
    static let IMAGE_BASE_URL = "https://image.tmdb.org/t/p/"
    
    struct PosterSizes {
        static let BACK_DROP = posterSizes[6]
        static let ROW_POSTER = posterSizes[2]
        static let DETAIL_POSTER = posterSizes[3]
        static let ORIGINAL_POSTER = posterSizes[6]
    }
}

struct Methods {
    static let NOW_PLAYING = "/movie/now_playing"
    static let TRENDING_WEEK = "/trending/movie/week"
    static let UPCOMING = "/movie/upcoming"
    static let TOP_RATED = "/movie/top_rated"
    static let POPULAR_ACTORS = "/person/popular"
    static let TRENDING_TV = "/trending/tv/week"
}


