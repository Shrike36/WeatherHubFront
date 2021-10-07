//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

protocol TabBarModuleOutput: AnyObject {

    var onTabSelected: Closure<MainTab>? { get set }

}
