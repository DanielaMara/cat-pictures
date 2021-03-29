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
    
    private static let session = URLSession(configuration: configuration)
    
    
    class func loadCatsGallery() {
        guard let url = URL(string: "\(Constants.BaseURL)gallery/search/?q=cats") else {return}
        
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error == nil {
                guard let response = response as? HTTPURLResponse else {return}
                if response.statusCode == 200 {
                    
                    guard let data = data else {return}
                    do {
                        let responseData = try JSONDecoder().decode(ResponseData.self, from: data)
                        
                        for picture in responseData.data {
                            print(picture.title)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                } else {
                    print("Erro no servidor")
                }
            } else {
                print(error!)
            }
        }
        dataTask.resume()
    }
}
