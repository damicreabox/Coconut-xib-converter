//
//  WindowGenerator.swift
//  Coconut-xib-converter
//
//  Created by Dami on 25/10/2016.
//
//

import Foundation

class WindowGenerator {
    
    // Definitions
    func definition(window: XibWindow, index: Int, to stream: OutputStream) -> Int {
        UIDefinitionWriter.write(line: "    private let window\(index): \(window.customClass)\n", to: stream)
        return index + 1
    }
    
    // Definitions
    func instanciation(window: XibWindow, index: Int, to stream: OutputStream) -> Int {
        UIDefinitionWriter.write(line: "        self.window\(index) = \(window.customClass)()\n", to: stream)
        return index + 1
    }
}
