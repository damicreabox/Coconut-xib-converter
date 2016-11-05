//
//  CustomObjectDefinition.swift
//  Sample-coconut
//
//  Created by Dami on 02/11/2016.
//
//

import Foundation

class CustomObjectDefinition : UiDefinitionObject {
    
    var name: String = ""
    
    init(id: String, vName: String) {
        super.init(id: id, uiDefinitionType: .customObject, vName: vName, customClass: "NSObject")
    }
}
