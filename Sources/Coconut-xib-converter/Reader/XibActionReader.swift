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
    
    static func log(logger: Logger, definition: UiActionDefinition) {
        
        // FXIME Add log parameter like ("{0} -> {1}, target?, selector?)
        
        var info = ""
        
        if let target = definition.target {
            info.append(target.vName)
        } else {
            info.append("(nil)")
        }
        
        info.append(" -> ")
        
        if let selector = definition.selector {
            info.append(selector)
        } else {
            info.append("(nil)")
        }
        
        logger.log(.INFO, " - Action \(info)")
    }
    
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
