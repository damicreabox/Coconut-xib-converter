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
    var vName: String
    var customClass: String

    
    init(id: String, vName: String, customClass: String) {
        self.id = id
        self.vName = vName
        self.customClass = customClass
    }
}

class UiDefinitionObject :UiDefinition {
    
    
    let uiDefinitionType : UiDefinitionType
    
    
    init(id: String, uiDefinitionType : UiDefinitionType, vName: String, customClass: String) {
        self.uiDefinitionType = uiDefinitionType
        super.init(id: id, vName: vName, customClass: customClass)
    }
}
