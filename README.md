<p align="center">
    <img src="https://github.com/radude89/KeychainStorage/blob/master/Images/Logo.png" width="50%" height="50%" alt="Keychain Storage" />
</p>
<p align="center">
  <img src="https://img.shields.io/badge/Swift-6-orange.svg" />

  <a href="https://swift.org/package-manager">
        <img src="https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat" alt="Swift Package Manager" />
  </a>

</p>

Keychain Storage is a simple Keychain wrapper written in Swift. If you’ve ever wanted to save something in the Keychain without writing excessive code, you’ve come to the right place!

## Requirements

- iOS 18.0+
- Xcode 16.0+
- Swift 6+

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code, integrated into the `swift` compiler.

To add KeychainStorage as a dependency, include it in the `dependencies` array of your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/radude89/KeychainStorage.git", from: "2.0.2")
]
```

## Manual Installation

For manual installation, simply drag and drop the following files into your project from the `KeychainStorage` directory:

- `KeychainQueryFactory.swift`
- `KeychainStorage.swift`
- `KeyValueStorage.swift`

## Examples

Make sure to explore the small app included in the example project found at `Example/KeychainStorageExample.xcworkspace`. Build and run the project to see it in action.

### Saving a Value in the Keychain

```swift
import KeychainStorage

let storage = KeychainStorage(service: "com.test.service")
try? storage.set("secret", key: "myStringKey")
try? storage.set(true, key: "myBoolKey")
```

### Retrieving a Value from the Keychain

```swift
import KeychainStorage

let storage = KeychainStorage(service: "com.test.service")

if let myStringValue = try? storage.string(forKey: "myStringKey") {
    // Do something with myStringValue
}

if let myBoolValue = try? storage.bool(forKey: "myBoolKey") {
    // Do something with myBoolValue
}
```

### Deleting a Value from the Keychain

```swift
import KeychainStorage

let storage = KeychainStorage(service: "com.test.service")
try? storage.removeValue(forKey: "myStringKey")
```

### Deleting All Values from the Keychain

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
