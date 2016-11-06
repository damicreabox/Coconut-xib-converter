import LibXml2Swift

import Foundation

let arguments = CommandLine.arguments

var file = "Files/MyNewView.xib"
var output = "/Users/dami/XCode/Creabox/Coconut/Sources/Coconut/Sample/"

var index = 0
let size = arguments.count
while index < size {
    
    switch arguments[index] {
        
    case "file" :
        index += 1
        if (index < size) {
            file = arguments[index]
            print(" - \(arguments[index - 1]) : \(file)")
        }
        break
        
    case "output":
        index += 1
        if (index < size) {
            output = arguments[index]
            print(" - \(arguments[index - 1]) : \(output)")
        }
        break
        
    default:
        print("Unknow options : \(arguments[index])")
	break
    }
    index += 1
}

guard let url = URL(string: file) else {
    exit(1)
}

let logger = Logger.getLogger(name: #file)
do {
        
    // Set ui definition
    let uiDefinition = try XibDefinitionReader.read(at: url)
    
    // Generate files
    try UiDefinitionFileGenerator().generate(uiDefinitionFile: uiDefinition, at: URL(fileURLWithPath: output))
        
} catch {
    logger.log(.SEVERE, error)
    exit(1)
}
