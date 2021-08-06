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
    
    private var searchText = ""
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(resignTextField(gesture:)))
        return gesture
    }()
    
    private lazy var imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named:"milky-way")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private var collection = [Item]() {
        didSet{
            imageCollectionView.reloadData()
            if collection.count == 0 {
                emptyView()
            } else {
                imageCollectionView.backgroundView = imageView
            }
        }
    }
    
    private var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        emptyView()
        if (imageCollectionView.backgroundView != nil) {
            imageCollectionView.backgroundView?.addGestureRecognizer(tapGesture)
        }
        imageSearchBar.delegate = self
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
    }

    
    func search(searchText: String, page: Int = 1) {
        
        NASACollection.getNASAImages(searchText: searchText, page: page) { [weak self] (result) in
            
            switch result {
            case .failure(let error):
                print(error)
            case .success(let items):
                DispatchQueue.main.async {
                    if page == 1 {
                        self?.collection = items
                    } else {
                        self?.collection.append(contentsOf: items)
                    }
                    self?.imageSearchBar.resignFirstResponder()
                }
            }
        }
    }
    
    private func emptyView() {
        imageCollectionView.backgroundColor = .black
        imageCollectionView.backgroundView = BackgroundView(title: "No images available", message: "Use the search bar to look up images based on a NASA mission")
    }
    
    private func collectionViewCellShadowSetup(cell: UICollectionViewCell) {
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 8
        cell.layer.shadowOpacity = 1
        cell.layer.masksToBounds = false
    }
    
    @objc func resignTextField(gesture: UITapGestureRecognizer) {
        imageSearchBar.resignFirstResponder()
    }
    
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            //show alert
            return
        }
        
        searchText = text
        page = 1
        search(searchText: searchText)
        collection = [Item]()
    }
    
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width * 0.40
        let itemHeight: CGFloat = maxSize.height * 0.18
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 28, left: 8, bottom: 28, right: 8)
        }
    
}

extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return collection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCell else {
            fatalError("could not return ImageCell")
        }
        
        let item = collection[indexPath.row]
        
        cell.imageView.layer.cornerRadius = 10
        collectionViewCellShadowSetup(cell: cell)
        
        if let link = item.links?.first?.href {
            cell.configureCell(with: link)
        }
        
        if indexPath.row == collection.count - 1 {
            page += 1

            search(searchText: searchText, page: page)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nasaData = collection[indexPath.row]
        let detailVC =  DetailViewController(nasaData, indexPath.row)
        detailVC.nasaImageDetails = nasaData
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
