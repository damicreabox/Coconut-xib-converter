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
    case window
    case button
}

class UiViewDefinition: UiDefinitionObject {
    
    var index: Int?
    var views : [UiViewDefinition]
    
    var viewType: UiViewType {
        get {
            return UiViewType.view
        }
    }
    
    init(id: String, index: Int? = nil, subViews: [UiViewDefinition] = [UiViewDefinition](), customClass: String) {
        self.views = subViews
        self.index = index
        super.init(id: id, customClass: customClass)
    }
}
