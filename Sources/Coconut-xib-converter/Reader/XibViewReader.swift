//
//  XibViewReader.swift
//  Coconut-xib-converter
//
//  Created by Dami on 26/10/2016.
//
//

import Foundation

import LibXml2Swift

class XibViewReader : XibElementReader {
    
    func readSubViews(element: XmlDomElement) -> [UiViewDefinition] {
        
        var subViews = [UiViewDefinition]()
        
        // Find subview node
        if let subViewNode = element.child(name: "subviews") {
            for node in subViewNode.children {
                if let child = node as? XmlDomElement {
                    switch child.name {
                    case "button":
                        subViews.append(XibButtonReader().read(element: child))
                        break
                    case "customView":
                        subViews.append(read(element: child))
                        break
                    default:
                        print("Unknow element: \(child.name)")
                    }
                }
            }
        }
        
        return subViews
    }
    
    func read(element: XmlDomElement) -> UiViewDefinition {
        print(" - View : \(element.name)")
        let viewDefinitions = readSubViews(element: element)
        return UiViewDefinition(id: readId(element: element),
                                vName: VNameGenerator.instance.createViewVName(),
                                subViews: viewDefinitions,
                                customClass: readCustomClass(element: element, defaultValue: "View"))
    }
}
