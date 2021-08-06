//
//  DetailViewController.swift
//  NASA-App
//
//  Created by Maitree Bain on 8/4/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var nasaImageDetails: Item
    var indexPath: Int
    
    private let detailView = DetailView()
    
    init(_ imageDetail: Item,_ index: Int) {
        self.nasaImageDetails = imageDetail
        self.indexPath = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = detailView
        view.backgroundColor = .white
        getImage()
        loadUI()
    }
    
    
    private func loadUI() {
        detailView.titleLabel.text = nasaImageDetails.data[indexPath].title
        detailView.locationLabel.text = nasaImageDetails.data[indexPath].location
        detailView.photographerLabel.text = nasaImageDetails.data[indexPath].photographer
        if let descript = nasaImageDetails.data[indexPath].description {
        detailView.descriptionTextView.text = descript
        } else {
            detailView.descriptionTextView.text = nasaImageDetails.data[indexPath].descriptionPlus
        }
        
    }
    
    private func getImage() {
        if let url = nasaImageDetails.links?.first?.href {
            ImageClient.fetchImage(urlString: url) { (result) in
                
                DispatchQueue.main.async {
                    switch result{
                    case .failure:
                        self.detailView.nasaImageView.image = UIImage(systemName: "photo.on.rectangle.angled")
                    case .success(let image):
                        self.detailView.nasaImageView.image = image
                    }
                }
            }
        }
    }
    
    
}
