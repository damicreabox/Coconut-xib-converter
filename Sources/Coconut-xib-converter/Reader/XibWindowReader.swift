//
//  XibWindowReader.swift
//  Coconut-xib-converter
//
//  Created by Dami on 26/10/2016.
//
//

import Foundation

import LibXml2Swift

class XibWindowReader : XibElementReader {
    
    private static let LOGGER = Logger.getLogger(name: #file)
    
    func read(element: XmlDomElement) -> UiWindowDefinition {
        
        // Read Frame
        let rects = XibRectReader().readRects(elements: element.children(name: "rect"))
        
        // Find content rect
        let contentRect = rects["contentRect"]
        
        let windowDefinition = DefinitionFactory.instance.window(id: readId(element: element))
        
        // Custom clas
        windowDefinition.customClass = readCustomClass(element: element, defaultValue: "Window")
        
        // Log creation
        XibElementReader.logObject(logger: XibWindowReader.LOGGER, definition: windowDefinition)
        
        // Set rectangle
        if let contentRect = contentRect {
            windowDefinition.contentRect = contentRect
        }
        
        
        // Set title
        windowDefinition.title = readText(element: element, attr: "title")
        
        if let viewElement = element.child(name: "view") {
            
            //  Read view
            let view = XibViewReader().read(element: viewElement)
            
            // Set view
            windowDefinition.view = view
            
        }
        
        return windowDefinition
    }
}
