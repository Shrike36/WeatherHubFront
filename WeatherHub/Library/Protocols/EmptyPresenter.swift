//
//  EmptyPresenter.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 31.10.2021.
//

import UIKit

public protocol EmptyPresenter {
    func showEmpty(text: String)
    func hideEmpty()
}

extension EmptyPresenter where Self: UIViewController {

    func showEmpty(text: String) {
        showEmptyView(with: text)
    }

    func hideEmpty() {
        hideEmptyView()
    }

}
