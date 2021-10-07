//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

protocol PlacesViewOutput {
    func viewLoaded()
    func handleLocationRequested()
    func handleSearchNeeded()
    func handleMapNeeded()
}
