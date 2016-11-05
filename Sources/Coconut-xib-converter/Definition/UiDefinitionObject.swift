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

class UiDefinitionObject {
    
    let id: String
    
    let uiDefinitionType : UiDefinitionType
    let vName: String
    var customClass: String
    
    
    init(id: String, uiDefinitionType : UiDefinitionType, vName: String, customClass: String) {
        self.id = id
        self.uiDefinitionType = uiDefinitionType
        self.vName = vName
        self.customClass = customClass
    }
}
