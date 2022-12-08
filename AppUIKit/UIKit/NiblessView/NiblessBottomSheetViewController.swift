//
//  NiblessBottomSheetViewController.swift
//  AppUIKit
//
//  Created by Ali Alaa on 08/12/2022.
//

import UIKit

open class NiblessBottomSheetViewController: NiblessViewController {
    
    // MARK: - Properties
    
    private var viewTranslation = CGPoint(x: 0, y: 0)
    private lazy var dismissPanGesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(backGesture(_:)))
        return gesture
    }()
    
    // MARK: - Methods
    
    override init() {
        super.init()
        modalPresentationStyle = .overFullScreen
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(dismissPanGesture)
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .clear
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.2) {
            self.view.backgroundColor = .black.withAlphaComponent(0.1)
        }
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.view.backgroundColor = .clear
    }
    
    @objc
    private func backGesture(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            if let currentYValue = sender.view?.frame.origin.y, currentYValue < 0 {
                if sender.direction != .up {
                    sender.state = .ended
                    break
                }
            } else {
                viewTranslation = sender.translation(in: view)
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.view.backgroundColor = .clear
                    self.view.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
                })
            }
        case .ended:
            if viewTranslation.y > (self.view.bounds.height / 2) {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.view.transform = .identity
                })
            } else {
                UIView.animate(
                    withDuration: 0.5,
                    delay: 0,
                    usingSpringWithDamping: 0.7,
                    initialSpringVelocity: 1,
                    options: .curveEaseOut,
                    animations: {
                        self.view.transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height + 50)
                    },
                    completion: { _ in
                        self.dismiss(animated: false, completion: nil)
                    }
                )
            }
        default:
            break
        }
    }
    
    @objc
    public func dismissViewController() {
        self.view.backgroundColor = .clear
        self.dismiss(animated: true)
    }
    
}
