//
//  VNameGenerator.swift
//  Coconut-xib-converter
//
//  Created by Dami on 05/11/2016.
//
//

import Foundation

class VNameGenerator {
    
    static let instance = VNameGenerator()
    
    private init() {
        
    }
    
    private var objectCount = -1
    public func createCustomObjectVName() -> String {
        objectCount = objectCount + 1
        return "object\(objectCount)"
    }
    
    private var windowCount = -1
    public func createWindowVName() -> String {
        windowCount = windowCount + 1
        return "window\(windowCount)"
    }
    
    private var viewCount = -1
    public func createViewVName(type: String = "view") -> String {
        viewCount = viewCount + 1
        return "\(type)\(viewCount)"
    }
}
