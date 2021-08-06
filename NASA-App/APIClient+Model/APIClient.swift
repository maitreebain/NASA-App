//
//  APIClient.swift
//  NASA-App
//
//  Created by Maitree Bain on 8/4/21.
//

import UIKit

extension NASACollection {
    
    static func getNASAImages(searchText: String, page: Int = 1, completion: @escaping (Result<[Item], Error>) -> ()) {
        
        let endpoint = "https://images-api.nasa.gov/search?q=\(searchText.lowercased())&media_type=image&page=\(page)"
        
        guard let formattedEndpoint = endpoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: formattedEndpoint) else {
            print("no url found")
            return
        }
        
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            let response = response as! HTTPURLResponse
            
            if let data = data {
                do {
                    let item = try JSONDecoder().decode(NASACollection.self, from: data)
                    completion(.success(item.collection.items))
                } catch {
                    completion(.failure(error))
                }
            }
            
//            response.statusCode
            //work on response
            //show alert
            
            
        }
        dataTask.resume()
    }
    

}
