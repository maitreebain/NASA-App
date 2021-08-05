//
//  ImageClient.swift
//  NASA-App
//
//  Created by Maitree Bain on 8/4/21.
//

import UIKit

struct ImageClient {
    
    static func fetchImage(urlString: String, completion: @escaping (Result<UIImage,Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            print("no image url available")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let data = data {
                guard let image = UIImage(data: data) else {
                    return
                }
                completion(.success(image))
            }
            
            if let error =  error {
                completion(.failure(error))
            }
        }
    }
}
