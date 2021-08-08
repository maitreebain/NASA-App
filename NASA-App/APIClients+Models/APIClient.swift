//
//  APIClient.swift
//  NASA-App
//
//  Created by Maitree Bain on 8/4/21.
//

import Foundation

class NASAAPIClient {
    
    static let shared = NASAAPIClient()
    
    private init() {
        print("singleton initialized")
    }
    
    func getNASAItems(searchText: String, page: Int = 1, completion: @escaping (Result<[Item], AppError>) -> ()) {
        
        let endpoint = "https://images-api.nasa.gov/search?q=\(searchText.lowercased())&media_type=image&page=\(page)"
        
        guard let formattedEndpoint = endpoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: formattedEndpoint) else {
            completion(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        
        request.cachePolicy = .useProtocolCachePolicy
        
        if let cacheResponse = URLSession.shared.configuration.urlCache?.cachedResponse(for: request) {
            
            do {
                let item = try JSONDecoder().decode(NASACollection.self, from: cacheResponse.data)
                completion(.success(item.collection.items))
            } catch {
                completion(.failure(.couldNotParseJSON(rawError: error)))
            }
            
        } else {
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if let data = data {
                    do {
                        let item = try JSONDecoder().decode(NASACollection.self, from: data)
                        //gets items array to load data onto collection view
                        completion(.success(item.collection.items))
                    } catch {
                        completion(.failure(.couldNotParseJSON(rawError: error)))
                    }
                }
            }
            dataTask.resume()
        }
    }
    
}
