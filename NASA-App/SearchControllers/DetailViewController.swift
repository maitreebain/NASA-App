//
//  DetailViewController.swift
//  NASA-App
//
//  Created by Maitree Bain on 8/4/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailLocationLabel: UILabel!
    @IBOutlet weak var detailPhotographerLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    
    var nasaImageDetails: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.black
        loadUI()
        customizeUI()
    }
    
    private func loadUI() {
        
        guard let nasaImageInfo = nasaImageDetails else {
            print("nasaImageDetails not available")
            return
        }
        
        title = nasaImageInfo.data.first?.title
        //give default values to items
        detailTitleLabel.text = nasaImageInfo.data.first?.title ?? "No title available"
        detailLocationLabel.text = nasaImageInfo.data.first?.location ?? "No location available"
        detailPhotographerLabel.text = nasaImageInfo.data.first?.photographer ?? "No photographer available"
        if let descript = nasaImageInfo.data.first?.description {
            detailTextView.text = descript
        } else {
            detailTextView.text = nasaImageInfo.data.first?.descriptionPlus ?? "No title available"
        }
        
        detailImageView.image = ImageClient.imageCache.object(forKey: "nasaImage")
        
    }
    
    private func customizeUI() {
        detailImageView.layer.cornerRadius = 4
        detailTextView.layer.cornerRadius = 4
        detailTextView.layer.borderWidth = 2
        detailTextView.layer.borderColor = UIColor.white.cgColor
    }
    
}
