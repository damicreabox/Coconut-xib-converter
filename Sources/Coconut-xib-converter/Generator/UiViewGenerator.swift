//
//  UiViewGenerator.swift
//  Coconut-xib-converter
//
//  Created by Dami on 03/11/2016.
//
//

import Foundation

class UiViewGeneratorDelegate : UIObjectGeneratorDelegate<UiViewDefinition> {
    
    init() {
        super.init(useAfter: true)
    }
    
    override func generateInstanciation(definition: UiViewDefinition, output stream: GeneratorStream) throws {
        stream.write("View(frame: ")
        if let frame = definition.frame {
            stream.write(RectGenerator().newInstance(rect: frame))
        }
        stream.write(")")
    }
    
    override func generateAfter(definition: UiViewDefinition, output stream: GeneratorStream) throws {
        
        // Add view
        for subView in definition.views {
            let generator = try UiGeneratorSelector.instance.findGenerator(definition: subView)
            try generator.generateVariable(definition: subView, output: stream)
            stream.writeLine("\(definition.vName).addSubview(\(subView.vName))")
        }
        
        // Add constraints
        if !definition.constraints.isEmpty {
            
            let layoutConstraintGenerator = UiLayoutConstraintGenerator()
            
            stream.writeLine("var \(definition.vName)Constraints = [LayoutConstraint]()")
            
            for constraint in definition.constraints {
                stream.write("\(definition.vName)Constraints.append(")
                stream.write(layoutConstraintGenerator.newInstance(constraint: constraint))
                stream.writeLine(")")
            }
            
            stream.writeLine("\(definition.vName).constraints = \(definition.vName)Constraints")
            
        }
    }
}
