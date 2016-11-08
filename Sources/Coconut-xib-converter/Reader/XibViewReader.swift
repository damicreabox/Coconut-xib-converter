//
//  XibViewReader.swift
//  Coconut-xib-converter
//
//  Created by Dami on 26/10/2016.
//
//

import Foundation

import LibXml2Swift

class XibViewReader : XibElementReader {
    
    private static let LOGGER = Logger.getLogger(name: #file)
    
    func readSubViews(element: XmlDomElement) -> [UiViewDefinition] {
        
        var subViews = [UiViewDefinition]()
        
        // Find subview node
        if let subViewNode = element.child(name: "subviews") {
            for node in subViewNode.children {
                if let child = node as? XmlDomElement {
                    switch child.name {
                    case "button":
                        subViews.append(XibButtonReader().read(element: child))
                        break
                    case "customView":
                        subViews.append(read(element: child))
                        break
                    default:
                        print("Unknow element: \(child.name)")
                    }
                }
            }
        }
        
        return subViews
    }
    
    func read(element: XmlDomElement) -> UiViewDefinition {
        
        // Create view
        let viewDefinition = DefinitionFactory.instance.view(id: readId(element: element))
        
        // Read size
        if let rectElement = element.child(name: "rect") {
            viewDefinition.frame = XibRectReader().readRect(node: rectElement).rect
        }
        
        // Log creation
        XibElementReader.logObject(logger: XibViewReader.LOGGER, definition: viewDefinition)
        
        // Set view
        viewDefinition.views = readSubViews(element: element)
        
        return viewDefinition
    }
}
