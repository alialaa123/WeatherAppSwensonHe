//
//  SearchViewController.swift
//  WeatherAppSwensonHe
//
//  Created by Ali Alaa on 08/12/2022.
//

import UIKit
import AppUIKit
import CoreKit
import Combine
import CombineCocoa

class SearchViewController: NiblessBottomSheetViewController {
 
    // MARK: - Properties
    private let customView: SearchView
    private let viewModel: SearchViewModel
    
    private lazy var CountryDataSource = makeCountryDataSource()
    
    // Subscriptions
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Life cycle
    public init(customView: SearchView, viewModel: SearchViewModel) {
        self.customView = customView
        self.viewModel = viewModel
        
        super.init()
    }
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateViewAtBeginning()
        bindSearchTableView(to: viewModel.countryData)
        updateViewWithData(with: viewModel.countryData)
        bindSearchTableView(to: viewModel.selectItemFromTableViewSubscriber)
        eraseSearchTyping()
        dismissView()
        
        customView.searchField.textPublisher.receive(subscriber: viewModel.searchSubjectSubscriber)
        customView.backButton.tapPublisher.receive(subscriber: viewModel.dismissView)
        
    }
    
    // MARK: - Methods
    private func dismissView() {
        viewModel.dismissViewPublisher
            .sink { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.dismissAnimation()
        }.store(in: &subscriptions)
    }
    
    private func eraseSearchTyping() {
        customView.eraseSearchFieldButton.tapPublisher.sink { [weak self] _ in
            guard let strongSelf = self else{ return }
            strongSelf.customView.searchField.text = ""
            strongSelf.customView.searchField.textPublisher.receive(subscriber: strongSelf.viewModel.searchSubjectSubscriber)
        }.store(in: &subscriptions)
    }
    
    private func bindSearchTableView(to items: AnyPublisher<[Country], Never>) {
        items
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.applySearchSnapshot($0, animatingDifferences: true)
            }).store(in: &subscriptions)
    }
    
    private func bindSearchTableView(to subscriber: AnySubscriber<Int, Never>) {
        customView.searchTableView.didSelectRowPublisher
            .map { [weak self] in
                self?.customView.searchTableView.deselectRow(at: $0, animated: false)
                self?.dismissAnimation()
                return $0.row
            }
            .receive(subscriber: subscriber)
    }
}

// MARK: - table view diffable data source
extension SearchViewController {

    func makeCountryDataSource() -> UITableViewDiffableDataSource<CoreKit.MainSection, Country> {
        let dataSource = UITableViewDiffableDataSource<CoreKit.MainSection, Country>(
            tableView: customView.searchTableView) { tableView, IndexPath, model in
                let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: IndexPath)
                cell.textLabel?.textColor = UIColor(red: 0.267, green: 0.306, blue: 0.446, alpha: 1)
                cell.textLabel?.font = UIFont(name: "SFPro-Bold", size: 16)
                cell.textLabel?.text = model.longName ?? ""
                return cell
            }
        return dataSource
    }
    
    func applySearchSnapshot(_ items: [Country], animatingDifferences: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<CoreKit.MainSection, Country>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        CountryDataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - Handling animation of view
extension SearchViewController {
    
    private func animateViewAtBeginning() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut) {
                self.customView.containerView.alpha = 1
                self.customView.searchField.becomeFirstResponder()
            }
        }
    }
    
    private func dismissAnimation() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.customView.containerView.alpha = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.dismissViewController()
            }
        }
    }
    
    private func updateViewWithData(with publisher: AnyPublisher<[Country], Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let strongSelf = self else { return }
                if !$0.isEmpty {
                    UIView.animate(withDuration: 0.6,
                                   delay: 0.0,
                                   usingSpringWithDamping: 0.6,
                                   initialSpringVelocity: 0.8) {
                        strongSelf.customView.containerView.snp.remakeConstraints { make in
                            make.top.equalToSuperview()
                            make.left.right.equalToSuperview()
                            make.height.equalTo(300)
                        }
                        strongSelf.customView.pushToMin.alpha = 1
                        strongSelf.customView.eraseSearchFieldButton.alpha = 1
                    }
                } else {
                    UIView.animate(withDuration: 0.6,
                                   delay: 0.0,
                                   usingSpringWithDamping: 0.6,
                                   initialSpringVelocity: 0.8) {
                        strongSelf.customView.containerView.snp.remakeConstraints { make in
                            make.top.equalToSuperview()
                            make.left.right.equalToSuperview()
                            make.height.equalTo(144)
                        }
                        strongSelf.customView.pushToMin.alpha = 0
                        strongSelf.customView.eraseSearchFieldButton.alpha = 0
                    }
                }
            }.store(in: &subscriptions)
    }
}
