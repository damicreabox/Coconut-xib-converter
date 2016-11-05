//
//  RectGenerator.swift
//  Coconut-xib-converter
//
//  Created by Dami on 26/10/2016.
//
//

import Foundation

/// Generate rect
class RectGenerator {
    
    func newInstance(rect: NSRect) -> String {
        return "NSRect(origin: NSPoint(x: \(rect.origin.x),y: \(rect.origin.y)), size: NSSize(width: \(rect.width), height: \(rect.height)))"
    }
}
