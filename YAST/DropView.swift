//
//  DropView.swift
//  YAST
//
//  Created by Gendler, Bob (Fed) on 8/27/19.
//  Copyright © 2019 Gendler, Bob (Fed). All rights reserved.
//

import Cocoa

protocol DragViewDelegate {
    func dragView(didDragFileWith URL: String)
}

class DropView: NSView {

    let NSFilenamesPboardType = NSPasteboard.PasteboardType("NSFilenamesPboardType")
    var delegate: DragViewDelegate?
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // Declare and register an array of accepted types
        registerForDraggedTypes([NSPasteboard.PasteboardType(kUTTypeFileURL as String),
                                 NSPasteboard.PasteboardType(kUTTypeItem as String)])
    }
    
    let fileTypes = ["csv"]
    var fileTypeIsOk = false
    var droppedFilePath: String?
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        if checkExtension(drag: sender) {
            fileTypeIsOk = true
            return .copy
        } else {
            fileTypeIsOk = false
            return []
        }
    }
    
    override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
        if fileTypeIsOk {
            return .copy
        } else {
            return []
        }
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        if let board = sender.draggingPasteboard.propertyList(forType: NSFilenamesPboardType) as? NSArray,
            let imagePath = board[0] as? String {
            print(imagePath)
            // THIS IS WERE YOU GET THE PATH FOR THE DROPPED FILE
            delegate?.dragView(didDragFileWith: imagePath)
            droppedFilePath = imagePath
            return true
        }
        return false
    }
    
    func checkExtension(drag: NSDraggingInfo) -> Bool {
        if let board = drag.draggingPasteboard.propertyList(forType: NSFilenamesPboardType) as? NSArray,
            let path = board[0] as? String {
            let url = NSURL(fileURLWithPath: path)
            if let fileExtension = url.pathExtension?.lowercased() {
                return fileTypes.contains(fileExtension)
            }
        }
        return false
    }
    
}
