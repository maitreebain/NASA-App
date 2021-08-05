//
//  DetailView.swift
//  NASA-App
//
//  Created by Maitree Bain on 8/4/21.
//

import UIKit

class DetailView: UIView {
    
    public lazy var nasaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.on.rectangle.angled")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura", size: 20)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.text = "Title Here"
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    public lazy var descriptionLabel: UITextView = {
        let label = UITextView()
        label.font = UIFont(name: "Futura", size: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.text = "This is a description"
        label.sizeToFit()
        label.isEditable = false
        label.backgroundColor = .clear
        return label
    }()
    
    public lazy var photographerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura", size: 14)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.text = "Photographer"
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    public lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura", size: 16)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.text = "Location"
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func commonInit() {
        
    }
    
}
