//
//  ViewGenerator.swift
//  Coconut-xib-converter
//
//  Created by Dami on 25/10/2016.
//
//

import Foundation

class ViewGenerator {
    
    
    // ------ Views ------
    
    // Definitions
    func definition(view: XibCustomView, index: Int, to stream: OutputStream) -> Int {
        UIDefinitionWriter.write(line: "    private let view\(index): \(view.customClass)\n", to: stream)
        return index + 1
    }
    
    // Definitions
    func instanciation(view: XibCustomView, index: Int, to stream: OutputStream) -> Int {
        UIDefinitionWriter.write(line: "        self.view\(index) = \(view.customClass)()\n", to: stream)
        return index + 1
    }
}
