//
//  SourceEditorCommand.swift
//  Jumper-extension
//
//  Created by Deszip on 28/06/16.
//  Copyright © 2016 FHOF. All rights reserved.
//

import Foundation
import XcodeKit

struct LineShift {
    let command: String
    let value: Int
}

enum ShiftCommand {
    case up5(String, Int)
    case down5(String, Int)
    case up2(String, Int)
    case down2(String, Int)
}

class SourceEditorCommand: NSObject, XCSourceEditorCommand {

    // MARK: - XCSourceEditorCommand -
    
    public func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) {
        let buffer = invocation.buffer
        if let insertionRange = insertionRange(buffer: buffer) {
            var shiftValue = 0
            switch invocation.commandIdentifier {
                case "FH.Jumper.Jumper-extension.Up5"   : shiftValue = -5
                case "FH.Jumper.Jumper-extension.Down5" : shiftValue = 5
                case "FH.Jumper.Jumper-extension.Up2"   : shiftValue = -2
                case "FH.Jumper.Jumper-extension.Down2" : shiftValue = 2
                
                default: ()
            }
            
            buffer.selections.removeAllObjects()
            buffer.selections[0] = shiftedRange(initialRange: insertionRange, linesShift: shiftValue, buffer: buffer)
        }
        
        completionHandler(nil)
    }
    
    // MARK: - Tools -
    
    private func insertionRange(buffer: XCSourceTextBuffer) -> XCSourceTextRange? {
        for selection in buffer.selections {
            if let range = selection as? XCSourceTextRange {
                if range.start.line == range.end.line &&
                    range.start.column == range.end.column {
                    return range
                }
            }
        }
        
        return nil
    }
    
    private func shiftedRange(initialRange: XCSourceTextRange, linesShift: Int, buffer: XCSourceTextBuffer) -> XCSourceTextRange {
        let shiftedRange = XCSourceTextRange()
        shiftedRange.start = initialRange.start
        shiftedRange.end = initialRange.end
        
        var shift: Int
        
        if initialRange.start.line + linesShift > buffer.lines.count - 1 {
            shift = buffer.lines.count - 1
        } else if initialRange.start.line + linesShift < 0 {
            shift = 0
        } else {
            shift = shiftedRange.start.line + linesShift
        }
        
        shiftedRange.start.line = shift
        shiftedRange.end.line = shift
        
        return shiftedRange
    }
}
