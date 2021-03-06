//
//  UiViewDefinition.swift
//  Sample-coconut
//
//  Created by Dami on 02/11/2016.
//
//

import Foundation

enum UiViewType {
    case view
    case button
}

class UiViewDefinition: UiDefinitionObject {
    
    var frame : NSRect? = nil
    var views = [UiViewDefinition]()
    var constraints = [UiLayoutConstraint]()
    
    var viewType: UiViewType {
        get {
            return UiViewType.view
        }
    }
    
    override init(id: String, uiDefinitionType: UiDefinitionType = .view, vName: String, customClass: String = "View") {
        super.init(id: id, uiDefinitionType: uiDefinitionType, vName: vName, customClass: customClass)
    }
}
