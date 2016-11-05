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
    
    var views : [UiViewDefinition]
    
    var viewType: UiViewType {
        get {
            return UiViewType.view
        }
    }
    
    init(id: String, uiDefinitionType: UiDefinitionType = .view, vName: String, subViews: [UiViewDefinition] = [UiViewDefinition](), customClass: String) {
        self.views = subViews
        super.init(id: id, uiDefinitionType: uiDefinitionType, vName: vName, customClass: customClass)
    }
}
