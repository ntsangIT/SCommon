//
//  Logger.swift
//  Core
//
//  Copyright © 2020 FLYG. All rights reserved.
//

import Foundation

open class SLog {
    
    /// This variable config in Appdelegate.
    static var writeToFile: Bool = false
    
    private let lineFormat: String = ""
    
    private static let pathToLog: String = ""
    
    /// Disallows direct instantiation e.g.: "SLog()"
    private init() {}
    
    // MARK: - Logging
    
    open class func log(_ message: Any = "",
                   withEmoji: Bool = false,
                   filename: String = #file,
                   function: String =  #function,
                   line: Int = #line) {
        
        #if DEBUG
        if withEmoji {
            let body = emojiBody(filename: filename, function: function, line: line)
            emojiLog(messageHeader: emojiHeader(), messageBody: body)
        } else {
            let body = regularBody(filename: filename, function: function, line: line)
            regularLog(messageHeader: regularHeader(), messageBody: body)
        }
        
        let messageString = String(describing: message)
        guard !messageString.isEmpty else { return }
        print(" └ 📣 \(messageString)\n")
        #endif
        
        // write log to file.
        if writeToFile {
            writeFile(path: pathToLog)
        }
    }
    
    private class func writeFile(path: String) {
        
    }
}

// MARK: - Private

// MARK: Emoji
private extension SLog {
    
    class func emojiHeader() -> String {
        return "⏱ \(formattedDate())"
    }
    
    class func emojiBody(filename: String, function: String, line: Int) -> String {
        return "🗂 \(filenameWithoutPath(filename: filename)), in 🔠 \(function) at #️⃣ \(line)"
    }
    
    class func emojiLog(messageHeader: String, messageBody: String) {
        print("\(messageHeader) │ \(messageBody)")
    }
}

// MARK: Regular
private extension SLog {
    
    class func regularHeader() -> String {
        return " \(formattedDate()) "
    }
    
    class func regularBody(filename: String, function: String, line: Int) -> String {
        return " \(filenameWithoutPath(filename: filename)), in \(function) at \(line) "
    }
    
    class func regularLog(messageHeader: String, messageBody: String) {
        //        let headerHorizontalLine = horizontalLine(for: messageHeader)
        //        let bodyHorizontalLine = horizontalLine(for: messageBody)
        //
        //        print("┌\(headerHorizontalLine)┬\(bodyHorizontalLine)┐")
        print("│\(messageHeader)│\(messageBody)│")
        //        print("└\(headerHorizontalLine)┴\(bodyHorizontalLine)┘")
    }
    
    /// Returns a `String` composed by horizontal box-drawing characters (─) based on the given message length.
    ///
    /// For example:
    ///
    ///     " ViewController.swift, in viewDidLoad() at 26 " // Message
    ///     "──────────────────────────────────────────────" // Returned String
    ///
    /// Reference: [U+250x Unicode](https://en.wikipedia.org/wiki/Box-drawing_character)
    class func horizontalLine(for message: String) -> String {
        return Array(repeating: "─", count: message.count).joined()
    }
}

// MARK: Util
private extension SLog {
    
    /// "/Users/blablabla/Class.swift" becomes "Class.swift"
    class func filenameWithoutPath(filename: String, withoutPath: Bool = false) -> String {
        return URL(fileURLWithPath: filename).lastPathComponent
    }
    
    /// E.g. `15:25:04.749`
    class func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss.SSS"
        return "\(dateFormatter.string(from: Date()))"
    }
}
