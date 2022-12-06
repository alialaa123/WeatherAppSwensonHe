//
//  UIImageView+Kingfisher.swift
//  AppUIKit
//
//  Created by Ali Alaa on 07/12/2022.
//

import UIKit
import Kingfisher

public extension UIImageView {
/// - Parameter url: the image url to convret to image
    func loadImage(_ url: URL?) {
        self.kf.setImage(
            with: url,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        self.kf.indicatorType = .activity
    }
}
