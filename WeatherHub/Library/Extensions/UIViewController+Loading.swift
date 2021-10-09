//
//  UIViewController+loading.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import Foundation
import UIKit

public extension UIViewController {

    var loadingView: UIView? {
        view.viewWithTag(LoadingView.tag)
    }

    func showLoadingView() {
        guard loadingView == nil else {
            return
        }
        let loadingView = LoadingView(frame: view.bounds)
        loadingView.tag = LoadingView.tag
        loadingView.alpha = 0
        view.addSubview(loadingView)
        UIView.animate(withDuration: 0.3) {
            loadingView.alpha = 1
        }
    }

    func hideLoadingView() {
        guard let loadingView = loadingView else {
            return
        }
        UIView.animate(withDuration: 0.3) {
            loadingView.alpha = 0
        } completion: { _ in
            loadingView.removeFromSuperview()
        }

    }

}
