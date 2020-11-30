import UIKit

let testDelegateString = "TheBourneChallengeTests.TestAppDelegate"
let appDelegateClass: AnyClass = NSClassFromString(testDelegateString) ?? AppDelegate.self

UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    nil,
    NSStringFromClass(appDelegateClass)
)
