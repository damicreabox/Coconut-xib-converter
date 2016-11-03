//
//  GeneratorTools.swift
//  Coconut-xib-converter
//
//  Created by Dami on 03/11/2016.
//
//

import Foundation

class GeneratorStream {
    
    private var outputStream: OutputStream
    
    init(output: OutputStream) {
        self.outputStream = output
    }
    
    func write(_ str: String) {
        let encodedDataArray = [UInt8](str.utf8)
        outputStream.write(encodedDataArray, maxLength: encodedDataArray.count)
    }
    
    func writeLine(_ str: String) {
        write("\(str)\n")
    }
    
    func writeEmptyLine() {
        write("\n")
    }
}
