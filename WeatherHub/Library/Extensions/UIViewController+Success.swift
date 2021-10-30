//
//  UIViewController+Success.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 30.10.2021.
//

import UIKit
import SurfUtils

public extension UIViewController {

    var successView: UIView? {
        view.viewWithTag(SuccessView.tag)
    }

    func showSuccessView(completion: EmptyClosure?) {
        guard successView == nil else {
            return
        }
        let successView = SuccessView(frame: view.bounds)
        successView.tag = SuccessView.tag
        successView.alpha = 0
        successView.hideCompletion = completion
        view.addSubview(successView)
        UIView.animate(withDuration: 0.3) {
            successView.alpha = 1
        } completion: { _ in
            VibrationFeedbackManager.playHapticFeedbackBy(type: .success)
            DispatchQueue.main.asyncAfter(deadline: .now() + SuccessView.showDuration) { [weak self] in
                self?.hideSuccessView()
            }
        }

    }

    func hideSuccessView() {
        guard let successView = successView as? SuccessView else {
            return
        }
        UIView.animate(withDuration: 0.3) {
            successView.alpha = 0
        } completion: { _ in
            successView.removeFromSuperview()
            successView.hideCompletion?()
        }

    }

}
