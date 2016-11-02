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
    
    func read(element: XmlDomElement) -> CustomObjectDefinition {
        print(" - Custom object : \(element.name)")
        
        // Read id
        let id = readId(element: element)
        var name: String
        switch id {
        case "-1":
            name = "firstResponder"
            break
        case "-2":
            name = "owner"
            break
        case "-3":
            name = "application"
            break
        default:
            name = readText(element: element, attr: "userLabel", defaultValue: convertIdToName(id: id))
            break
        }
        
        
        return CustomObjectDefinition(id: id,
                                      name: name,
                                      customClass: readCustomClass(element: element, defaultValue: "NSObject"))
    }
    
}
