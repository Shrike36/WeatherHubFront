import UIKit
import CoreLocation

typealias MonitoringStatusChange = (enabled: Bool, systemInitiated: Bool)

struct LocationObserver {

    // MARK: - Properties

    var locationChangedHandler: Closure<[CLLocation]>?
    var headingChangedHandler: Closure<CLHeading>?
    var locationMonitoringStatusHandler: Closure<MonitoringStatusChange>?
    var headingMonitoringStatusHandler: Closure<MonitoringStatusChange>?
    var authStatusChangeHandler: Closure<CLAuthorizationStatus>?
    var errorHandler: Closure<Error>?
    let identifier: String

    // MARK: - Initializers

    init(identifier: String) {
        self.identifier = identifier
    }

}

extension LocationObserver: Equatable {

    static func == (lhs: LocationObserver, rhs: LocationObserver) -> Bool {
        return lhs.identifier == rhs.identifier
    }

}

extension LocationObserver: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

}

final class LocationManager: NSObject {

    // MARK: - Properties

    var currentLocation: CLLocation? {
        return underlyingLocationManager.location
    }

    var currentAuthStatus: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }

    var locationServicesEnabled: Bool {
        return CLLocationManager.locationServicesEnabled()
    }

    // MARK: - Private Propherties

    private var underlyingLocationManager: CLLocationManager
    private var locationObservers: Set<LocationObserver>

    // MARK: - Initializers

    init(with accuracy: CLLocationAccuracy = kCLLocationAccuracyNearestTenMeters,
         distanceFilter: CLLocationDistance = 100.0) {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = accuracy
        locationManager.distanceFilter = distanceFilter
        self.underlyingLocationManager = locationManager
        self.locationObservers = Set()

        super.init()
        self.underlyingLocationManager.delegate = self
    }

    // MARK: - methods

    func requestAuthorization() {
        underlyingLocationManager.requestWhenInUseAuthorization()
    }

    func startLocationMonitoring() {
        underlyingLocationManager.startUpdatingLocation()
    }

    func stopLocationMonitoring() {
        underlyingLocationManager.stopUpdatingLocation()
    }

    func startHeadingMonitoring() {
        underlyingLocationManager.startUpdatingHeading()
    }

    func stopHeadingMonitoring() {
        underlyingLocationManager.stopUpdatingHeading()
    }

    func addLocationObserver(observer: LocationObserver) {
        locationObservers.insert(observer)
    }

    func removeLocationObserver(observer: LocationObserver) {
        locationObservers.remove(observer)
    }

    func removeLocationObserver(observerID: String) {
        removeLocationObserver(observer: LocationObserver(identifier: observerID))
    }

    func getPermissionCustomAlert() -> UIAlertController {
        let openSettings = UIAlertAction(title: "Настройки", style: .default) { _ in
            guard let url = URL(string: UIApplication.openSettingsURLString),
                  UIApplication.shared.canOpenURL(url) else {
                return
            }
            UIApplication.shared.open(url)
        }
        let cancel = UIAlertAction(title: "Закрыть", style: .cancel)

        let alert = UIAlertController(
            title: "",
            message: "Включите в настройках доступ к геопозиции для определения вашего местоположения.",
            preferredStyle: .alert
        )

        alert.addAction(cancel)
        alert.addAction(openSettings)

        return alert
    }

    // MARK: - Private methods

    private func notifyObserversAboutLocationMonitoringChange(enabled: Bool, systemInitiated: Bool = false) {
        locationObservers.forEach { observer in
            observer.locationMonitoringStatusHandler?((enabled, systemInitiated))
        }
    }

    private func notifyObserversAboutAuthStatusChange(authStatus: CLAuthorizationStatus) {
        locationObservers.forEach { observer in
            observer.authStatusChangeHandler?(authStatus)
        }
    }

    private func notifyObserversAboutLocationChange(locations: [CLLocation]) {
        locationObservers.forEach { observer in
            observer.locationChangedHandler?(locations)
        }
    }

    private func notifyObserversAboutHeadingChange(heading: CLHeading) {
        locationObservers.forEach { observer in
            observer.headingChangedHandler?(heading)
        }
    }

    private func notifyObserversAboutError(error: Error) {
        locationObservers.forEach { observer in
            observer.errorHandler?(error)
        }
    }

}

extension LocationManager: CLLocationManagerDelegate {

    func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        notifyObserversAboutLocationMonitoringChange(enabled: true, systemInitiated: true)
    }

    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        notifyObserversAboutLocationMonitoringChange(enabled: false, systemInitiated: true)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        notifyObserversAboutLocationChange(locations: locations)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        notifyObserversAboutHeadingChange(heading: newHeading)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        notifyObserversAboutAuthStatusChange(authStatus: status)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        notifyObserversAboutError(error: error)
    }

}
