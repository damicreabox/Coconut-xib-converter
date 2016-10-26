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

public class XibDefinitionReader {
 
    func readDefinition(element: XmlDomElement) -> XibDefinition {
        
        // Create definiton
        let definition = XibDefinition()
        
        for node in element.children {
            if let child = node as? XmlDomElement {
                switch child.name {
                case "customObject":
                    definition.objects.append(XibCustomObjectReader().readObject(element: child))
                    break
                case "window":
                    definition.windows.append(XibWindowReader().readWindow(element: child))
                    break
                case "customView":
                    definition.views.append(XibViewReader().readView(element: child))
                    break
                case "menu":
                    definition.menu = XibMenuReader().readMenu(element: child)
                    break
                default:
                    print("Unknow element: \(child.name)")
                }
            }
        }
        
        return definition
    }
    
    public static func read(at url: URL) throws ->  XibDefinition {
        
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
        return XibDefinitionReader().readDefinition(element: objectsElement)
    }
}
