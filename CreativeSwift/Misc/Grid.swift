//
//  Grid.swift
//  CreativeSwift
//
//  Created by Wirawit Rueopas on 1/21/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

import Foundation

/// An abstraction for grid. Useful for getting a frame in grid coordinate.
public class Grid {
    
    public let nRows: Int
    public let nCols: Int
    
    public let fRows: CGFloat
    public let fCols: CGFloat
    
    private var cachedAllBlocks: [CGRect]? = nil
    
    public var targetRect: CGRect {
        didSet {
            cachedAllBlocks = nil
            blockSize = CGSize.init(width: targetRect.width/CGFloat(nRows), height: targetRect.height/CGFloat(nCols))
        }
    }
    
    public var targetRectInset: UIEdgeInsets = .zero {
        didSet {
            cachedAllBlocks = nil
            blockSize = CGSize.init(width: (targetRect.width-targetRectInset.left-targetRectInset.right)/CGFloat(nRows), height: (targetRect.height-targetRectInset.top-targetRectInset.bottom)/CGFloat(nCols))
        }
    }
    
    /// Cache of block size. Recomputed when targetRect is changed.
    public private(set) var blockSize: CGSize = .zero
    
    public init(rows: Int, cols: Int, targetRect: CGRect = .zero) {
        if rows <= 0 || cols <= 0 { fatalError("Grid cannot have less than zero rows or cols.") }
        
        self.nRows = rows
        self.nCols = cols
        self.fRows = CGFloat(rows)
        self.fCols = CGFloat(cols)
        
        self.targetRect = targetRect
        
        self.blockSize = CGSize.init(width: targetRect.width/CGFloat(nRows), height: targetRect.height/CGFloat(nCols))
    }
    
    public func origin(row: Int, col: Int) -> CGPoint {
        return CGPoint.init(x: targetRect.originX + targetRectInset.left + col.asCGFloat * blockSize.width, y: targetRect.originY + targetRectInset.top + row.asCGFloat * blockSize.height)
    }
    
    /// Is the specified coordinate valid. E.g., is it "in" the grid.
    public func valid(row: Int, col: Int) -> Bool {
        return !(row < 0 || col < 0 || row >= nRows || col >= nCols)
    }
    
    /// Return a frame for single block at (row, col).
    public func block(row: Int, col: Int) -> CGRect {
        if !valid(row: row, col: col) { return .zero }
        return CGRect.init(origin: origin(row: row, col: col), size: blockSize)
    }
    
    /// Returns a frame of grid.
    public func frame(startRow: Int, startCol: Int, endRow: Int, endCol: Int) -> CGRect {
        if !valid(row: startRow, col: startCol) { return .zero }
        if !valid(row: endRow, col: endCol) { return .zero }
        if endRow < startRow || endCol < startCol { return .zero }
        
        let o = origin(row: startRow, col: startCol)
        let size = CGSize.init(width: blockSize.width * (endCol-startCol+1).asCGFloat, height: blockSize.height * (endRow-startRow+1).asCGFloat)
        return CGRect.init(origin: o, size: size)
    }
    
    /// Returns a frame of entire row.
    public func row(_ row: Int) -> CGRect {
        return frame(startRow: row, startCol: 0, endRow: row, endCol: nCols-1)
    }
    
    /// Returns a frame of entire column.
    public func col(_ col: Int) -> CGRect {
        return frame(startRow: 0, startCol: col, endRow: nRows-1, endCol: col)
    }
    
    /// Returns all blocks for this grid. It is cached and invalidated automatically.
    public func allBlocks() -> [CGRect] {
        if let cached = cachedAllBlocks { return cached }
        
        var res: [CGRect] = [CGRect].init(repeating: .zero, count: nRows * nCols)
        for i in 0..<nRows {
            for j in 0..<nCols {                
                res[i*(nCols) + j] = block(row: i, col: j)
            }
        }
        // cache if nil
        cachedAllBlocks = res
        return res
    }
}

