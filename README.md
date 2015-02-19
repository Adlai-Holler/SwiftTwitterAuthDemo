# SwiftTwitterAuthDemo

A simple Swift app used to demonstrate two different ways of doing a multi-step Twitter auth flow.

One way is using conventional completion blocks. But this gets you into callback hell lickety split.

The other way is using ReactiveCocoa (note: the work-in-progress Swift version), which is intimidating-looking, but much more composable and reusable.

## How to use

This repo uses Carthage to manage its dependency on ReactiveCocoa. Install [carthage](https://github.com/Carthage/Carthage) and then run `carthage update` from the root of the repo.
