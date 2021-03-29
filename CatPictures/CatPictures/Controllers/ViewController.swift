//
//  ViewController.swift
//  CatPictures
//
//  Created by Daniela Mara on 28/03/21.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var images: [Image] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        GalleryService().loadCatsGallery { (gallery) in
            self.getImages(gallery: gallery)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } onError: { (error) in
            // TODO: handle errors
            print(error)
        }
    }
    
    private func getImages(gallery: [Gallery]) {
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

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        let image = images[indexPath.row]
        if let url = URL(string: image.link) {
            if let imageData = try? Data(contentsOf: url) {
                cell.ivImage.image = UIImage(data: imageData)
            }
        }
        return cell
    }
}
