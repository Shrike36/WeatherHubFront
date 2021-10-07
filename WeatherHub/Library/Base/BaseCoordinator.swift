import Foundation

open class BaseCoordinator {

    // MARK: - Private Properties

    private var childCoordinators: [BaseCoordinator] = []
    private weak var parentCoordinator: BaseCoordinator?

    // MARK: - Initialization

    public init() {}

    // MARK: - Coordinator

    open func start() {
    }

    // MARK: - Public Methods

    public func addDependency(_ coordinator: BaseCoordinator) {
        guard !haveDependency(coordinator) else {
            return
        }
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
    }

    public func removeDependency(_ coordinator: BaseCoordinator?) {
        guard
            !childCoordinators.isEmpty,
            let coordinator = coordinator
        else {
            return
        }

        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }

    public func removeAllDependencies() {
        childCoordinators.removeAll()
    }

}

// MARK: - Private Methods

private extension BaseCoordinator {

    func haveDependency(_ coordinator: BaseCoordinator) -> Bool {
        for element in childCoordinators where element === coordinator {
            return true
        }
        return false
    }

}
