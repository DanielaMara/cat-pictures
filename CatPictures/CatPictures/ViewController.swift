//
//  ViewController.swift
//  CatPictures
//
//  Created by Daniela Mara on 28/03/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        API.loadCatsGallery()
    }
}

