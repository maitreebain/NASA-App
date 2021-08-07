//
//  DetailViewController.swift
//  NASA-App
//
//  Created by Maitree Bain on 8/4/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var nasaImageDetails: Item
    private let detailView = DetailView()
    
    init(_ imageDetail: Item) {
        self.nasaImageDetails = imageDetail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        title = nasaImageDetails.data.first?.title ?? "No title available"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.black
        view = detailView
        view.backgroundColor = .white
        getImage()
        loadUI()
    }
    
    
    private func loadUI() {
        detailView.titleLabel.text = nasaImageDetails.data.first?.title ?? "No title available"
        detailView.locationLabel.text = nasaImageDetails.data.first?.location ?? "No location available"
        detailView.photographerLabel.text = nasaImageDetails.data.first?.photographer ?? "No photographer available"
        if let descript = nasaImageDetails.data.first?.description {
            detailView.descriptionTextView.text = descript
        } else {
            detailView.descriptionTextView.text = nasaImageDetails.data.first?.descriptionPlus
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
