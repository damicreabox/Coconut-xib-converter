//
//  DocumentDefinition.swift
//  Coconut-xib-converter
//
//  Created by Dami on 16/10/2016.
//
//

import Foundation
import LibXml2Swift

public enum ConverterError : Error {
    case unknowError(msg: String)
}

func unknownNode(node: XmlDomNode) {
    print("node: \(node.name)")
}

public class XibDefinition {
    
    private let rootElement: XmlDomElement
    
    private let objectsElement: XmlDomElement
    
    lazy public private(set) var objects: [XibObject] = {
        
        let xibObjects = [XibObject]()
        
        for objectNode in self.objectsElement.children {
            
            if (objectNode.type == XmlDomNodeType.element) {
                let element = objectNode as! XmlDomElement
                switch(element.name) {
                    
                case "customObject":
                    unknownNode(node: objectNode)
                    break
                    
                case "customView":
                    unknownNode(node: objectNode)
                    break
                    
                default:
                    unknownNode(node: objectNode)
                    break
                }
            } else {
                unknownNode(node: objectNode)
            }
            
        }
        
        return xibObjects
    } ()
    
    public init?(element: XmlDomElement) {
        
        // Set element
        rootElement = element
        
        var objectsElement: XmlDomElement? = nil
        
        // Find object node
        let nodes = self.rootElement.children
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
            return nil
        }
        
        // Element containin objects
        self.objectsElement = objectsElement!
    }
    
    private func write(line: String, to stream: OutputStream) {
        let encodedDataArray = [UInt8](line.utf8)
        stream.write(encodedDataArray, maxLength: encodedDataArray.count)
    }
    
    public func generate(at url: URL) throws {
        
        // FIXME Test directory
        
        // UI file
        let uiFile = "MyUI"
        
        let xibFile = url.appendingPathComponent("\(uiFile).Swift")
        
        guard let stream = OutputStream(toFileAtPath: xibFile.path, append: false) else {
            throw ConverterError.unknowError(msg: "Unable to open directory \(url.path)")
        }
        
        // Create file
        stream.open()
        
        // Write header
        write(line: "import Foundation\n", to: stream)
        write(line: "public class \(uiFile) {\n", to: stream)
        write(line: "   private var delegate : NSObject\n", to: stream)
        write(line: "   private var objects : [NSObject]\n", to: stream)
        write(line: "   init() {\n", to: stream)
        write(line: "   }\n", to: stream)
        write(line: "}\n", to: stream)
        
        
        // Close
        stream.close()
        
        print("XibDefinition")
    }
    
}
