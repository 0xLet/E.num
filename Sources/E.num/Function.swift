//
//  Function.swift
//  E.num
//
//  Created by Zach Eriksen on 9/29/20.
//

import Foundation

@dynamicCallable
public enum Function {
    case void(() -> ())
    case `in`((Variable) -> ())
    case out(() -> Variable)
    case `inout`((Variable) -> Variable)
    
    func dynamicallyCall(withArguments args: [Variable]) -> Variable? {
        guard args.isEmpty else {
            return run()
        }
        
        guard args.count > 1 else {
            return run(args.first)
        }
        
        return run(.array(args))
    }
}


public extension Function {
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
