//
//  LoadingPresenter.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 09.10.2021.
//

import UIKit

public protocol LoadingPresenter {
    func showLoading()
    func hideLoading()
}

extension LoadingPresenter where Self: UIViewController {

    func showLoading() {
        showLoadingView()
    }

    func hideLoading() {
        hideLoadingView()
    }

}
