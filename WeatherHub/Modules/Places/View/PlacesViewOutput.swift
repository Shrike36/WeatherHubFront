//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

protocol PlacesViewOutput {
    /// Notify presenter that view is ready
    func viewLoaded()
    /// User requested current location
    func handleLocationRequested()
}
