//
//  State.swift
//  E
//
//  Created by Zach Eriksen on 10/31/20.
//

public enum StateAction {
    case none
    case some(Function)
}

public extension StateAction {
    func act() {
        guard case .some(let action) = self else {
            return
        }
        
        action()
    }
}

public indirect enum StateResult {
    case none
    case transition(State)
    case some(action: StateAction)
    case condition(true: StateResult, false: StateResult, statement: () -> Bool)
}

public extension StateResult {
    func resolve() {
        switch self {
        case .none:
            return
        case .transition(let state):
            state.run()
        case .some(let action):
            action.act()
        case .condition(let trueResult, let falseResult, let statement):
            if statement() {
                trueResult.resolve()
            } else {
                falseResult.resolve()
            }
        }
    }
}

public indirect enum State {
    case cyclic(action: StateAction, to: State, while: () -> Bool)
    case some(with: StateResult)
    case transition(to: State, with: StateResult)
}

public extension State {
    func run() {
        switch self {
        case .cyclic(let action, let to, let statement):
            guard statement() else {
                return to.run()
            }
            
            action.act()
            run()
            
        case .some(let action):
            action.resolve()
            
        case .transition(let to, let action):
            action.resolve()
            to.run()
        }
    }
}
