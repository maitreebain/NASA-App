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
    let href: String //thumbnail image link
    let render: MediaType
}

struct ImageData: Decodable {
    let title: String
    let description: String?
    let mediaType: MediaType
    let nasaID: String
    let photographer: String?
    let location: String?
    
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "description_508"
        case mediaType = "media_type"
        case nasaID = "nasa_id"
        case photographer
        case location
    }
}

