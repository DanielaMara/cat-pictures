//
//  API.swift
//  CatPictures
//
//  Created by Daniela Mara on 28/03/21.
//

import Foundation

class API {
    private static let configuration : URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Authorization": "Client-ID \(Constants.ClientID)"]
        config.timeoutIntervalForRequest = 15.0
        return config
    }()
    
    static let session = URLSession(configuration: configuration)
}
