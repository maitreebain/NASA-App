//
//  CollectionViewCell.swift
//  NASA-App
//
//  Created by Maitree Bain on 8/4/21.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCellImageView: UIImageView!
    
    func configureCell(with url: String) {
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .blue
        activityIndicator.startAnimating()
        activityIndicator.center = center
        addSubview(activityIndicator)
        
        ImageClient.shared.fetchImage(urlString: url) { [weak self] (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .failure:
                    activityIndicator.stopAnimating()
                    self?.imageCellImageView.image = UIImage(systemName: "photo.on.rectangle.angled")
                case .success(let image):
                    activityIndicator.stopAnimating()
                    self?.imageCellImageView.image = image
                    
                }
            }
        }
        
    }
}
