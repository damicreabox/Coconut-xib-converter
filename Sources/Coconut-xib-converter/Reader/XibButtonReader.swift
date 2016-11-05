//
//  XibButtonReader.swift
//  Coconut-xib-converter
//
//  Created by Dami on 26/10/2016.
//
//

import Foundation

import LibXml2Swift

class XibButtonReader : XibElementReader {
    
    func read(element: XmlDomElement) -> UiButtonDefinition {
        print(" - Button : \(element.name)")
        
        // Set button
        let buttonDefinition = DefinitionFactory.instance.button(id: readId(element: element))
                
        return buttonDefinition
    }
}
