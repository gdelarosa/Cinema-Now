//
//  Service.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 1/10/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
}

class Service {
    
    // Shared session
    var session = URLSession.shared
    
    // MARK: - Handle Get Requests
    
    func taskForGETMethod(_ method: String, parameters: [String:AnyObject], completionHandlerForGET: @escaping (_ result: Data?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        session.invalidateAndCancel()
        
        // Setup request
        var parametersWithApiKey = parameters
        parametersWithApiKey[ParameterKeys.API_KEY] = Api.KEY as AnyObject?
        
        
        let request = NSMutableURLRequest(url: tmdbURLFromParameters(parametersWithApiKey, withPathExtension: method))
        
        // Make Request
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            func sendRetryError(_ error: String, retryAfter retry: Int) {
                print(error)
                let userInfo: [String : Any] = [NSLocalizedDescriptionKey : error, "Retry-After" : retry]
                completionHandlerForGET(nil, NSError(domain: "taskForGETMethod", code: 429, userInfo: userInfo))
            }
            
            // Handle error
            guard (error == nil) else {
                sendError("There was an error with your request: \(String(describing: error))")
                return
            }
            
            // Make sure that we got a successful response
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 429, let retryString = httpResponse.allHeaderFields["Retry-After"] as? String, let retry = Int(retryString) {
                    print("Retry is an int")
                    sendRetryError("Your request returned a status code of: \(String(describing: (response as? HTTPURLResponse)?.statusCode)) with header fields: \(String(describing: (response as? HTTPURLResponse)?.allHeaderFields))", retryAfter: retry)
                } else {
                    sendError("Your request returned a status code of: \(String(describing: (response as? HTTPURLResponse)?.statusCode)) with header fields: \(String(describing: (response as? HTTPURLResponse)?.allHeaderFields))")
                }
                return
            }
            
            // Get data
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            // Return data
            completionHandlerForGET(data, nil)
        }
        
        // Start the request
        task.resume()
        
        return task
    }
    
    // MARK: - Handle Get Image Requests
    
    func taskForGETImage(_ size: String, filePath: String, completionHandlerForImage: @escaping (_ imageData: Data?, _ error: NSError?) -> Void) -> URLSessionTask {
        
        let baseURL = URL(string: ImageKeys.IMAGE_BASE_URL)!
        let url = baseURL.appendingPathComponent(size).appendingPathComponent(filePath)
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForImage(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            // Check for error
            guard (error == nil) else {
                sendError("There was an error with your request: \(String(describing: error))")
                return
            }
            
            // Check response
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code of: \(String(describing: (response as? HTTPURLResponse)?.statusCode)) with header fields: \(String(describing: (response as? HTTPURLResponse)?.allHeaderFields))")
                return
            }
            
            // Get data
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            // Return image data
            completionHandlerForImage(data, nil)
        }
        
        task.resume()
        
        return task
    }
    
    // MARK: - Private Helper Functions
    
    // Create URL from parameters
    private func tmdbURLFromParameters(_ parameters: [String:AnyObject], withPathExtension: String? = nil) -> URL {
        
        var components = URLComponents()
        components.scheme = Api.SCHEME
        components.host = Api.HOST
        components.path = Api.PATH + (withPathExtension ?? "")
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
    
}
