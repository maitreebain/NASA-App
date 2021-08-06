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
        view = detailView
        view.backgroundColor = .white
    }
    

}
