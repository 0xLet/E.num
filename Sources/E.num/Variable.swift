//
//  Variable.swift
//  E.num
//
//  Created by Zach Eriksen on 9/29/20.
//

import Foundation

public enum Variable: Equatable, Hashable {
    case void
    case bool(Bool)
    case int(Int)
    case float(Float)
    case double(Double)
    case string(String)
    case set(Set<Variable>)
    case array([Variable])
    case dictionary([Variable: Variable])
}
