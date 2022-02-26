//
//  UIViewControllerExtension.swift
//  DigitalShowroom
//
//  Created by Vikas Kharb on 30/01/2022.
//

import UIKit

extension UIViewController {
    func showAlert(for error: NetworkRequestError, actions: [UIAlertAction]? = nil, completion: (()-> Void)? = nil) {
        let alert = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
        
        let availableActions = actions ?? [UIAlertAction(title: "OK", style: .destructive, handler: nil)]
        availableActions.forEach { alert.addAction($0) }
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: completion)
        }
    }
    
    func showActivity(){
        let activity = UIActivityIndicatorView(frame: .zero)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.tag = -2000
        view.addSubview(activity)
        
        NSLayoutConstraint.activate([
            activity.heightAnchor.constraint(equalToConstant: 100),
            activity.widthAnchor.constraint(equalToConstant: 100),
            activity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        activity.startAnimating()
    }
    
    func hideActivity() {
        guard let indicator = view.subviews.filter({ $0.tag == -2000 }).first else {
            return
        }
        indicator.removeFromSuperview()
    }
    
    
}
