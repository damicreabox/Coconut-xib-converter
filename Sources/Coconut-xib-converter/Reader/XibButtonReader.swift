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
    
    private static let LOGGER = Logger.getLogger(name: #file)
    
    private func readActionConnections(element: XmlDomElement, definition: UiButtonDefinition) {
        
        // Find action
        if let connectionsNode = element.child(name: "connections") {
            
            // Find action
            if let actionNode = connectionsNode.child(name: "action") {
                
                // Read action
                let action = XibActionReader().read(element: actionNode)
                
                XibActionReader.log(logger: XibButtonReader.LOGGER, definition: action)
                
                // Set action
                definition.action = action
            }
            
        }
    }
    
    func read(element: XmlDomElement) -> UiButtonDefinition {
        
        // Set button
        let buttonDefinition = DefinitionFactory.instance.button(id: readId(element: element))
        
        // Log creation
        XibElementReader.logObject(logger: XibButtonReader.LOGGER, definition: buttonDefinition)
        
        // Read size
        if let rectElement = element.child(name: "rect") {
            buttonDefinition.frame = XibRectReader().readRect(node: rectElement).rect
        }
        
        // Read connections in button element
        readActionConnections(element: element, definition: buttonDefinition)
        
        // Find button cell
        if  let buttonCell = element.child(name: "buttonCell") {
            
            // Find title
            buttonDefinition.title = readText(element: buttonCell, attr: "title", defaultValue: buttonDefinition.id)

            // Read connections in buttoncell
            readActionConnections(element: buttonCell, definition: buttonDefinition)
        }
                
        return buttonDefinition
    }
}
