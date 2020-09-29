//
//  Function.swift
//  E.num
//
//  Created by Zach Eriksen on 9/29/20.
//

import Foundation

enum Function {
    case void(() -> ())
    case `in`((Variable) -> ())
    case out(() -> Variable)
    case `inout`((Variable) -> Variable)
    
    @discardableResult
    func run(_ value: Variable? = nil) -> Variable? {
        switch self {
        case .void(let closure):
            closure()
        case .in(let closure):
            if let value = value {
                closure(value)
            }
        case .out(let closure):
            return closure()
        case .inout(let closure):
            if let value = value {
                return closure(value)
            }
        }
        
        return nil
    }
}
