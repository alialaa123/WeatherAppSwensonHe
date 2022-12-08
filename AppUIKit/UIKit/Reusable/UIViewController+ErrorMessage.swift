//
//  UIViewController+ErrorMessage.swift
//  AppUIKit
//
//  Created by Ali Alaa on 08/12/2022.
//

import Foundation
import UIKit
import CoreKit
import Combine

extension UIViewController {
    
    // MARK: - Methods
    public func present(errorMessage: ErrorMessage) {
        let errorAlertController = UIAlertController(title: errorMessage.message,
                                                     message: "",
                                                     preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        errorAlertController.addAction(okAction)
        present(errorAlertController, animated: true, completion: nil)
    }
    
    public func present(errorMessage: ErrorMessage,
                        withPresentationState errorPresentation: PassthroughSubject<ErrorPresentation?, Never>) {
        errorPresentation.send(.presenting)
        let errorAlertController = UIAlertController(title: errorMessage.message,
                                                     message: "",
                                                     preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            errorPresentation.send(.dismissed)
            errorPresentation.send(nil)
        }
        errorAlertController.addAction(okAction)
        present(errorAlertController, animated: true, completion: nil)
        
    }
}
