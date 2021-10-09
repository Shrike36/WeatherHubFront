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
//        let searchResults = completer.results.compactMap { getCity(from: $0) }
        view?.fillResults(completer.results.map { SearchResult(title: $0.title, subtitle: $0.subtitle) })
    }

}

// MARK: - Private Methods

private extension PlaceSearchPresenter {

}
