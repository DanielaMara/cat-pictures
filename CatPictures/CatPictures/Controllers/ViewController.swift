//
//  ViewController.swift
//  CatPictures
//
//  Created by Daniela Mara on 28/03/21.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let galleryService = GalleryService()
    
    var images: [Image] = []
    var page = 1


    override func viewDidLoad() {
        super.viewDidLoad()
        
        galleryService.loadCatsGallery(page: 1) { [weak self] gallery in
            self?.getImagesInGallery(gallery: gallery)
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        } onError: { error in
            print(error)
        }
    }
    
    private func getImagesInGallery(gallery: [Gallery]) {
        var auxImages: [Image] = []

        for elem in gallery {
            if let images = elem.images {
                auxImages.append(contentsOf: images)
            }
        }
        
        for image in auxImages {
            if image.type.contains("image/") {
                self.images.append(image)
            }
        }
    }
}


extension ViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
    let imageByCell = images[indexPath.item]
    let representedIdentifier = imageByCell.id
    
    cell.ivImage.image = nil
    cell.cellIdentifier = representedIdentifier
    
    func image(data: Data?) -> UIImage? {
      if let data = data {
        return UIImage(data: data)
      }
      return UIImage(systemName: "picture")
    }
    
    galleryService.buildImage(image: imageByCell) { data, error  in
      let img = image(data: data)
      DispatchQueue.main.async {
        if (cell.cellIdentifier == representedIdentifier) {
          cell.ivImage.image = img
        }
      }
    }
    
    return cell
  }
}

//extension ViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width/3.5, height: collectionView.frame.width/3.5)
//    }
//}

