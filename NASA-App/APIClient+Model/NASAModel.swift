//
//  NASAModel.swift
//  NASA-App
//
//  Created by Maitree Bain on 8/4/21.
//

import Foundation

enum MediaType: String, Codable {
    case audio = "audio"
    case image = "image"
    case video = "video"
}

struct NASACollection: Decodable {
    let collection: Collection
}

struct Collection: Decodable {
    let items: [Items]
}

struct Items: Decodable {
    let links: [ItemLink]
    let data: [ImageData]
}

struct ItemLink: Decodable {
    let href: String //image link
    let render: MediaType
}

struct ImageData: Decodable {
    let title: String
    let description: String?
    let mediaType: MediaType
    let dateCreated: Date
    let nasaID: String
}

