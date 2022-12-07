//
//  HomeRootView.swift
//  WeatherAppSwensonHe
//
//  Created by Ali Alaa on 07/12/2022.
//

import UIKit
import AppUIKit
import SnapKit

final class HomeRootView: NiblessView {
    
    // MARK: - Properties
    private let backgroundImage = UIImageView().with {
        $0.image = UIImage(named: "appBackground")
        $0.contentMode = .scaleAspectFill
    }
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        constructHierarchy()
        activateConstraints()
        styleView()
    }
    
    // MARK: - Methods
    private func constructHierarchy() {
        addSubview(backgroundImage)
    }
    
    private func activateConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview()
        }
    }
    
    private func styleView() {
        backgroundColor = .white
    }
}
