//
//  UiConstraint.swift
//  Sample-coconut
//
//  Created by Dami on 09/11/2016.
//
//

import Foundation

enum ViewConstraintType : String {
    case top
    case bottom
    case left
    case right
    case centerX
    case centerY
    case none
}

class UiLayoutConstraint {
    
    var firstView: String? = nil
    var secondView: String? = nil
    
    var firstViewConstraintType: ViewConstraintType = .none
    var secondViewConstraintType: ViewConstraintType = .none
    
    var constant: String? = nil
}
