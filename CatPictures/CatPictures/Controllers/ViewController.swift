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
    let refreshControl = UIRefreshControl()
    
    var images: [Image] = []
    var page = 1


    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadImages()
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    private func loadImages() {
        galleryService.loadGallery(query: "cats", page: page) { [weak self] gallery in
            self?.getImagesInGallery(gallery: gallery)
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        } onError: { error in
            self.handleError(error: error)
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
    
    @objc func refreshData() {
        page = 1
        loadImages()
        collectionView.refreshControl?.endRefreshing()
    }
    
    private func handleError(error: AppError) {
        let title: String = "ERROR_TITLE"
        var message: String = "GENERAL_ERROR_MESSAGE"

        switch error {
            case .url:
                message = "URL_ERROR_MESSAGE"
                break
            case .noResponse:
                message = "NO_RESPONSE_ERROR_MESSAGE"
                break
            case .noData:
                message = "NO_DATA_ERROR_MESSAGE"
                break
            case .invalidData:
                message = "INVALID_DATA_ERROR_MESSAGE"
                break
            default:
                break
        }
        showAlert(title: title, message: message)
    }

    private func showAlert(title: String, message: String) {
        let titleLocalize = NSLocalizedString(title, comment: "Title Alert")
        let messageLocalize = NSLocalizedString(message, comment: "Message Alert")

        let alert = UIAlertController(title: titleLocalize, message: messageLocalize, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)

        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
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

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastElementIndex = images.count - 1
        if indexPath.row == lastElementIndex {
            page += 1
            loadImages()
        }
    }
}

//extension ViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width/3.5, height: collectionView.frame.width/3.5)
//    }
//}

