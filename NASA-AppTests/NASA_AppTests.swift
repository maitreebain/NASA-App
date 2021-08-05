//
//  NASA_AppTests.swift
//  NASA-AppTests
//
//  Created by Maitree Bain on 8/3/21.
//

import XCTest
@testable import NASA_App

class NASA_AppTests: XCTestCase {
    
    func testItems() {
        let title = "Apollo Footprint"
        let search = "apollo"
        
        NASACollection.getNASAImages(searchText: search) { (result) in
            
            switch result {
            case .success(let items):
                let first = items.first?.data.first?.title
                XCTAssertEqual(first, title, "\(title) is expected to be \(String(describing: first))")
            case .failure(let error):
               print(error)
            }
        }
    }
}
