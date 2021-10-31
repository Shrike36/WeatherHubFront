//
//  UIViewController+Empty.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 31.10.2021.
//

import Foundation
import UIKit

public extension UIViewController {

    var emptyView: UIView? {
        view.viewWithTag(EmptyView.tag)
    }

    func showEmptyView(with text: String) {
        guard emptyView == nil else {
            return
        }
        let emptyView = EmptyView()
        emptyView.configure(with: text)
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.tag = EmptyView.tag
        emptyView.alpha = 0
        view.addSubview(emptyView)
        NSLayoutConstraint.activate([
            emptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        UIView.animate(withDuration: 0.3) {
            emptyView.alpha = 1
        }
    }

    func hideEmptyView() {
        guard let emptyView = emptyView else {
            return
        }
        UIView.animate(withDuration: 0.3) {
            emptyView.alpha = 0
        } completion: { _ in
            emptyView.removeFromSuperview()
        }

    }

}
