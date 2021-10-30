//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

protocol PasswordResetModuleOutput: AnyObject {
    var onBackPressed: EmptyClosure? { get set }
    var onErrorOccured: Closure<DetailedError>? { get set }
    var onRequestSuccess: Closure<PasswordResetRequestEntity>? { get set }
}
