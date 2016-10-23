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
    
    public func foundObjectsNode(element: XmlDomElement) throws -> XmlDomElement {
        
        // Read elements
        var objectsElement: XmlDomElement? = nil
        
        // Find object node
        let nodes = element.children
        
        for node in nodes {
            
            if (node.type == XmlDomNodeType.element) {
                let element = node as! XmlDomElement
                switch(element.name) {
                    
                case "dependencies":
                    unknownNode(node: node)
                    break
                    
                case "objects":
                    // Set objects node
                    objectsElement = element
                    break
                    
                default:
                    unknownNode(node: node)
                    break
                }
            } else {
                unknownNode(node: node)
            }
        }
        
        if objectsElement == nil {
            throw XibReaderError.notValid(msg: "No objects node")
        }
        
        return objectsElement!
    }
    
    public func read(at url: URL) throws ->  XibDefinition {
        
        // Read XML document
        let rootXibDocument = try XmlDomReader.read(atPath: url)
        
        // Check root document
        let rootElement = try rootXibDocument.rootElement()
        guard (rootElement.name == "document") else {
            throw XibReaderError.notValid(msg: "There is no document element")
        }
        
        // Find object node
        let objects = try foundObjectsNode(element: rootElement)
        
        let xibDefinition = XibDefinition()
        
        return xibDefinition
    }
}
