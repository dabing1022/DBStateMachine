//
//  DBStateMachine.swift
//  DBStateMachine
//
//  Created by ChildhoodAndy on 16/3/30.
//  Copyright © 2016年 Sketchingame. All rights reserved.
//

import Foundation

public class DBStateMachine : NSObject {
    
    private var states: [DBState]
    
    /**
     * The current state that the state machine is in.
     * Prior to the first called to enterState this is equal to nil.
     */
    public var currentState: DBState?
    
    public init(states: [DBState]) {
        self.states = states
        
        super.init()
        
        for state in self.states {
            state.stateMachine = self
        }
    }
    
    /**
     * Returns YES if the indicated class is a a valid next state or if currentState is nil
     *
     * @param stateClass the class of the state to be tested
     */
    public func canEnterState(stateClass: AnyClass) -> Bool {
        if let state = self.currentState {
            return state.isValidNextState(stateClass)
        } else {
            return true
        }
    }
    
    /**
     * Calls canEnterState to check if we can enter the given state and then enters that state if so.
     * [DBState willExitWithNextState:] is called on the old current state.
     * [DBState didEnterWithPreviousState:] is called on the new state.
     *
     * @param stateClass the class of the state to switch to
     * @return YES if state was entered.  NO otherwise.
     */
    public func enterState(stateClass: AnyClass) -> Bool {
        if self.canEnterState(stateClass) {
            if let nextState = self.stateForClass(stateClass) {
                
                self.currentState?.willExitWithNextState(nextState)
                nextState.didEnterWithPreviousState(self.currentState)
                
                self.currentState = nextState
                
                return true
            }
            
        }
        return false
    }
    
    public func stateForClass(stateClass: AnyClass) -> DBState? {
        for state in self.states {
            if state.isKindOfClass(stateClass) {
                return state
            }
        }
        
        return nil
    }
}