//
//  XibElementReader.swift
//  Sample-coconut
//
//  Created by Dami on 02/11/2016.
//
//

import Foundation

import LibXml2Swift

class XibElementReader {
    
    static func logObject(logger: Logger, definition: UiDefinitionObject) {
        logger.log(.INFO, "\(definition.uiDefinitionType) : \(definition.id) (\(definition.vName):\(definition.customClass))")
    }
    
    func convertIdToName(id: String) -> String {
        return id.replacingOccurrences(of: "-", with: "_")
    }
    
    func readId(element: XmlDomElement?) -> String {
        return readText(element: element, attr: "id")
    }
    
    func readCustomClass(element: XmlDomElement?, defaultValue: String) -> String {
        return readText(element: element, attr: "customClass", defaultValue: defaultValue)
    }
    
    func readText(element: XmlDomElement?, attr: String, defaultValue: String = "") -> String {
        
        var id = defaultValue
        
        if let element = element {
            if let attrId = element[attr] {
                id = attrId.value
            }
        }
        
        return id;
    }
}
