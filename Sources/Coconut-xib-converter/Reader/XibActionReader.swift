//
//  XibConnexionReader.swift
//  Coconut-xib-converter
//
//  Created by Dami on 05/11/2016.
//
//

import Foundation

import LibXml2Swift

class XibActionReader : XibElementReader {
 
    func read(element: XmlDomElement) -> UiActionDefinition {
        
        let actionDefiniton = DefinitionFactory.instance.action(id: readId(element: element));
        return actionDefiniton
    }
}
