//
//  XibConstraintReader.swift
//  Sample-coconut
//
//  Created by Dami on 09/11/2016.
//
//

import Foundation

import LibXml2Swift

class XibConstraintReader : XibElementReader {
    
    static let LOGGER = Logger.getLogger(name: #file)
    
    func read(elements: [XmlDomElement]) -> [UiLayoutConstraint] {
        
        var constraints = [UiLayoutConstraint]()
        
        for element in elements {
            constraints.append(read(element: element))
        }
        
        return constraints
    }
    
    func read(element: XmlDomElement) -> UiLayoutConstraint {
        
        let constraint = UiLayoutConstraint()
        
        // Read first element
        if let firstId = element["firstItem"] {
            constraint.firstView = firstId.value
        }
        
        // Read first attribute
        if let firstAttribute = element["firstAttribute"] {
            if let attr = ViewConstraintType(rawValue: firstAttribute.value) {
                constraint.firstViewConstraintType = attr
            }
        }
        
        // Read second element
        if let secondId = element["secondItem"] {
            constraint.secondView = secondId.value
        }
        
        // Read second attribute
        if let secondAttribute = element["secondAttribute"] {
            if let attr = ViewConstraintType(rawValue: secondAttribute.value) {
                constraint.secondViewConstraintType = attr
            }
        }
        
        // Read constant
        constraint.constant = readOptionalText(element: element, attr: "constant")
        
        return constraint
    }
    
    
    static func log(logger: Logger, constraints: [UiLayoutConstraint]) {
        
        for constraint in constraints {
            log(logger: logger, constraint: constraint)
        }
    }
    
    
    static func log(logger: Logger, constraint: UiLayoutConstraint) {
        
        var info = ""
        
        info.append("firstViewConstraintType:'\(constraint.firstViewConstraintType)' ")
        if let firstView = constraint.firstView {
            info.append("firstView:'\(firstView)' ")
        }
        
        info.append("secondViewConstraintType:'\(constraint.secondViewConstraintType)' ")
        if let secondView = constraint.secondView {
            info.append("secondView:'\(secondView)' ")
        }
        
        if let constant = constraint.constant {
            info.append("constant:'\(constant)' ")
        }

        logger.log(.INFO, " - Constraint \(info)")
    }
}
