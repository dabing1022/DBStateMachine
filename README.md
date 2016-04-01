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

GKStateMachine only can be used iOS9+, but I want perfect downward compatible. Just use it directly as if it's shipped from iOS6.

# Requirements

- iOS6+

## Installation

## API Reference

Depending on the size of the project, if it is small and simple enough the reference docs can be added to the README. For medium size to larger projects it is important to at least provide a link to where the API reference docs live.

## Contributors

Please let me know if you like the library, or have any suggestions:]. I plan to maintain this library regularly. Any pull requests are welcome!

## License

DBStateMachine is available under the MIT license. See the LICENSE file for more info.
