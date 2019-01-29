//
//  People.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 1/28/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//

import Foundation

struct Person:Codable {
    
    var birthday:String?
    var known_for_department:String?
    var id:Int?
    var name:String?
    var biography:String?
    var profile_path:String?
    
    static func decode(jsonData: Data) -> Person? {
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(Person.self, from: jsonData)
            return result
        } catch let error {
            print("Failed decoding with error: \(error)")
            return nil
        }
    }
}


