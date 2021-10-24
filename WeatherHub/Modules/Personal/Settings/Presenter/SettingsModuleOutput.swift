//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

protocol SettingsModuleOutput: AnyObject {
    var onLoginRequested: EmptyClosure? { get set }
}
