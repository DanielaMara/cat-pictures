//
//  ResponseData.swift
//  CatPictures
//
//  Created by Daniela Mara on 28/03/21.
//

import Foundation

class APIResponse: Codable {
    var data: [Gallery]
    var success: Bool
    var status: Int
}
