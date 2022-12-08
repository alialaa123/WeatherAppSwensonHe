//
//  HomeRootViewController.swift
//  WeatherAppSwensonHe
//
//  Created by Ali Alaa on 07/12/2022.
//

import UIKit
import AppUIKit
import CoreKit
import Combine
import Kingfisher

class HomeRootViewController: NiblessViewController {
    
    // MARK: - Properties
    private let customView: HomeRootView
    private let viewModel: HomeRootViewModel
    
    // Subscriptions
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Life cycle
    public init(customView: HomeRootView, viewModel: HomeRootViewModel) {
        self.customView = customView
        self.viewModel = viewModel
        
        super.init()
    }
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.searchButton.addTarget(viewModel, action: #selector(HomeRootViewModel.gotoSearchView), for: .touchUpInside)
//        observeErrorMessages()
        bindCountryField(to: viewModel.forecastWeatherData)
        bindCurrentTempField(to: viewModel.forecastWeatherData)
        bindCurrentWeatherDescriptionField(to: viewModel.forecastWeatherData)
        bindCurrentWindField(to: viewModel.forecastWeatherData)
        bindCurrentDropLetField(to: viewModel.forecastWeatherData)
        bindCurrentForecastWeatherField(to: viewModel.forecastWeatherData)
        bindTomorrowForecastWeatherField(to: viewModel.forecastWeatherData)
        bindDayAfterTomorrowForecastWeatherField(to: viewModel.forecastWeatherData)
        bindCurrentIconWeatherField(to: viewModel.forecastWeatherData)
        bindTomorrowDayForecastIconWeatherField(to: viewModel.forecastWeatherData)
        bindDayAfterTomorrowForecastIconWeatherField(to: viewModel.forecastWeatherData)
        bindDayAfterTomorrowForecastDayLabelWeatherField()
    }
    
    // MARK: - Methods
    private func bindCountryField(to publisher: AnyPublisher<WeatherModel, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .map { $0.location?.name }
            .assign(to: \.text, on: customView.cityNameLabel)
            .store(in: &subscriptions)
    }
    
    private func bindCurrentTempField(to publisher: AnyPublisher<WeatherModel, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .map { $0.current?.tempF }
            .map { "\(Int($0 ?? 0.0))° F" }
            .assign(to: \.text, on: customView.currentWeatherTempLabel)
            .store(in: &subscriptions)
    }
    
    private func bindCurrentWeatherDescriptionField(to publisher: AnyPublisher<WeatherModel, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .map { $0.current?.condition?.condition }
            .map { "It's \($0 ?? "") day." }
            .assign(to: \.text, on: customView.currentWeatherDescriptionLabel)
            .store(in: &subscriptions)
    }
    
    private func bindCurrentWindField(to publisher: AnyPublisher<WeatherModel, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .map { $0.current?.windInMph }
            .map { "\(Int($0 ?? 0.0)) mph" }
            .assign(to: \.text, on: customView.windLabel)
            .store(in: &subscriptions)
    }
    
    private func bindCurrentDropLetField(to publisher: AnyPublisher<WeatherModel, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .map { $0.current?.humidity }
            .map { "\(Int($0 ?? 0.0)) %" }
            .assign(to: \.text, on: customView.dropLetLabel)
            .store(in: &subscriptions)
    }
    
    private func bindCurrentForecastWeatherField(to publisher: AnyPublisher<WeatherModel, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .map { "\($0.forecast?.forecastday?.first?.day?.avgtempC ?? 0.0)°/\($0.forecast?.forecastday?.first?.day?.avgtempF ?? 0.0)°F" }
            .assign(to: \.text, on: customView.currentDayWeatherDataLabel)
            .store(in: &subscriptions)
    }
    
    private func bindTomorrowForecastWeatherField(to publisher: AnyPublisher<WeatherModel, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .map { "\($0.forecast?.forecastday?[1].day?.avgtempC ?? 0.0)°/\($0.forecast?.forecastday?[1].day?.avgtempF ?? 0.0)°F" }
            .assign(to: \.text, on: customView.tomorrowDayWeatherDataLabel)
            .store(in: &subscriptions)
    }
    
    private func bindDayAfterTomorrowForecastWeatherField(to publisher: AnyPublisher<WeatherModel, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .map { "\($0.forecast?.forecastday?[2].day?.avgtempC ?? 0.0)°/\($0.forecast?.forecastday?[2].day?.avgtempF ?? 0.0)°F" }
            .assign(to: \.text, on: customView.dayAftertomorrowWeatherDataLabel)
            .store(in: &subscriptions)
    }

    private func bindCurrentIconWeatherField(to publisher: AnyPublisher<WeatherModel, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                guard let strongSelf = self else { return }
                let image = "https:" + ($0.current?.condition?.icon ?? "")
                strongSelf.customView.weatherCurrentImage.loadImage(URL(string: image))
                strongSelf.customView.currentDayDataImage.loadImage(URL(string: image))
            })
            .store(in: &subscriptions)
    }
    
    private func bindTomorrowDayForecastIconWeatherField(to publisher: AnyPublisher<WeatherModel, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                guard let strongSelf = self else { return }
                let image = "https:" + ($0.forecast?.forecastday?[1].day?.condition?.icon ?? "")
                strongSelf.customView.tomorrowDayDataImage.loadImage(URL(string: image))
            })
            .store(in: &subscriptions)
    }
    
    private func bindDayAfterTomorrowForecastIconWeatherField(to publisher: AnyPublisher<WeatherModel, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                guard let strongSelf = self else { return }
                let image = "https:" + ($0.forecast?.forecastday?[2].day?.condition?.icon ?? "")
                strongSelf.customView.dayAfterTomorrowDataImage.loadImage(URL(string: image))
            })
            .store(in: &subscriptions)
    }
    
    private func bindDayAfterTomorrowForecastDayLabelWeatherField() {
        let dateAfterTomorrowDate = Date.dayAfterTomorrow
        let tomorrowDate = Date.tomorrow
        let currentDate = Date.today
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayAfterTomorrow = dateFormatter.string(from: dateAfterTomorrowDate)
        let tomorrowDay = dateFormatter.string(from: tomorrowDate)
        let currentday = dateFormatter.string(from: currentDate)
        
        customView.dayAftertomorrowLabel.text = dayAfterTomorrow
        customView.tomorrowDayLabel.text = tomorrowDay
        customView.currentDayLabel.text = currentday
        
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .long
        customView.dateLabel.text = "\(currentday), \(dateFormatter.string(from: currentDate))"
        
        let currentTime = Date()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        customView.timeLabel.text = "\(dateFormatter.string(from: currentTime))"
    }
    
    func observeErrorMessages() {
        viewModel.errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                guard let strongSelf = self else { return }
                strongSelf.present(errorMessage: errorMessage,
                                   withPresentationState: strongSelf.viewModel.errorPresentation)
            }.store(in: &subscriptions)
    }
    
}
