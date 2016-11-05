//
//  ActionDefinition.swift
//  Coconut-xib-converter
//
//  Created by Dami on 05/11/2016.
//
//

import Foundation

class UiActionDefinition : UiDefinition {
    var selector : String? = nil
    var target : UiDefinition? = nil
    
    init(id: String, vName: String) {
        super.init(id: id, vName: vName, customClass: "")
    }
}
