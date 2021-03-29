//
//  Gallery.swift
//  CatPictures
//
//  Created by Daniela Mara on 28/03/21.
//

import Foundation

class Gallery: Codable {
    var id: String = ""
    var title: String = ""
    var description: String? = ""
    var images: [Image]?
}
