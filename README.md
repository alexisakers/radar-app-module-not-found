# Mixed Codebase Tests Compilation Error - Example Project

| Radar Number | Status | 
|------------------|---------|
| [rdar://nil](rdar://nil) | Not yet reported |
| [openradar://nil](openradar://nil) | Noy yet reported |

This project demonstrates an Xcode compilation error encountered when building a mixed Swift/Objective-C application test target.

When importing the automatically generated Swift header from an Objective-C test case, Xcode will report that the main app target imported from this header could not be found.

The original issue was raised by this commit on the Wire app: [`b30e985`](https://github.com/wireapp/wire-ios/pull/2352/commits/b30e985896968ddc8dee840e48a10a958d1e2000).

## Configuration

### Main Target

The main application module, `Dogs`, defines a custom collection view layout and a delegate for this layout (`VerticalColumnCollectionViewLayoutDelegate`).

`Dogs` also defines an abstract `UICollectionViewController` subclass that uses this layout and implements its delegate, `VerticalColumnCollectionViewController`.

`Dogs` defines a class in Objective-C, which is imported in Swift through a bridging header, but not used in the abstract class mentioned above.

### Test target

The test target contains two support classes defined in Swift: 

- a random text generator (`Random`) that is used in an Objective-C test case (equivalent of mocks/etc... defined in Swift in the Wire test module and imported in Objective-C test cases)
- a subclass of `VerticalColumnCollectionViewController` that is *not* used in an Objective-C test case (`ColorViewController`).

The test target also defines a base test case that all test cases subclass (`BaseTestCase`). This class is exposed to Swift through the tests' bridging header, which also imports the main application module's bridging header.

The file in which `ColorViewController` is declared imports `Dogs` as `@testable`.

The first test case is written in Objective-C. It tests the `Random` class. It imports it using the automatically generated Swift interface header (`"DogsTests-Swift.h"`).

The second test case is written in Swift. It tests the `VerticalColumnCollectionViewController` abstract class behavior, through the concrete `ColorViewController` subclass defined in the test target. It imports the main application module as `@testable`.

## Failure

The main application target builds, runs, and works as expected.

The compilation error occurs when building the test target:

1. Hit `CMD-U` to start the tests
2. The main application module compiles ✅
3. The Swift sources in the test target compile ✅
4. When compiling the first test case written in Objective-C, compilation stops because the module `Dogs` (main app target), imported by the Swift interface header, could not be found.

## Exploration

We think that the problem lies in the `ColorViewController` definition.

When you define it as a subclass of  `UICollectionViewController`, instead of  `VerticalColumnCollectionViewController`, the test suite will compile and run on the simulator.

We added comments in the `ColorViewController.swift` file to help you reproduce the issue.

Trying to make `VerticalColumnCollectionViewController` and related objects `public` or `@objc` was not helpful.

## License

The pictures of golden retrievers used in the main app were imported from [Stanford Dogs Dataset](http://vision.stanford.edu/aditya86/ImageNetDogs/). 

This example project does not use any parts of the Wire application. It is licensed under the terms of the MIT license. See the [LICENSE](LICENSE) file for details.
