//
//  Array+Ex.swift
//  Swift类拓展
//
//  Created by yangyb on 1/21/21.
//

import Foundation

extension Array: SwiftExKitCompatible {}
public extension SwiftExKit where Base: ExpressibleByArrayLiteral, Base.ArrayLiteralElement: Hashable {
    
    func index(_ idx: Int) -> Base.ArrayLiteralElement? {
        let array = self.base as! Array<Base.ArrayLiteralElement>
        guard idx >= 0 && idx < array.count else { return nil }
        return array[idx]
    }
    
    
    func remove(_ element: Base.ArrayLiteralElement) -> [Base.ArrayLiteralElement] {
        let array = self.base as! Array<Base.ArrayLiteralElement>
        return array.filter { $0 != element }
    }
    
    func remove(_ elements: [Base.ArrayLiteralElement]) -> [Base.ArrayLiteralElement] {
        let elsSet = Set(elements)
        let array = self.base as! Array<Base.ArrayLiteralElement>
        return array.filter { !elsSet.contains( $0 ) }
        
    }
    
}
