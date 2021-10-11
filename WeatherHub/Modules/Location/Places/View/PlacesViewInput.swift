//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

protocol PlacesViewInput: AnyObject, LoadingPresenter {
    func setupInitialState()
    func fillPlaces(_ places: [PlaceViewModel])
}
