//
//  HomeViewController.swift
//  WeatherAppSwensonHe
//
//  Created by Ali Alaa on 07/12/2022.
//

import UIKit
import AppUIKit
import CoreKit
import Combine

class HomeViewController: NiblessNavigationController {

    // MARK: - Properties
    private let viewModel: HomeViewModel
    
    // Child ViewControllers
    let rootViewController: HomeRootViewController
    var searchViewController: SearchViewController?
    
    let makeSearchViewControllerFactory: (() -> SearchViewController)
    
    // state
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Life cycle
    init(viewModel: HomeViewModel,
         rootViewController: HomeRootViewController,
         searchViewControllerFactory: @escaping (() -> SearchViewController)) {
        self.viewModel = viewModel
        self.rootViewController = rootViewController
        self.makeSearchViewControllerFactory = searchViewControllerFactory
        
        super.init()
        self.delegate = self
        self.viewControllers = [rootViewController]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationActionPublisher = viewModel.$navigationAction.eraseToAnyPublisher()
        subscribe(to: navigationActionPublisher)
    }
    
    // MARK: - Methods
    private func subscribe(to publisher: AnyPublisher<HomeNavigationAction, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] action in
                guard let strongSelf = self else { return }
                strongSelf.respond(to: action)
            }.store(in: &subscriptions)
    }
    
    private func respond(to navigationAction: HomeNavigationAction) {
        switch navigationAction {
        case .present(let view):
            present(view: view)
        case .presented:
            break
        }
    }
    
    private func present(view: HomeView) {
        switch view {
        case .root:
            presentHomeRoot()
        case .searchForCountry:
            presentSearchView()
        }
    }
    
    
    // MARK: - Methods to call views
    private func presentHomeRoot() {
        popToRootViewController(animated: true)
    }
    
    private func presentSearchView() {
        present(makeSearchViewControllerFactory(), animated: true)
    }
    
}



// MARK: - Navigation Bar Presentation
extension HomeViewController {
    
    func hideOrShowNavigationBarIfNeeded(for view: HomeView, animated: Bool) {
        if view.hidesNavigationBar() {
            hideNavigationBar(animated: animated)
        } else {
            showNavigationBar(animated: animated)
        }
    }
    
    func hideNavigationBar(animated: Bool) {
        if animated {
            transitionCoordinator?.animate(alongsideTransition: { _ in
                self.setNavigationBarHidden(true, animated: animated)
            })
        } else {
            setNavigationBarHidden(true, animated: false)
        }
    }
    
    func showNavigationBar(animated: Bool) {
        if self.isNavigationBarHidden {
            self.setNavigationBarHidden(false, animated: animated)
        }
    }
}

// MARK: - UINavigationControllerDelegate
extension HomeViewController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController,
                                     willShow viewController: UIViewController,
                                     animated: Bool) {
        guard let viewToBeShown = homeView(associatedWith: viewController) else { return }
        hideOrShowNavigationBarIfNeeded(for: viewToBeShown, animated: animated)
    }
    
    public func navigationController(_ navigationController: UINavigationController,
                                     didShow viewController: UIViewController,
                                     animated: Bool) {
        guard let shownView = homeView(associatedWith: viewController) else { return }
        viewModel.uiPresented(view: shownView)
    }
}

extension HomeViewController {
    
    func homeView(associatedWith viewController: UIViewController) -> HomeView? {
        switch viewController {
        case is HomeRootViewController: return .root
        case is SearchViewController: return .searchForCountry
        default:
//          assertionFailure("")
            return nil
        }
    }
}

