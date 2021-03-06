//
//  Copyright © 2020 Surf. All rights reserved.
//

/// Describes object that handles all navigation operations
public protocol Router {
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool, completion: (() -> Void)?)

    func push(_ module: Presentable?)
    func push(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?, animated: Bool, completion: @escaping () -> Void)

    func popModule()
    func popModule(animated: Bool)
    func popModule(animated: Bool, completion: @escaping EmptyClosure)
    func popPreviousView()
    func popToRoot(animated: Bool)
    func popToRoot(animated: Bool, completion: @escaping EmptyClosure)

    func dismissModule()
    func dismissModule(from module: Presentable?)
    func dismissModule(animated: Bool, completion: (() -> Void)?)
    func dismissAll(animated: Bool, completion: (() -> Void)?)

    func setNavigationControllerRootModule(_ module: Presentable?, animated: Bool, hideBar: Bool)
    func setRootModule(_ module: Presentable?)

    func setTab(_ index: Int)

}
