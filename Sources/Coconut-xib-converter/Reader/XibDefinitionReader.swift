//
//  XibDefinitionReader.swift
//  Coconut-xib-converter
//
//  Created by Dami on 23/10/2016.
//
//

import Foundation

import LibXml2Swift

public enum XibReaderError : Error {
    case notValid(msg: String)
    case unknow(msg: String)
}

var idCounter = 0
func swiftId(id: String?) -> String {
    guard let id = id else {
        let vId = "id\(idCounter)"
        idCounter = idCounter + 1
        return vId
    }
    return "id" + id.replacingOccurrences(of: "-", with: "_");
}

class XibDefinitionReader {
 
    func read(element: XmlDomElement) -> UiDefinitionFile {
        
        // Create definiton
        let definition = UiDefinitionFile()
        
        for node in element.children {
            if let child = node as? XmlDomElement {
                switch child.name {
                case "customObject":
                    let customObject = XibCustomObjectReader().read(element: child)
                    switch(customObject.id) {
                    case "-2" :
                        definition.owner = customObject
                        break
                    case "-1", "-3" :
                        break
                    default:
                        definition.customObjects.append(customObject)
                    }
                    
                    break
                case "window":
                    definition.window.append(XibWindowReader().read(element: child))
                    break
                case "customView":
                    definition.views.append(XibViewReader().read(element: child))
                    break
                case "menu":
                    //definition.menu = XibMenuReader().readMenu(element: child)
                    break
                default:
                    print("Unknow element: \(child.name)")
                }
            }
        }
        
        return definition
    }
    
    static func read(at url: URL) throws ->  UiDefinitionFile {
        
        // Read XML document
        let rootXibDocument = try XmlDomReader.read(atPath: url)
        
        // Check root document
        let rootElement = try rootXibDocument.rootElement()
        guard (rootElement.name == "document") else {
            throw XibReaderError.notValid(msg: "There is no document element")
        }
        
        // Read elements
        guard let objectsElement = rootElement.child(name: "objects") else {
            throw XibReaderError.notValid(msg: "No objects node")
        }
        
        // Read all objects
        return XibDefinitionReader().read(element: objectsElement)
    }
}
