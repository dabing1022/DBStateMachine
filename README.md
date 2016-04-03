# Synopsis

A swift library for implementing state machine just like GKStateMachine in GameplayKit.

# Code Example

```swift
class BoxColorState : DBState {
    var boxView: UIView?
    var logTextView: UITextView?

    init(boxView: UIView?, logTextView: UITextView?) {
        self.boxView = boxView
        self.logTextView = logTextView
        super.init()
    }
}

class GrayState : BoxColorState {

    override func isValidNextState(stateClass: AnyClass) -> Bool {
        return stateClass == RedState.self || stateClass == GreenState.self
    }

    override func didEnterWithPreviousState(previousState: DBState?) {
        self.boxView?.backgroundColor = UIColor.grayColor()
        UIView.animateWithDuration(3.5) {
            self.boxView?.layer.opacity = 0.2
        }
        self.logTextView?.text.appendContentsOf("\ngray state did enter...")
    }

    override func willExitWithNextState(nextState: DBState) {
        UIView.animateWithDuration(0.5) {
            self.boxView?.layer.opacity = 1.0
        }

        self.logTextView?.text.appendContentsOf("\ngray state will exit...")
    }
}

class RedState : BoxColorState {
    override func isValidNextState(stateClass: AnyClass) -> Bool {
        return stateClass == GreenState.self
    }

    override func didEnterWithPreviousState(previousState: DBState?) {
        self.boxView?.backgroundColor = UIColor.redColor()
        UIView.animateWithDuration(0.5) {
            self.boxView?.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2)
        }
        self.logTextView?.text.appendContentsOf("\nred state did enter...")
    }

    override func willExitWithNextState(nextState: DBState) {
        UIView.animateWithDuration(0.5) {
            self.boxView?.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)
        }
        self.logTextView?.text.appendContentsOf("\nred state will exit...")
    }
}

class GreenState : BoxColorState {
    override func isValidNextState(stateClass: AnyClass) -> Bool {
        return stateClass == BlueState.self
    }

    override func didEnterWithPreviousState(previousState: DBState?) {
        self.boxView?.backgroundColor = UIColor.greenColor()
        UIView.animateWithDuration(0.5) {
            self.boxView?.transform = CGAffineTransformRotate(CGAffineTransformIdentity, 2.5)
        }
        self.logTextView?.text.appendContentsOf("\ngreen state did enter...")
    }

    override func willExitWithNextState(nextState: DBState) {
        UIView.animateWithDuration(0.5) {
            self.boxView?.transform = CGAffineTransformRotate(CGAffineTransformIdentity, 0)
        }
        self.logTextView?.text.appendContentsOf("\ngreen state will exit...")
    }
}

class BlueState : BoxColorState {
    override func isValidNextState(stateClass: AnyClass) -> Bool {
        return stateClass == BlackState.self
    }

    override func didEnterWithPreviousState(previousState: DBState?) {
        self.boxView?.backgroundColor = UIColor.blueColor()
        UIView.animateWithDuration(0.5) {
            self.boxView?.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1)
        }
        self.logTextView?.text.appendContentsOf("\nblue state did enter...")
    }

    override func willExitWithNextState(nextState: DBState) {
        UIView.animateWithDuration(0.5) {
            self.boxView?.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1)
        }
        self.logTextView?.text.appendContentsOf("\nblue state will exit...")
    }
}

class BlackState : BoxColorState {
    override func isValidNextState(stateClass: AnyClass) -> Bool {
        return stateClass == GrayState.self
    }

    override func didEnterWithPreviousState(previousState: DBState?) {
        self.boxView?.backgroundColor = UIColor.blackColor()
        self.boxView?.layer.cornerRadius = 20
        self.logTextView?.text.appendContentsOf("\nblack state did enter...")
    }

    override func willExitWithNextState(nextState: DBState) {
        self.boxView?.layer.cornerRadius = 0
        self.logTextView?.text.appendContentsOf("\nblack state will exit...")
    }
}

···

let grayState = GrayState(boxView: boxView, logTextView: logTextView)
let redState = RedState(boxView: boxView, logTextView: logTextView)
let greenState = GreenState(boxView: boxView, logTextView: logTextView)
let blueState = BlueState(boxView: boxView, logTextView: logTextView)
let blackState = BlackState(boxView: boxView, logTextView: logTextView)
stateMachine = DBStateMachine(states: [grayState, redState, greenState, blueState, blackState])
stateMachine.enterState(GrayState)
···

```

# Motivation

GKStateMachine only can be used iOS9+, but I want perfect downward compatible. Just use it directly as if it's shipped from iOS7.

# Requirements

- iOS7+
- Swift

# API Reference

A `DBStateMachine` object manages a finite-state machine - a collection of states that has at all times a single current state, a means for transitioning from the current state to another in the collection, and a set of rules that determines which transitions between states are valid.

To build a state machine, first define a distinct subclass of `DBState` for each possible state of the machine. In each state class, the `isValidNextState:` method determines which other state classes the machine may transition into from that state.Then, create a state machine object by constructing instances of the state classes and passing them to initializer. Finally, set the machine in motion by choosing an initial state for it to enter with the `enterState:` method.

To define state-dependent behavior, override the `didEnterWithPreviousState:`, and `willExitWithNextState:` methods in each `DBState` subclass.

# Reference
- [GKStateMachine](https://developer.apple.com/library/ios/documentation/GameplayKit/Reference/GKStateMachine_Class/#//apple_ref/doc/uid/TP40015208-CH1-SW5)
- [State Machines](https://developer.apple.com/library/ios/documentation/General/Conceptual/GameplayKit_Guide/StateMachine.html#//apple_ref/doc/uid/TP40015172-CH7)

# Contributors

Please let me know if you like the library, or have any suggestions:]. I plan to maintain this library regularly. Any pull requests are welcome!

- Email: dabing1022@gmail.com
- Blog: http://dabing1022.github.io

# License

DBStateMachine is available under the MIT license. See the LICENSE file for more info.
