//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

protocol AuthModuleOutput: AnyObject {
    var onErrorOccured: Closure<DetailedError>? { get set }
    var onAuthSuccess: EmptyClosure? { get set }
}
