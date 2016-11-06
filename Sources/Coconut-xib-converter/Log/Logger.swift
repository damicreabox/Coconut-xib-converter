
import Foundation

public enum Level {
    case SEVERE
    case WARNING
    case INFO
    case FINE
}

public class Logger {
    
    private let name: String
    
    private init(name: String) {
        self.name = name
    }
    
    static func getLogger(name: String) -> Logger {
        return Logger(name: name)
    }
    
    public func log(_ level: Level, _ error: Error) {
        log(level, error.localizedDescription)
    }
    
    public func log(_ level: Level, _ message: String) {
        //print("\(name) : \(level) : \(message)")
        print("\(level)\t| \(message)")
        //print("\(message)")
    }
}
