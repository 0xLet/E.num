//
//  Control.swift
//  E
//
//  Created by Zach Eriksen on 9/29/20.
//

enum Control {
    case `if`(Bool, Function)
    case `else`(Bool, Function)
    case ifElse(Bool, Function, Function)
    case loop(ClosedRange<Int>, Function)
    case forEach([Variable], Function)
    case forever(Function)
}

extension Control {
    func run() {
        switch self {
        case .if(let condition, let function):
            if condition {
                function()
            }
        case .else(let condition, let function):
            if !condition {
                function()
            }
        case .ifElse(let condition, let trueFunction, let falseFunction):
            if condition {
                trueFunction()
            } else {
                falseFunction()
            }
        case .loop(let range, let function):
            for value in range {
                function.run(.int(value))
            }
        case .forEach(let values, let function):
            for value in values {
                function.run(value)
            }
        case .forever(let function):
            while true {
                function()
            }
        }
    }
}

