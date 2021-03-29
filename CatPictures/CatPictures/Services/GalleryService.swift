//
//  GalleryService.swift
//  CatPictures
//
//  Created by Daniela Mara on 29/03/21.
//

import Foundation

class GalleryService {
    let session = API.session
    
    func loadCatsGallery(onComplete: @escaping ([Gallery]) -> Void, onError: @escaping (AppError) -> Void) {
        guard let url = URL(string: "\(Constants.BaseURL)gallery/search/?q=cats") else {
            onError(.url)
            return
        }

        let dataTask = self.session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    return
                }
                if response.statusCode == 200 {
                    guard let data = data else {return}
                    do {
                        let responseData = try JSONDecoder().decode(ResponseData.self, from: data)
                        onComplete(responseData.data)
                    } catch {
                        onError(.invalidData)
                    }
                } else {
                    onError(.statusCode(code: response.statusCode))
                }
            } else {
                onError(.taskError(error: error!))
            }
        }
        dataTask.resume()
    }
}
