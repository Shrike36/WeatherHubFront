//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import Foundation

final class WeatherPresenter: WeatherModuleOutput {

    // MARK: - WeatherModuleOutput

    // MARK: - Properties

    weak var view: WeatherViewInput?

    // MARK: - Private properties

    private var isViewReady = false
    private var dateIndex = 0

    private var viewModel: WeatherScreenViewModel!

}

// MARK: - WeatherModuleInput

extension WeatherPresenter: WeatherModuleInput {
}

// MARK: - WeatherViewOutput

extension WeatherPresenter: WeatherViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
    }

    func layoutFinished() {
        isViewReady = true
        view?.configure(with: mockViewModel)
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

}

// MARK: - Demo

private extension WeatherPresenter {

    var mockViewModel: WeatherScreenViewModel {
        let startDay = 0
        let endDay = 10
        let days = Array(startDay...endDay).map { Calendar.current.date(byAdding: .day, value: $0, to: Date())! }
        let suppliers = ["Yandex Weather", "OpenWeatherMap", "Gismeteo", "Test", "Test2"]
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
        viewModel = WeatherScreenViewModel(cityName: "Санкт-Петербург", dates: dates)
        return viewModel!
    }

}
