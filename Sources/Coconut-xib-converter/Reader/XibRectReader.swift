//
//  XibRectReader.swift
//  Coconut-xib-converter
//
//  Created by Dami on 26/10/2016.
//
//

import Foundation

import LibXml2Swift

class XibRectReader {
    
    func readInt(_ text: String?) -> Int {
        
        guard let text = text else {
            return 0
        }
        
        guard let i = Int(text) else {
            return 0
        }
        
        return i
    }
    
    func readRect(node: XmlDomNode?) -> (name: String, rect: NSRect) {
        
        guard let node = node else {
            return ("", NSRect())
        }
        
        let key = node["key"]
        
        return (
            (key == nil ? "" : key!.value),
            NSRect(
                origin: NSPoint(x: readInt(node["x"]?.value), y: readInt(node["y"]?.value)),
                size: NSSize(width: readInt(node["width"]?.value), height: readInt(node["height"]?.value))
            )
        )
    }
    
    func readRects(elements: [XmlDomElement]) -> Dictionary<String, NSRect> {
        var rects = Dictionary<String, NSRect>()
        for element in elements {
            let rect = readRect(node: element)
            rects[rect.name] = rect.rect
        }
        return rects
    }
    
}
