//
//  ImageClient.swift
//  NASA-App
//
//  Created by Maitree Bain on 8/4/21.
//

import UIKit

class ImageClient {
    
    static let shared = ImageClient()
    
    private init() {
        print("singleton initialized")
    }
    
    private var imageCache = NSCache<NSString, UIImage>()
    
    func fetchImage(urlString: String, completion: @escaping (Result<UIImage,AppError>) -> Void) {
        
        let formattedStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let url = formattedStr, let officialURL = URL(string: url) else {
            completion(.failure(.badURL))
            return
        }
        
        if let image = self.imageCache.object(forKey: url as NSString) {
            completion(.success(image))
            
        } else {
            URLSession.shared.dataTask(with: officialURL) { (data, response, error) in
                
                if let data = data {
                    guard let image = UIImage(data: data) else {
                        return
                    }
                    
                    self.imageCache.setObject(image, forKey: url as NSString)
                    completion(.success(image))
                }
                
                if let error =  error {
                    completion(.failure(.couldNotParseJSON(rawError: error)))
                }
                
            }.resume()
        }
    }
}
