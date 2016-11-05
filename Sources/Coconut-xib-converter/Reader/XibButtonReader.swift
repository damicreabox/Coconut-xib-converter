//
//  XibButtonReader.swift
//  Coconut-xib-converter
//
//  Created by Dami on 26/10/2016.
//
//

import Foundation

import LibXml2Swift

class XibButtonReader : XibElementReader {
    
    func read(element: XmlDomElement) -> UiButtonDefinition {
        print(" - Button : \(element.name)")
        
        // Set button
        let buttonDefinition = DefinitionFactory.instance.button(id: readId(element: element))
        
        // Find button cell
        if  let buttonCell = element.child(name: "buttonCell") {
            
            // Find title
            buttonDefinition.title = readText(element: buttonCell, attr: "title", defaultValue: buttonDefinition.id)
            
            // Find action
            if let connectionsNode = buttonCell.child(name: "connections") {
                
                // Find action
                if let actionNode = connectionsNode.child(name: "action") {
                    
                    // Read action
                    let action = XibActionReader().read(element: actionNode)
                    
                    // Set action
                    buttonDefinition.action = action
                }
                
            }
        }
                
        return buttonDefinition
    }
}
