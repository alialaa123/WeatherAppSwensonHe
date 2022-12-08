//
//  SearchViewModel.swift
//  CoreKit
//
//  Created by Ali Alaa on 08/12/2022.
//

import Foundation
import Combine

public final class SearchViewModel {
    
    // MARK: - Properties
    // State
    @Published public private(set) var isLoading = false
    @Published public private(set) var selectedCountry = ""
    @Published public private(set) var isEmptyData = false
    
    // Subjects
    private let searchSubject = CurrentValueSubject<String?, Never>(nil)
    public var searchSubjectSubscriber: AnySubscriber<String?, Never> {
        AnySubscriber(searchSubject)
    }
    
    private let dismissViewSubject = PassthroughSubject<Void, Never>()
    public var dismissView: AnySubscriber<Void, Never> {
        AnySubscriber(dismissViewSubject)
    }
    public var dismissViewPublisher: AnyPublisher<Void, Never> {
        dismissViewSubject.eraseToAnyPublisher()
    }
    
    
    public let errorPresentation = PassthroughSubject<ErrorPresentation?, Never>()
    private let erroMessageSubject = PassthroughSubject<ErrorMessage, Never>()
    public var errorMessage: AnyPublisher<ErrorMessage, Never> {
        erroMessageSubject.eraseToAnyPublisher()
    }
    
    private let countryDataSubject = CurrentValueSubject<[Country], Never>([])
    public var countryData: AnyPublisher<[Country], Never> {
        countryDataSubject.eraseToAnyPublisher()
    }
    
    private let selectItemFromTableViewSubject = PassthroughSubject<Int, Never>()
    public var selectItemFromTableViewSubscriber: AnySubscriber<Int, Never> {
        AnySubscriber(selectItemFromTableViewSubject)
    }
    
    // State
    var subscriptions = Set<AnyCancellable>()
    
    private let repository: WeatherRepository
    
    // MARK: - Life cycle
    public init(repository: WeatherRepository) {
        self.repository = repository
        subscribeToSearchSubject()
        subsribeToSelectedItem()
    }
    
    // MARK: - Methods
    private func getSearchCountriesWeather(query: String?) {
        isLoading = true
        guard let queryText = query else { return }
        repository.getCountry(query: queryText)
            .sink { [weak self] in
                guard let strongSelf = self else { return }
                switch $0 {
                case .finished: break
                case .failure(let error):
                    strongSelf.erroMessageSubject.send(error)
                    strongSelf.isEmptyData = strongSelf.countryDataSubject.value.isEmpty
                }
            } receiveValue: { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.countryDataSubject.send($0)
            }
            .store(in: &subscriptions)
    }
    
    // start to search for data if text more than 2 character
    private func loadData(with queryText: String) {
        if queryText.count >= 2 {
            getSearchCountriesWeather(query: queryText)
        }
    }
    
    private func subscribeToSearchSubject() {
        searchSubject.eraseToAnyPublisher()
            .removeDuplicates()
            .throttle(for: 1.0, scheduler: DispatchQueue.global(), latest: true)
            .handleEvents(receiveOutput: { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.countryDataSubject.send([])
                strongSelf.isEmptyData = true
            })
            .filter { $0 != "" }
            .compactMap { $0 }
            .sink { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.isEmptyData = false
                if $0 != "" {
                    strongSelf.loadData(with: $0)
                }
            }.store(in: &subscriptions)
    }
    
    private func subsribeToSelectedItem() {
        selectItemFromTableViewSubject
            .receive(on: DispatchQueue.main)
            .map { self.countryDataSubject.value[$0] }
            .sink { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.selectedCountry = $0.region ?? ""
                NotificationCenter.default.post(name: Notification.Name(KeyConstants.shared.UPDATE_CITY),
                                                object: strongSelf.selectedCountry)
            }.store(in: &subscriptions)
    }
}
