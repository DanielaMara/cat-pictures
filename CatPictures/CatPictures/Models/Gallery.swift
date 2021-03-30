//
//  Gallery.swift
//  CatPictures
//
//  Created by Daniela Mara on 28/03/21.
//

import Foundation

struct Gallery: Codable {
    let id: String
    let title: String
    let description: String?
    let images: [Image]?
}
