//
//  Image.swift
//  CatPictures
//
//  Created by Daniela Mara on 28/03/21.
//

import Foundation

struct Image: Codable {
    let id: String
    let title: String?
    let description: String?
    let type: String
    let link: String
}
