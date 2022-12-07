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
        view.backgroundColor = .red        
    }
}
