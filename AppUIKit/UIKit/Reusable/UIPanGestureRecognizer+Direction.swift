//
//  UIPanGestureRecognizer+Direction.swift
//  AppUIKit
//
//  Created by Ali Alaa on 08/12/2022.
//

import UIKit

public enum Direction: Int {
    case up
    case down
    case left
    case right
    
    public var isX: Bool { return self == .left || self == .right }
    public var isY: Bool { return !isX }
}

public extension UIPanGestureRecognizer {
    
    var direction: Direction? {
        let vertical = abs(velocity(in: view).y) > abs(velocity(in: view).x)
        switch (vertical, velocity(in: view).x, velocity(in: view).y) {
        case (true, _, let y) where y < 0: return .up
        case (true, _, let y) where y > 0: return .down
        case (false, let x, _) where x > 0: return .right
        case (false, let x, _) where x < 0: return .left
        default: return nil
        }
    }
}
