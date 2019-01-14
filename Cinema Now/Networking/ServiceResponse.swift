//
//  ServiceResponse.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 1/10/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//

import Foundation

struct ServiceResponse: Codable {
    let results: [Movie]
    let page: Int
    let numPages: Int
}
