//
//  UiViewDefinition.swift
//  Sample-coconut
//
//  Created by Dami on 02/11/2016.
//
//

import Foundation

class UiViewDefinition: UiDefinitionObject {
    
    var views : [UiViewDefinition]
    
    init(id: String, subViews: [UiViewDefinition] = [UiViewDefinition](), customClass: String) {
        self.views = subViews
        super.init(id: id, customClass: customClass)
    }
}
