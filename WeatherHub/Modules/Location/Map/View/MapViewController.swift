//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import SurfUtils
import MapKit
import UIKit

final class MapViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var actionButton: CommonButton!

    // MARK: - Properties

    var output: MapViewOutput?

    // MARK: - Private Properties

    private var currentPin: MKPointAnnotation? {
        didSet {
            actionButton.isHidden = currentPin == nil
        }
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - MapViewInput

extension MapViewController: MapViewInput {

    func setupInitialState() {
        mapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMapTap(gestureRecognizer:))))

        actionButton.setTitle(L10n.Map.select, for: .normal)
        actionButton.applyActionStyle()
        actionButton.isHidden = true
    }

    func showLocation(_ location: CLLocation) {
        mapView.centerToLocation(location)
    }

}

// MARK: - Private Methods

private extension MapViewController {

}

// MARK: - Actions

private extension MapViewController {

    @IBAction func handleClosePressed() {
        dismiss(animated: true)
    }

    @IBAction func handleActionPressed() {
        guard let selectedPlace = currentPin else {
            return
        }
        output?.handleLocationSelected(selectedPlace.coordinate)
    }

    @objc func handleMapTap(gestureRecognizer: UITapGestureRecognizer) {
        if let oldPinAnnotation = currentPin {
            mapView.removeAnnotation(oldPinAnnotation)
        }

        let touchLocation = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)

        let pinAnnotation = MKPointAnnotation()
        pinAnnotation.coordinate = coordinate
        currentPin = pinAnnotation
        mapView.addAnnotation(pinAnnotation)
    }

}

// MARK: - MKMapView

private extension MKMapView {

    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 100 * 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }

}
