//
//  NavigationAction.swift
//  CoreKit
//
//  Created by Ali Alaa on 07/12/2022.
//

import Foundation

public enum NavigationAction<ViewModelType>: Equatable where ViewModelType: Equatable {
    
    case present(view: ViewModelType)
    case presented(view: ViewModelType)
}

