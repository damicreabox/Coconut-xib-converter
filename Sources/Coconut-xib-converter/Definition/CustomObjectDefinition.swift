//
//  CustomObjectDefinition.swift
//  Sample-coconut
//
//  Created by Dami on 02/11/2016.
//
//

import Foundation

class CustomObjectDefinition : UiDefinitionObject {
    
    var name: String
    init(id: String, vName: String, name: String, customClass: String) {
        self.name = name
        super.init(id: id, uiDefinitionType: .customObject, vName: vName, customClass: customClass)
    }
}
