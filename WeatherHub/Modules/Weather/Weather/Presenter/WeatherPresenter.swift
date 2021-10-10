//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import Foundation
import CoreLocation

final class WeatherPresenter: WeatherModuleOutput {

    // MARK: - Constants

    private enum Constants {
        static let days = 5
    }

    // MARK: - WeatherModuleOutput

    // MARK: - Properties

    weak var view: WeatherViewInput?

    // MARK: - Private properties

    private var isViewReady = false
    private var dateIndex = 0

    private var place: CLPlacemark!
    private var viewModel: WeatherScreenViewModel!

    private var interactors = WeatherSupplier.allCases.map { WeatherInteractor(service: $0.makeService()) }

}

// MARK: - WeatherModuleInput

extension WeatherPresenter: WeatherModuleInput {

    func showWeather(for place: CLPlacemark) {
        self.place = place
        interactors.forEach {
            $0.getForecast(for: place.location!.coordinate) { [weak self] in
                self?.updateViewIfResponsesAreReady()
            }

        }
    }

}

// MARK: - WeatherViewOutput

extension WeatherPresenter: WeatherViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
    }

    func layoutFinished() {
        isViewReady = true
        viewModel = mockViewModel
        view?.configure(with: viewModel)
        view?.setDateChangeButtonsVisisble(left: false, right: true)
    }

    func prevDateAsked() {
        guard dateIndex > 0 else {
            return
        }
        dateIndex -= 1
        updateDate()
        view?.setDateScrollIndex(dateIndex)
    }

    func nextDateAsked() {
        let daysTotal = viewModel.dates.count
        guard dateIndex + 1 < daysTotal else {
            return
        }
        dateIndex += 1
        updateDate()
        view?.setDateScrollIndex(dateIndex)
    }

    func scrolledToIndex(_ index: Int) {
        guard index != dateIndex else {
            return
        }
        dateIndex = index
        updateDate()
    }

}

// MARK: - Private methods

private extension WeatherPresenter {

    func updateDate() {
        view?.setDateText(viewModel.dates[dateIndex].date)
        view?.setDateChangeButtonsVisisble(left: dateIndex > 0, right: dateIndex + 1 < viewModel.dates.count)
    }

    func resetResponseReceiveFlags() {
        interactors.forEach { $0.resetState() }
    }

    func updateViewIfResponsesAreReady() {
        if interactors.allSatisfy({ $0.isUpdated }) {
            viewModel = actualViewModel
            view?.configure(with: viewModel)
            resetResponseReceiveFlags()
        }
    }

}

// MARK: - Demo

private extension WeatherPresenter {

    var mockViewModel: WeatherScreenViewModel {
        let startDay = 0
        let endDay = 1
        let days = Array(startDay...endDay).map { Calendar.current.date(byAdding: .day, value: $0, to: Date())! }
        let suppliers = [L10n.Common.yandex]
        let dates = days.map { date -> DateViewModel in
            let weather = suppliers.map { name -> WeatherViewModel in
                let temperature = Int.random(in: -20...30)
                let nightTemperature = temperature - .random(in: 1...10)
                return WeatherViewModel(serviceName: name,
                                        weatherConditions: WeatherConditions.allCases.randomElement()!,
                                        dayTemperature: temperature,
                                        nightTemperature: nightTemperature)
            }
            return DateViewModel(date: date, weather: weather)
        }
        return WeatherScreenViewModel(cityName: "Санкт-Петербург", dates: dates)
    }

    var actualViewModel: WeatherScreenViewModel {
        let days = Array(0...Constants.days).map {
            Calendar.current.date(byAdding: .day, value: $0, to: Date())!
        }

        let dates = days.enumerated().map { (index, date) -> DateViewModel in
            return DateViewModel(date: date,
                                 weather: interactors.compactMap { $0.response?.getForecastForDay(index: index) })
        }

        return WeatherScreenViewModel(cityName: place.locality!, dates: dates)
    }

}
