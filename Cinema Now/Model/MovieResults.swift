//
//  MovieResults.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 1/10/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//

import Foundation

struct MovieResults {
    
    var pageCount: Int
    var currentPage: Int
    var results: [Movie]?
    var error: Error?
  
    var hasMorePages: Bool {
        return currentPage < pageCount
    }
    
    var nextPage: Int {
        return hasMorePages ? currentPage + 1 : currentPage
    }
}
