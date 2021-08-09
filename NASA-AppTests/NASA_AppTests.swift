//
//  NASA_AppTests.swift
//  NASA-AppTests
//
//  Created by Maitree Bain on 8/3/21.
//

import XCTest
@testable import NASA_App

class NASA_AppTests: XCTestCase {
    
    func testItemTitle() {
        let title = "APOLLO 50th_FULL COLOR_300DPI"
        let search = "apollo"
        let expectation = XCTestExpectation(description: "searches found")
        
        NASAAPIClient.shared.getNASAItems(searchText: search) { (result) in
            
            switch result {
            case .success(let items):
                let first = items.first?.data.first?.title
                expectation.fulfill()
                XCTAssertEqual(first, title, "\(title) is expected to be \(String(describing: first))")
            case .failure(let error):
                print(error)
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testSearchMars() {
        let search = "mars"
        let expectation = XCTestExpectation(description: "searches found")
        
        NASAAPIClient.shared.getNASAItems(searchText: search) { (result) in
            
            switch result {
            case .success(let items):
                expectation.fulfill()
                XCTAssertGreaterThan(items.count, 80000)
            case .failure(let error):
                print(error)
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testImageLink() {
        let link = "https://images-assets.nasa.gov/image/PIA12235/PIA12235~thumb.jpg"
        let search = "moon"
        let expectation = XCTestExpectation(description: "link found")
        
        NASAAPIClient.shared.getNASAItems(searchText: search) { (result) in
            
            switch result {
            case .success(let items):
                expectation.fulfill()
                if let imageURL = items.first?.links?.first?.href {
                    XCTAssertEqual(link, imageURL)
                }
            case .failure(let error):
                print(error)
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testJSON() {
        
        let jsonData =
            """
        {
        "collection": {
        "href": "http://images-api.nasa.gov/search?media_type=image&q=mars",
        "items": [{
            "href": "https://images-assets.nasa.gov/image/NHQ201905310026/collection.json",
            "data": [{
                "date_created": "2019-05-31T00:00:00Z",
                "photographer": "NASA/Bill Ingalls",
                "location": "Mars, PA, USA",
                "center": "HQ",
                "title": "Mars Celebration",
                "keywords": [
                    "Mars",
                    "Mars Celebration",
                    "Pennsylvania"
                ],
                "media_type": "image",
                "description": "The Mars celebration Friday, May 31, 2019, in Mars, Pennsylvania. NASA is in the small town to celebrate Mars exploration and share the agency’s excitement about landing astronauts on the Moon in five years. The celebration includes a weekend of Science, Technology, Engineering, Arts and Mathematics (STEAM) activities. Photo Credit: (NASA/Bill Ingalls)",
                "nasa_id": "NHQ201905310026"
            }],
            "links": [{
                "href": "https://images-assets.nasa.gov/image/NHQ201905310026/NHQ201905310026~thumb.jpg",
                "rel": "preview",
                "render": "image"
            }]
        }]
        }

        }
        """.data(using: .utf8)!
        let expectedHrefCount = 1
        
        do {
            let hrefURL = try JSONDecoder().decode(NASACollection.self, from: jsonData)
            XCTAssertEqual(hrefURL.collection.items.count, expectedHrefCount, "there should be \(expectedHrefCount) created")
        } catch {
            XCTFail("decoding error: \(error)")
        }
    }
  
}
