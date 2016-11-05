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
    
    func read(element: XmlDomElement) -> UiWindowDefinition {
        print(" - Window : \(element.name)")
        let view: UiViewDefinition?
        if let viewElement = element.child(name: "view") {
            view = XibViewReader().read(element: viewElement)
        } else {
            view = nil
        }
        
        // Read Frame
        let rects = XibRectReader().readRects(elements: element.children(name: "rect"))
        
        // Find content rect
        let contentRect = rects["contentRect"]
        
        let windowDefinition = DefinitionFactory.instance.window(id: readId(element: element))
        
        // Set rectangle
        if let contentRect = contentRect {
            windowDefinition.contentRect = contentRect
        }
        
        // Set view
        windowDefinition.view = view
        
        // Custom clas
        windowDefinition.customClass = readCustomClass(element: element, defaultValue: "Window")
        
        // Set title
        windowDefinition.title = readText(element: element, attr: "title")
        
        return windowDefinition
    }
}
