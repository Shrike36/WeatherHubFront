//
//  Copyright © 2021 Surf. All rights reserved.
//

protocol NewPasswordViewInput: AnyObject, LoadingPresenter, SuccessPresenter {
    var codeValue: String? { get }
    var passwordValue: String? { get }
    var isPasswordRepeated: Bool { get }

    func setupInitialState()
}
