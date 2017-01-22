//
//  Read.swift
//  CreativeSwift
//
//  Created by Wirawit Rueopas on 1/21/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

import Foundation


public func filePath(for filename: String, type: String?) -> String? {
    let nsFilename = NSString(string: filename)
    let defaultFilename = type == nil ? nsFilename.deletingPathExtension : filename
    let defaultType = type == nil ? nsFilename.pathExtension : type
    return Bundle.main.path(forResource: defaultFilename, ofType: defaultType)
}

public func fileUrl(for filename: String, type: String?) -> URL? {
    let nsFilename = NSString(string: filename)
    let defaultFilename = type == nil ? nsFilename.deletingPathExtension : filename
    let defaultType = type == nil ? nsFilename.pathExtension : type
    return Bundle.main.url(forResource: defaultFilename, withExtension: defaultType)
}

/// Load Data. A universal data type.
public func loadFile(filename: String) -> Data? {
    guard let fileUrl = fileUrl(for: filename, type: nil) else { return nil }
    let data = try? Data.init(contentsOf: fileUrl)
    return data
}

public enum StringSeparatorOption {
    
    /// Raw text content.
    case none
    
    case newlines
    case commas
    
    /// Custom string to separate the content.
    case string(s: String)
}

/// Read strings from file.
/// - Parameters:
///     - filename: **file's name (including extension, e.g. "test.txt").**
///     - separatedBy: how to separate content. Default is .newlines.
/// - Returns: Array of strings. If 'separatedBy' is .none, it returns array of string with only 1 member, the raw content.
public func loadStrings(filename: String, separatedBy: StringSeparatorOption = .newlines) -> [String]? {
    guard let filePath = filePath(for: filename, type: nil) else { return nil }
    guard let data = try? String.init(contentsOfFile: filePath, encoding: .utf8) else { return nil }
    switch separatedBy {
    case .none: return [data]
    case .newlines: return data.components(separatedBy: .newlines)
    case .commas: return data.components(separatedBy: ",")
    case .string(let s): return data.components(separatedBy: s)
    }
}

/// Read raw string.
public func loadString(filename: String) -> String? {
    guard let s = loadStrings(filename: filename, separatedBy: .none), s.count > 0 else { return nil }
    return s[0]
}

/// Read image with name.
public func loadImage(imageName: String) -> UIImage? {
    return UIImage(named: imageName)
}
