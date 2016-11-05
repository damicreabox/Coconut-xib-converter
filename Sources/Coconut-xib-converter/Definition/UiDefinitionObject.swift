//
//  UiDefinitionObject.swift
//  Sample-coconut
//
//  Created by Dami on 02/11/2016.
//
//

import Foundation

enum UiDefinitionType {
    case window
    case view
    case button
    case customObject
    case unknown
}

class UiDefinition {
    
    let id: String
    let vName: String
    
    init(id: String, vName: String) {
        self.id = id
        self.vName = vName
    }
}

class UiDefinitionObject :UiDefinition {
    
    
    let uiDefinitionType : UiDefinitionType
    var customClass: String
    
    
    init(id: String, uiDefinitionType : UiDefinitionType, vName: String, customClass: String) {
        self.uiDefinitionType = uiDefinitionType
        self.customClass = customClass
        super.init(id: id, vName: vName)
    }
}
