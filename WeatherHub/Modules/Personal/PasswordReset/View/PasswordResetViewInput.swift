//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

protocol PasswordResetViewInput: AnyObject, LoadingPresenter {
    var emailValue: String? { get }

    func setupInitialState()
}
