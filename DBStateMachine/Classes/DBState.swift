//
//  DBState.swift
//  DBStateMachine
//
//  Created by ChildhoodAndy on 16/3/30.
//  Copyright © 2016年 Sketchingame. All rights reserved.
//

import Foundation

public class DBState : NSObject {
    /**
     * The state machine that this state is associated with.
     * This is nil if this state hasn't been added to a state machine yet.
     */
    weak public var stateMachine: DBStateMachine?

    /**
     * Returns YES if the given class is a valid next state to enter.
     *
     * By default DBState will return YES for any class that is subclass of DBState.
     * Override this in a subclass to enforce limited edge traversals in the state machine.
     *
     * @see DBStateMachine.canEnterState:
     * @see DBStateMachine.enterState:
     *
     * @param stateClass the class to be checked
     * @return YES if the class is kind of DBState and the state transition is valid, else NO.
     */
    public func isValidNextState(stateClass: AnyClass) -> Bool {
        return stateClass.isSubclassOfClass(DBState.self) || stateClass == DBState.self
    }
    
    /**
     * Called by DBStateMachine when this state is entered.
     *
     * @param previousState the state that was exited to enter this state.  This is nil if this is the state machine's first entered state.
     */
    public func didEnterWithPreviousState(previousState: DBState?) {
       
    }

    /**
     * Called by DBStateMachine when this state is exited
     *
     * @param nextState the state that is being entered next
     */
    public func willExitWithNextState(nextState: DBState) {
        
    }
}