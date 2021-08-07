//
//  NASAModel.swift
//  NASA-App
//
//  Created by Maitree Bain on 8/4/21.
//

import Foundation

struct NASACollection: Decodable {
    let collection: Collection
}

struct Collection: Decodable {
    let items: [Item]
}

struct Item: Decodable {
    let links: [ThumbnailLinks]?
    let data: [Data]
}

struct ThumbnailLinks: Decodable {
    let href: String
}

struct Data: Decodable {
    let title: String
    let nasaID: String
    let description: String?
    let photographer: String?
    let descriptionPlus: String?
    let location: String?

    enum CodingKeys: String, CodingKey {
        case title
        case nasaID = "nasa_id"
        case description
        case descriptionPlus = "description_508"
        case photographer
        case location
    }
}

