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
    
    private let gradientBackgroudImage = UIImageView().with {
        $0.image = UIImage(named: "gradientBackground")
        $0.contentMode = .scaleAspectFill
    }
    
    public let timeLabel = UILabel().with {
        $0.text = "9:30 AM"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    public let searchButton = UIButton().with {
        $0.setImage(UIImage(named: "searchIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    public lazy var cityNameLabel = UILabel().with {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        $0.text = "San Francisco"
    }
    
    public lazy var dateLabel = UILabel().with {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.text = "Friday, 8 Dec 2022"
    }
    
    private lazy var headerTitleStackView = UIStackView().with {
        $0.addArrangedSubview(cityNameLabel)
        $0.addArrangedSubview(dateLabel)
        $0.spacing = 4
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    // current weather view
    public lazy var weatherCurrentImage = UIImageView().with {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 40
    }
    
    public lazy var currentWeatherTempLabel = UILabel().with {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 56, weight: .bold)
    }
    
    public lazy var currentWeatherDescriptionLabel = UILabel().with {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.text = "It's sunny right now"
    }
    
    private lazy var currentWeatherHeaderStackView = UIStackView().with {
        $0.addArrangedSubview(weatherCurrentImage)
        $0.setCustomSpacing(21, after: weatherCurrentImage)
        $0.addArrangedSubview(currentWeatherTempLabel)
        $0.setCustomSpacing(4, after: currentWeatherTempLabel)
        $0.addArrangedSubview(currentWeatherDescriptionLabel)
        $0.setCustomSpacing(21, after: currentWeatherDescriptionLabel)
        $0.addArrangedSubview(currentWeatherStatusStackView)
        $0.setCustomSpacing(118, after: currentWeatherStatusStackView)
        $0.addArrangedSubview(forecastWeaterDataStackView)
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    public lazy var windImage = UIImageView().with {
        $0.image = UIImage(named: "windIcon")
        $0.contentMode = .scaleAspectFill
    }
    
    public lazy var windLabel = UILabel().with {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.text = "3 mph"
    }
    
    public lazy var dropLetImage = UIImageView().with {
        $0.image = UIImage(named: "dropLetIcon")
        $0.contentMode = .scaleAspectFill
    }
    
    public lazy var dropLetLabel = UILabel().with {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.text = "60%"
    }
    
    private lazy var windDataStackView = UIStackView().with {
        $0.addArrangedSubview(windImage)
        $0.addArrangedSubview(windLabel)
        $0.axis = .horizontal
        $0.spacing = 6
        $0.alignment = .center
        $0.distribution = .fillProportionally
    }
    
    private lazy var dropLetDataStackView = UIStackView().with {
        $0.addArrangedSubview(dropLetImage)
        $0.addArrangedSubview(dropLetLabel)
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 6
        $0.distribution = .fillProportionally
    }
    
    private lazy var currentWeatherStatusStackView = UIStackView().with {
        $0.addArrangedSubview(windDataStackView)
        $0.addArrangedSubview(dropLetDataStackView)
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .fill
        $0.spacing = 43
    }
    
    // forecast view
    public lazy var currentDayDataImage = UIImageView().with {
        $0.image = UIImage(named: "appBackground")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
    }
    
    public lazy var currentDayLabel = UILabel().with {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        $0.text = "Today"
    }
    
    public lazy var currentDayWeatherDataLabel = UILabel().with {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.text = "34/ 34f"
    }
    private lazy var currentDayWeaterDataStackView = UIStackView().with {
        $0.addArrangedSubview(currentDayDataImage)
        $0.addArrangedSubview(currentDayWeatherDataLabel)
        $0.addArrangedSubview(currentDayLabel)
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 6
        $0.distribution = .fill
    }
    
    
    public lazy var tomorrowDayDataImage = UIImageView().with {
        $0.image = UIImage(named: "appBackground")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
    }
    
    public lazy var tomorrowDayLabel = UILabel().with {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        $0.text = "Tomorrow"
    }
    
    public lazy var tomorrowDayWeatherDataLabel = UILabel().with {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.text = "34/ 34f"
    }
    private lazy var tomorrowDayWeaterDataStackView = UIStackView().with {
        $0.addArrangedSubview(tomorrowDayDataImage)
        $0.addArrangedSubview(tomorrowDayWeatherDataLabel)
        $0.addArrangedSubview(tomorrowDayLabel)
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 6
        $0.distribution = .fill
    }
    
    public lazy var dayAfterTomorrowDataImage = UIImageView().with {
        $0.image = UIImage(named: "appBackground")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
    }
    
    public lazy var dayAftertomorrowLabel = UILabel().with {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        $0.text = "Friday"
    }
    
    public lazy var dayAftertomorrowWeatherDataLabel = UILabel().with {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.text = "34/ 34f"
    }
    private lazy var dayAftertomorrowWeaterDataStackView = UIStackView().with {
        $0.addArrangedSubview(dayAfterTomorrowDataImage)
        $0.addArrangedSubview(dayAftertomorrowWeatherDataLabel)
        $0.addArrangedSubview(dayAftertomorrowLabel)
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 6
        $0.distribution = .fill
    }
    
    private lazy var forecastWeaterDataStackView = UIStackView().with {
        $0.addArrangedSubview(currentDayWeaterDataStackView)
        $0.addArrangedSubview(tomorrowDayWeaterDataStackView)
        $0.addArrangedSubview(dayAftertomorrowWeaterDataStackView)
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 51
        $0.distribution = .fillEqually
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
        addSubview(gradientBackgroudImage)
        addSubview(timeLabel)
        addSubview(searchButton)
        addSubview(headerTitleStackView)
        addSubview(currentWeatherHeaderStackView)
    }
    
    private func activateConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview()
        }
        
        gradientBackgroudImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(10)
            make.left.right.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerY.equalTo(timeLabel.snp.centerY)
            make.right.equalToSuperview().inset(32)
        }
        
        headerTitleStackView.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).inset(-66)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }
        
        weatherCurrentImage.snp.makeConstraints { make in
            make.width.height.equalTo(80)
        }
        
        windImage.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        dropLetImage.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        
        tomorrowDayDataImage.snp.makeConstraints { make in
            make.width.height.equalTo(32)
        }
        currentDayDataImage.snp.makeConstraints { make in
            make.width.height.equalTo(32)
        }
        dayAfterTomorrowDataImage.snp.makeConstraints { make in
            make.width.height.equalTo(32)
        }
        
        currentWeatherHeaderStackView.snp.makeConstraints { make in
            make.top.equalTo(headerTitleStackView.snp.bottom).inset(-96)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(40)
        }
    }
    
    private func styleView() {
        backgroundColor = .white
    }
}
