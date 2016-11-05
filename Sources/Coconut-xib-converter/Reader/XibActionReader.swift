//
//  XibConnexionReader.swift
//  Coconut-xib-converter
//
//  Created by Dami on 05/11/2016.
//
//

import Foundation

import LibXml2Swift

class XibActionReader : XibElementReader {
 
    func read(element: XmlDomElement) -> UiActionDefinition {
        
        // Create action
        let actionDefiniton = DefinitionFactory.instance.action(id: readId(element: element));
        
        // Find selector
        let selector = element["selector"]
        let target = element["target"]
        
        // Valid arguments
        if let selector = selector, let target = target, let targetDefinition = DefinitionFactory.instance.getDefinition(id: target.value) {
            
            // set selector
            actionDefiniton.selector = selector.value
            actionDefiniton.target = targetDefinition
        }
        
        return actionDefiniton
    }
}
