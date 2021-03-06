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
    
    private lazy var imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named:"milky-way")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private var nasaDataCollection = [Item]() {
        didSet{
            imageCollectionView.reloadData()
            if nasaDataCollection.count == 0 {
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
        imageSearchBar.delegate = self
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
    }
    
    func search(searchText: String, page: Int = 1) {
        
        NASAAPIClient.shared.getNASAItems(searchText: searchText, page: page) { [weak self] (result) in
            
            switch result {
            case .failure(let error):
                print(error)
            case .success(let items):
                DispatchQueue.main.async {
                    if page == 1 {
                        //if on first page, get new set of data
                        self?.nasaDataCollection = items
                    } else {
                        //if scrolling to more than first page, then append all items to array to load up more data/images
                        self?.nasaDataCollection.append(contentsOf: items)
                    }
                    self?.imageSearchBar.resignFirstResponder()
                }
            }
        }
    }
    
    private func emptyView() {
        imageCollectionView.backgroundColor = .black
        let background = BackgroundView(title: "No images available", message: "Use the search bar to look up images based on a NASA mission")
        background.tapGesture.addTarget(self, action: #selector(resignTextField))
        imageCollectionView.backgroundView = background
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

// MARK: SearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            //show alert
            self.showAlert(title: "Error searching", message: "Could not find what was searched. Check spelling or search text.")
            return
        }
        
        searchText = text
        page = 1
        search(searchText: searchText)
        nasaDataCollection = [Item]()
    }
}

// MARK: CollectionViewDelegateFlowLayout

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing: CGFloat = 20
        let maxWidth = UIScreen.main.bounds.size.width
        let numberOfItems: CGFloat = 3
        let totalSpacing: CGFloat = numberOfItems * interItemSpacing
        let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfItems
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) ->  UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 8, bottom: 20, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 8
    }
    
}

// MARK: CollectionViewDelegate, CollectionViewDataSourceDataSource

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return nasaDataCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCell else {
            fatalError("could not return ImageCell")
        }
        
        let item = nasaDataCollection[indexPath.row]
        
        cell.imageCellImageView.layer.cornerRadius = 10
        collectionViewCellShadowSetup(cell: cell)
        
        if let link = item.links?.first?.href {
            cell.configureCell(with: link)
        }
        
        //checks current row to see if it's the last item within the collection to add data onto the current data array for pagination
        if indexPath.row == nasaDataCollection.count - 1 {
            page += 1
            
            search(searchText: searchText, page: page)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nasaData = nasaDataCollection[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            fatalError("no segue")
        }
        detailVC.nasaImageDetails = nasaData
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
