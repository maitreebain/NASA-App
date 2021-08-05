//
//  APIClient.swift
//  NASA-App
//
//  Created by Maitree Bain on 8/4/21.
//

import UIKit

extension NASACollection {
    
    static func getNASAImages(searchText: String, completion: @escaping (Result<[Item], Error>) -> ()) {
        
        let endpoint = "https://images-api.nasa.gov/search?q=\(searchText.lowercased())&media_type=image"
        
        
        guard let url = URL(string: endpoint) else {
            print("no url found")
            return
        }
        
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                do {
                    let item = try JSONDecoder().decode(NASACollection.self, from: data)
                    completion(.success(item.collection.items))
                } catch {
                    completion(.failure(error))
                }
            }
            
//            if let response = response {
//
//            }
            //work on response
        }
        dataTask.resume()
    }
    

}
