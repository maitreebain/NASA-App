//
//  UIImage+Extensions.swift
//  NASA-App
//
//  Created by Maitree Bain on 8/5/21.
//

import UIKit

extension UIViewController {
    
    public func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true)
    }
    
}
