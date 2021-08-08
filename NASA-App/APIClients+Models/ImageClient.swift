//
//  ImageClient.swift
//  NASA-App
//
//  Created by Maitree Bain on 8/4/21.
//

import UIKit

class ImageClient {
    
    static let shared = ImageClient()
    
    public static var imageCache = NSCache<NSString, UIImage>()
    
    func fetchImage(urlString: String, completion: @escaping (Result<UIImage,Error>) -> Void) {
        
        let formattedStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let url = formattedStr, let officialURL = URL(string: url) else {
            print("no image url available")
            return
        }
        
        URLSession.shared.dataTask(with: officialURL) { (data, response, error) in
            
            if let data = data {
                guard let image = UIImage(data: data) else {
                    return
                }
            
                ImageClient.imageCache.setObject(image, forKey: "nasaImage")
                completion(.success(image))
            }
            
            if let error =  error {
                completion(.failure(error))
            }
            
        }.resume()
    }
}
