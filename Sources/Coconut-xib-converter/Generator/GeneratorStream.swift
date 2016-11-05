//
//  GeneratorTools.swift
//  Coconut-xib-converter
//
//  Created by Dami on 03/11/2016.
//
//

import Foundation

/// Stream geenrator
class GeneratorStream {
    
    private var indentLevel = 0
    private var indented = false
    private var outputStream: OutputStream
    private var prefix = ""
    
    init(output: OutputStream) {
        self.outputStream = output
    }
    
    private func resetPrefix() {
        prefix = ""
        for _ in 0...indentLevel {
            prefix.append("    ")
        }
    }
    
    func pushIndent() {
        indentLevel = indentLevel + 1
        resetPrefix()
    }
    
    
    func popIndent() {
        if (indentLevel > 0) {
            indentLevel = indentLevel - 1
            resetPrefix()
        }
    }
    
    /// Write line whithout endline
    func write(_ str: String) {
        if (!indented) {
            writeUtf8(prefix)
            indented = true
        }
        writeUtf8(str)
    }
    
    private func writeUtf8(_ str: String) {
        if (str.isEmpty) {
            return
        }
        let encodedDataArray = [UInt8](str.utf8)
        outputStream.write(encodedDataArray, maxLength: encodedDataArray.count)
    }
    
    
    /// Write with and line
    func writeLine(_ str: String) {
        write("\(str)\n")
        indented = false
    }
    
    /// Write empty line
    func writeEmptyLine() {
        write("\n")
        indented = false
    }
}
