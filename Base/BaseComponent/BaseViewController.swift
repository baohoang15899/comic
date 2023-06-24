//
//  BaseViewController.swift
//  Base
//
//  Created by BaoHoang on 14/10/2022.
//

import Foundation
import UIKit

class BaseViewController<T: BaseViewModel>: UIViewController, BindableType {
    
    var viewModel: T!
    private var overlay = UIView() // This should be a class variable
    
    private func addLoadingView() {
        var spinner = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
             spinner = UIActivityIndicatorView(style: .large)
        } else {
            // Fallback on earlier versions
             spinner = UIActivityIndicatorView(style: .whiteLarge)
        }
        overlay.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        overlay.backgroundColor = .black
        overlay.alpha = 0.4
        
        overlay.addSubview(spinner)
        spinner.color = .white
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.centerXAnchor.constraint(equalTo: self.overlay.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.overlay.centerYAnchor).isActive = true
        
        view.addSubview(overlay)
    }
    
    private func removeLoadingView() {
        overlay.removeFromSuperview()
    }
    
    func bindViewModel() {
        
    }
    
    func setupLoadingView(isLoading: Bool) {
        if (isLoading) {
            addLoadingView()
        } else {
            removeLoadingView()
        }
    }
}
