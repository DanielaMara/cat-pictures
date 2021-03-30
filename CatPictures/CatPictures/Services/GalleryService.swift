//
//  GalleryService.swift
//  CatPictures
//
//  Created by Daniela Mara on 29/03/21.
//

import Foundation

class GalleryService {
    let session = APIManager.session
    private var cacheImages = NSCache<NSString, NSData>()
    
    func loadCatsGallery(page:Int, onComplete: @escaping ([Gallery]) -> Void, onError: @escaping (AppError) -> Void) {
        guard let url = URL(string: "\(Constants.BaseURL)gallery/search/\(page)?q=cats") else {
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
                        let responseData = try JSONDecoder().decode(APIResponse.self, from: data)
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
    
    private func download(imageURL: URL, completion: @escaping (Data?, Error?) -> Void) {
          if let imageData = cacheImages.object(forKey: imageURL.absoluteString as NSString) {
            completion(imageData as Data, nil)
            return
          }
          
          let downloadTask = session.downloadTask(with: imageURL) { localUrl, response, error in
            if let error = error {
              completion(nil, error)
              return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
    //          completion(nil, nil)
              return
            }
            
            guard let localUrl = localUrl else {
    //          completion(nil, nil)
              return
            }
            
            do {
              let data = try Data(contentsOf: localUrl)
              self.cacheImages.setObject(data as NSData, forKey: imageURL.absoluteString as NSString)
              completion(data, nil)
            } catch let error {
              completion(nil, error)
            }
          }
      
        downloadTask.resume()
    }
    
    func buildImage(image: Image, completion: @escaping (Data?, Error?) -> (Void)) {
      let url = URL(string: image.link)!
      download(imageURL: url, completion: completion)
    }
}
