//
//  UIViewController+Extension.swift
//  NASAPicOftheDAy
//
//  Created by Ruthwick S Rai on 12/02/22.
//

import Foundation
import UIKit

// MARK: - Simple methods for handling errors/warnings/prompts
extension UIViewController {
    func showAlert(title: String, message: String, style: UIAlertController.Style) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String, style: UIAlertController.Style, sender: UIView) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        alertController.modalPresentationStyle = .popover
        if let presenter = alertController.popoverPresentationController {
            presenter.sourceView = sender
            presenter.sourceRect = sender.bounds
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showRemovePrompt(title: String?, message: String?, completion: @escaping (String?) -> Void) {
        let promptController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Remove?", style: .destructive) { action in
            completion("")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        promptController.addAction(okAction)
        promptController.addAction(cancelAction)
        self.present(promptController, animated: true, completion: nil)
    }

    func showAlertAndDismiss(title: String, message: String, style: UIAlertController.Style) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            self.dismiss(animated: true)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func dismiss(animated: Bool) {
        _ = navigationController?.popViewController(animated: animated)
    }
}
