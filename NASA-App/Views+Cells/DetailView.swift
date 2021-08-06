//
//  DetailView.swift
//  NASA-App
//
//  Created by Maitree Bain on 8/4/21.
//

import UIKit

class DetailView: UIView {
    
    public lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rocket")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    public lazy var nasaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.on.rectangle.angled")
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        imageView.layer.shadowRadius = 8.0
        imageView.layer.shadowOpacity = 1
        imageView.layer.masksToBounds = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura", size: 28)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.text = "Title Here"
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    public lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura", size: 20)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.text = "Description:"
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    public lazy var descriptionTextView: UITextView = {
        let label = UITextView()
        label.font = UIFont(name: "Futura", size: 14)
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
        label.text = "Photographer: "
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    public lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura", size: 18)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.text = "Location"
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundImageViewSetup()
        nasaImageViewSetup()
        titleLabelSetup()
        locationLabelSetup()
        photographerLabelSetup()
        descriptionLabelSetup()
        descriptionTextViewSetup()
    }
    
    private func backgroundImageViewSetup() {
        addSubview(backgroundImageView)
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            backgroundImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
            backgroundImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            backgroundImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    private func nasaImageViewSetup() {
        addSubview(nasaImageView)
        
        nasaImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nasaImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            nasaImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
            nasaImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            nasaImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3)
        ])
        
    }
    
    private func titleLabelSetup() {
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: nasaImageView.bottomAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func locationLabelSetup() {
        addSubview(locationLabel)
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            locationLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            locationLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func photographerLabelSetup() {
        addSubview(photographerLabel)
        
        photographerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photographerLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8),
            photographerLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            photographerLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func descriptionLabelSetup() {
        addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: photographerLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func descriptionTextViewSetup() {
        addSubview(descriptionTextView)
        
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 14),
            descriptionTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: centerXAnchor, constant: 8),
            descriptionTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.32)
        ])
    }
}
