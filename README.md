<p align="center">
    <img src="https://github.com/radude89/KeychainStorage/blob/master/Images/Logo.png" width="50%" height="50%" alt="Keychain Storage" />
</p>
<p align="center">
  <img src="https://api.travis-ci.com/radude89/KeychainStorage.svg?branch=master" alt="build" />
  </a>
  <img src="https://img.shields.io/badge/Swift-5.1-orange.svg" />
  <a href="https://swift.org/package-manager">
        <img src="https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat" alt="Swift Package Manager" />
  </a>
  <a href="https://github.com/Carthage/Carthage">
        <img src="https://img.shields.io/badge/pod-1.3.0-darkorange.svg?style=flat" alt="Carthage" />
  </a>
  <a href="https://swift.org/package-manager">
        <img src="https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat" alt="Carthage" />
  </a>
  <img src="https://img.shields.io/badge/platforms-iOS-brightgreen.svg?style=flat" alt="iOS" />
  <a href="https://twitter.com/johnsundell">
        <img src="https://img.shields.io/badge/twitter-@radude89-blue.svg?style=flat" alt="Twitter: @radude89" />
  </a>
</p>
Keychain Storage is a simple Keychain wrapper written in Swift. <br />
If you ever wanted to save something in Keychain without writing too much code, you are in the right place.<br />

## Requirements

- iOS 12.0+
- Xcode 10.2+
- Swift 5+

## Installation

### Cocoa Pods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate Keychain Storage into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'KeychainStorage', '~> 1.3.0'
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate KeychainStorage into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "radude89/KeychainStorage" "1.3.0"
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

Once you have your Swift package set up, you can add KeychainStorage as a dependency by adding it to the `dependencies` array of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/radude89/KeychainStorage.git", from: "1.0.0")
]
```

### Manual

Just drag and drop into your project the following projects found in `KeychainStorage`:
- `KeychainQueryFactory.swift`
- `KeychainStorage.swift`
- `KeyValueStorage.swift`

## Examples

Make sure you try out the small app, the example project found at: `Example/KeychainStorageExample.xcworkspace`.<br /> Build & run.

### Saving a value in Keychain

```swift
import KeychainStorage

let storage = KeychainStorage(service: "com.test.service")
try? storage.set("secret", key: "myStringKey")

try? storage.set(true, key: "myBoolKey")
```

### Retrieving a value from Keychain

```swift
import KeychainStorage

let storage = KeychainStorage(service: "com.test.service")

if let myStringValue = try? storage.string(forKey: "myStringKey") {
    // do something with myStringValue
}

if let myBoolValue = try? storage.bool(forKey: "myBoolKey") {
    // do something with myBoolValue
}
```

### Deleting a value from Keychain

```swift
import KeychainStorage

let storage = KeychainStorage(service: "com.test.service")
try? storage.removeValue(forKey: "myStringKey")
```

### Deleting all values from Keychain

```swift
import KeychainStorage

let storage = KeychainStorage(service: "com.test.service")
try? storage.removeAll()
```
## License

KeychainStorage is released under the MIT license. [See LICENSE](https://github.com/radude89/KeychainStorage/blob/master/LICENSE) for details.

## Contributions & support

KeychainStorage is developed as an open source project. I encourage everyone to contribute. <br />

Please do make pull requests if you have suggestions or ideas of improvement.

Thanks!
