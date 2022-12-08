//
//  SearchView.swift
//  WeatherAppSwensonHe
//
//  Created by Ali Alaa on 08/12/2022.
//

import UIKit
import AppUIKit
import SnapKit

final class SearchView: NiblessView {
    
    // MARK: - Properties
    public let containerView = UIView().with {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
        $0.alpha = 0
    }
    
    public let searchField = UITextField().with {
        $0.font = UIFont(name: "SFPro-Medium", size: 16)
        $0.textColor = UIColor(red: 0.267, green: 0.306, blue: 0.446, alpha: 1)
        $0.placeholder = "Search City"
        $0.keyboardType = .alphabet
    }
    
    public let eraseSearchFieldButton = UIButton().with {
        $0.setImage(UIImage(named: "closeIcon"), for: .normal)
        $0.alpha = 0
    }
    
    private lazy var searchContentStackView: UIStackView = {
        $0.alignment = .fill
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 13
        $0.addArrangedSubview(searchField)
        $0.addArrangedSubview(eraseSearchFieldButton)
        return $0
    }(UIStackView())
    
    public let backButton = UIButton().with {
        $0.setImage(UIImage(named: "leftArrowIcon"), for: .normal)
    }
    
    private lazy var searchFieldContainerView = UIView().with {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.267, green: 0.306, blue: 0.446, alpha: 1).cgColor
        $0.addSubview(searchContentStackView)
    }
    
    private(set) lazy var searchTableView: UITableView = {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")
        $0.backgroundColor = .clear
        $0.backgroundView = nil
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 600
        $0.separatorStyle = .none
        $0.contentInsetAdjustmentBehavior = .never
        $0.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 38, right: 0)
        $0.tableFooterView = UIView()
        $0.clipsToBounds = true
        return $0
    }(UITableView())
    
    public lazy var pushToMinImage = UIImageView().with {
        $0.image = UIImage(named: "upArrowIcon")
        $0.contentMode = .scaleAspectFit
    }
    
    public lazy var pushToMin = UIView().with {
        $0.backgroundColor = UIColor(red: 0.946, green: 0.957, blue: 1, alpha: 1)
        $0.addSubview(pushToMinImage)
        $0.clipsToBounds = true
        $0.alpha = 0
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
        addSubview(containerView)
        containerView.addSubview(searchTableView)
        containerView.addSubview(searchFieldContainerView)
        containerView.addSubview(backButton)
        containerView.addSubview(pushToMin)
    }
    
    private func activateConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(144)
        }
        
        eraseSearchFieldButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        
        searchContentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(13)
        }
        
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.left.equalToSuperview().inset(26)
            make.centerY.equalTo(searchFieldContainerView.snp.centerY)
        }
        
        searchFieldContainerView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(32)
            make.left.equalToSuperview().inset(60)
            make.height.equalTo(50)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(12)
        }
        
        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(searchFieldContainerView.snp.bottom)
            make.left.right.equalToSuperview().inset(32)
            make.bottom.equalToSuperview()
        }
        
        pushToMinImage.snp.makeConstraints { make in
            make.width.height.equalTo(12)
            make.center.equalToSuperview()
        }
        
        pushToMin.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(38)
        }
    }
    
    private func styleView() {
        backgroundColor = .clear
    }
}
