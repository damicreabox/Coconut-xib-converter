//
//  UiWindowDefinition.swift
//  Sample-coconut
//
//  Created by Dami on 02/11/2016.
//
//

import Foundation

class UiWindowDefinition : UiDefinitionObject {
    
    var contentRect = NSRect()
    var title: String = ""
    var view : UiViewDefinition? = nil
    
    init(id: String, vName: String) {
        super.init(id: id, uiDefinitionType: .window, vName: vName, customClass: "Window")
    }
}
