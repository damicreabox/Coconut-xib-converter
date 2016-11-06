//
//  CustomObjectReader.swift
//  Coconut-xib-converter
//
//  Created by Dami on 26/10/2016.
//
//

import Foundation

import LibXml2Swift

class XibCustomObjectReader : XibElementReader {
    
    private static let LOGGER = Logger.getLogger(name: #file)
    
    func read(element: XmlDomElement) -> CustomObjectDefinition {
        
        // Read id
        let id = readId(element: element)
        
        // Custom object
        let customObject = DefinitionFactory.instance.customObject(id: id)
        
        var name: String
        switch id {
        case "-1":
            name = "firstResponder"
            customObject.vName = "firstResponderObject"
            break
        case "-2":
            name = "owner"
            customObject.vName = "ownerObject"
            break
        case "-3":
            name = "application"
            customObject.vName = "applicationObject"
            break
        default:
            name = readText(element: element, attr: "userLabel", defaultValue: convertIdToName(id: id))
            break
        }
        
        // Set name
        customObject.name = name
        
        // Read custom class
        customObject.customClass = readCustomClass(element: element, defaultValue: "NSObject")
        
        // Log creation
        XibElementReader.logObject(logger: XibCustomObjectReader.LOGGER, definition: customObject)
        
        return customObject
    }
    
}
