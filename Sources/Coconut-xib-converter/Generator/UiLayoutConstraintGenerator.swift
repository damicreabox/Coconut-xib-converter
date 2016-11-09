//
//  UiConstraintGenerator.swift
//  Sample-coconut
//
//  Created by Dami on 09/11/2016.
//
//

import Foundation

class UiLayoutConstraintGenerator {
    
    func newInstance(constraint: UiLayoutConstraint) -> String {
        
        let definitionFactory = DefinitionFactory.instance
        
        var str = ""
        
        if let firstViewStr = constraint.firstView {
            
            
            if let firstView = definitionFactory.getDefinition(id: firstViewStr) {
                
                if (str != "") {
                    str.append(", ")
                }
                str.append("firstView: \(firstView.vName)")
            }
        }
        
        let firstViewConstraintType = constraint.firstViewConstraintType
        if firstViewConstraintType != .none {
            
            if (str != "") {
                str.append(", ")
            }
            str.append("firstViewConstraint: .\(firstViewConstraintType.rawValue)")
        }
        
        if let secondViewStr = constraint.secondView {
            
            if let secondView = definitionFactory.getDefinition(id: secondViewStr) {
                if (str != "") {
                    str.append(", ")
                }
                str.append("secondView: \(secondView.vName)")
            }
        }
        
        let secondViewConstraintType = constraint.secondViewConstraintType
        if secondViewConstraintType != .none {
            if (str != "") {
                str.append(", ")
            }
            str.append("secondViewConstraint: .\(secondViewConstraintType.rawValue)")
        }
        
        if let constant = constraint.constant {
            if (str != "") {
                str.append(", ")
            }
            str.append("constant: \(constant)")
        }
        
        return "LayoutConstraint(\(str))"
    }
}
