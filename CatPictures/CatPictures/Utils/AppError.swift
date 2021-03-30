//
//  AppError.swift
//  CatPictures
//
//  Created by Daniela Mara on 29/03/21.
//

import Foundation

enum AppError: Error {
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case statusCode(code: Int)
    case invalidData
}
