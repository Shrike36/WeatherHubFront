//
//  SuccessPresenter.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 30.10.2021.
//

import UIKit

public protocol SuccessPresenter {
    func showSuccess(completion: EmptyClosure?)
    func hideSuccess()
}

extension SuccessPresenter where Self: UIViewController {

    func showSuccess(completion: EmptyClosure?) {
        showSuccessView(completion: completion)
    }

    func hideSuccess() {
        hideSuccessView()
    }

}
