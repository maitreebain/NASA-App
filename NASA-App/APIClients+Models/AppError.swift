//
//  AppError.swift
//  NASA-App
//
//  Created by Maitree Bain on 8/8/21.
//

import Foundation

enum AppError: Error {
    case invalidJSONResponse
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case badURL
    case badStatusCode
    case noDataReceived
    case notAnImage
    case other(rawError: Error)
}
