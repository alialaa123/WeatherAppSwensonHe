//
//  NiblessNavigationController.swift
//  AppUIKit
//
//  Created by Ali Alaa on 07/12/2022.
//

import UIKit

open class NiblessNavigationController: UINavigationController {
    
    // MARK: - Methods
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable,
                message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
    )
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable,
                message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
    )
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
    }
    
    public func forcePresent(vc: UIViewController) {
        let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(vc, animated: true)
        } else {
            present(vc, animated: true)
        }
        
    }
}
