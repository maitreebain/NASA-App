//
//  ViewController.swift
//  NASA-App
//
//  Created by Maitree Bain on 8/3/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet private weak var imageSearchBar: UISearchBar!
    @IBOutlet private weak var imageCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIUpdate()
        imageSearchBar.delegate = self
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
    }
    
    private func UIUpdate() {
        
    }
    
    
}

extension SearchViewController: UISearchBarDelegate {
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
}

extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //id: imageCell
        
        
        return UICollectionViewCell()
    }
    
    
}
