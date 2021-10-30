//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

protocol AuthViewInput: AnyObject, LoadingPresenter, SuccessPresenter {
    var emailValue: String? { get }
    var passwordValue: String? { get }
    var isPasswordRepeated: Bool { get }

    func setupInitialState()
    func setState(_ state: AuthViewController.State, animated: Bool)
}
