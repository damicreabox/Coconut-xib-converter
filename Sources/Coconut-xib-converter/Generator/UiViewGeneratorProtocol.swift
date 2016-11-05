//
//  UiViewGeneratorProtocol.swift
//  Coconut-xib-converter
//
//  Created by Dami on 03/11/2016.
//
//

import Foundation

protocol UiViewGeneratorProtocol {
    func generateAttributeDefinition(uiViewDefinition: UiViewDefinition, output stream: GeneratorStream) throws
    func generateAttribute(uiViewDefinition: UiViewDefinition, output stream: GeneratorStream) throws
    func generateVariable(uiViewDefinition: UiViewDefinition, output stream: GeneratorStream) throws
    func generateInstanciate(uiViewDefinition: UiViewDefinition, output stream: GeneratorStream) throws
}
