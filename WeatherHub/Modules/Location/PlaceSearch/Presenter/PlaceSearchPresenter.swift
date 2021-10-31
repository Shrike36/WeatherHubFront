//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import MapKit

final class PlaceSearchPresenter: NSObject, PlaceSearchModuleOutput {

    // MARK: - PlaceSearchModuleOutput

    var onLocationSelected: Closure<CLLocationCoordinate2D>?

    // MARK: - Properties

    weak var view: PlaceSearchViewInput?

    // MARK: - Private Properties

    private let searchCompleter = MKLocalSearchCompleter()
    private var search: MKLocalSearch?

    private let analyticsService = FirebaseService()

}

// MARK: - PlaceSearchModuleInput

extension PlaceSearchPresenter: PlaceSearchModuleInput {
}

// MARK: - PlaceSearchViewOutput

extension PlaceSearchPresenter: PlaceSearchViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
        searchCompleter.delegate = self
        searchCompleter.region = MKCoordinateRegion(.world)
        searchCompleter.resultTypes = .address
        analyticsService.track(event: .searchOpen)
    }

    func inputChanged(text: String) {
        searchCompleter.queryFragment = text
    }

    func resultSelected(at index: Int) {
        let result = searchCompleter.results[index]
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = result.title + ", " + result.subtitle
        request.pointOfInterestFilter = .none
        request.resultTypes = .address
        search = MKLocalSearch(request: request)
        search?.start(completionHandler: { [weak self] response, _ in
            guard
                let response = response,
                let selectedPlace = response.mapItems.filter({ $0.placemark.locality != nil }).first
            else {
                return
            }
            self?.onLocationSelected?(selectedPlace.placemark.coordinate)
        })
    }

}

extension PlaceSearchPresenter: MKLocalSearchCompleterDelegate {

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        view?.fillResults(completer.results.map { PlaceViewModel(title: $0.title, subtitle: $0.subtitle) })
    }

}
