//
//  Copyright © 2021 Surf. All rights reserved.
//

protocol NewPasswordModuleOutput: AnyObject {
    var onBackPressed: EmptyClosure? { get set }
    var onErrorOccured: Closure<DetailedError>? { get set }
    var onRequestSuccess: EmptyClosure? { get set }
}
