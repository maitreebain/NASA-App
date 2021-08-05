//
//  CollectionViewCell.swift
//  NASA-App
//
//  Created by Maitree Bain on 8/4/21.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell(with url: String) {
        
        ImageClient.fetchImage(urlString: url) { [weak self] (result) in
            
            DispatchQueue.main.async {
                switch result{
                case .failure:
                    self?.imageView.image = UIImage(systemName: "photo.on.rectangle.angled")
                case .success(let image):
                    self?.imageView.image = image
                    
                }
            }
        }
    }
}
