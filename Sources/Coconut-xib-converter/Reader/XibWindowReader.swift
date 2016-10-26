//
//  XibWindowReader.swift
//  Coconut-xib-converter
//
//  Created by Dami on 26/10/2016.
//
//

import Foundation

import LibXml2Swift

class XibWindowReader {
    
    func readWindow(element: XmlDomElement) -> XibWindow {
        print(" - Window : \(element.name)")
        let view: XibCustomView?
        if let viewElement = element.child(name: "view") {
            view = XibViewReader().readView(element: viewElement)
        } else {
            view = nil
        }
        
        // Read Frame
        let rects = XibRectReader().readRects(elements: element.children(name: "rect"))
        
        // Find content rect
        let contentRect = rects["contentRect"]
        
        return XibWindow(id: element["id"]?.name,
                         view: view,
                         frame: contentRect == nil ? NSRect() : contentRect!,
                         customClass: element["customClass"]?.value,
                         title: element["title"]?.value)
    }
}
