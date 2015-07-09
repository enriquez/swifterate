# Swifterate

Swift code generator. Generate strongly typed enums based on your Info.plist and Asset Catalog. No more magic strings!

## Installation

Swifterate is distributed as a Ruby gem.

```bash
$ gem install swifterate
```

## Usage

After installing, the `swifterate` command is available:

```bash
$ swifterate help
Commands:
  swifterate ac DIR          # Generate Swift code from an Asset Catalog directory located at DIR
  swifterate help [COMMAND]  # Describe available commands or one specific command
  swifterate plist FILE      # Generate Swift code from the .plist file located at FILE
```

The generated Swift code is printed to the console.  You can redirect the output to a file instead:

```bash
$ swifterate plist test/fixtures/Info.plist > InfoPlist.swift
```

## Examples

Swifterate currently supports `.plist` and `.xcassets` as inputs to generate Swift code.

### .plist to Swift Enum

Generate a swift enum from the following MyApp-Info.plist file:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleName</key>
	<string>MyApp</string>
	<key>CFBundleShortVersionString</key>
	<string>1.0.0</string>
	<key>CFBundleVersion</key>
	<string>100</string>
</dict>
</plist>
```

The following is generated with the command: `swifterate plist MyApp-Info.plist`

```swift
enum InfoPlist: String {

    case CFBundleName = "CFBundleName"
    case CFBundleShortVersionString = "CFBundleShortVersionString"
    case CFBundleVersion = "CFBundleVersion"

    private var infoDictionary: [NSObject : AnyObject] {
        return NSBundle.mainBundle().infoDictionary!
    }

    var dictionary: [NSObject : AnyObject]? {
        return infoDictionary[rawValue] as? [NSObject : AnyObject]
    }
    
    var array: [AnyObject]? {
        return infoDictionary[rawValue] as? [AnyObject]
    }
    
    var data: NSData? {
        return infoDictionary[rawValue] as? NSData
    }
    
    var date: NSDate? {
        return infoDictionary[rawValue] as? NSDate
    }
    
    var number: NSNumber? {
        return infoDictionary[rawValue] as? NSNumber
    }
    
    var string: String? {
        return infoDictionary[rawValue] as? String
    }


    init(_ key: InfoPlist) {
        self = key
    }

}
```

To use the generated enum:

```swift
let appName = InfoPlist(.CFBundleName).string! // "MyApp"
```

### Asset Catalog to UIImage Extension

Generate a `UIImage` extension with an enumerated list of assets from the Asset Catalog:

```bash
MyApp.xcassets/
  AppIcon.appiconset/
  LaunchImage.launchimage/
  MyAppLogo.imageset/
  PrimaryButton.imageset/
```

The following is generated with the command: `swifterate ac MyApp.xcassets`

```swift
extension UIImage {
    
    enum MyAppAsset: String {
        case MyAppLogo = "MyAppLogo"
        case PrimaryButton = "PrimaryButton"
    }
    
    convenience init!(assetIdentifier: MyAppAsset) {
        self.init(named: assetIdentifier.rawValue)
    }
    
}
```

Notice that the `AppIcon` and `LaunchImage` aren't included. They cannot be referenced using `UIImage(imageNamed:)`

To use the generated extension:

```swift
let myAppLogo = UIImage(assetIdentifier: .MyAppLogo)
```

## License

Swifterate is available under the MIT license. See the LICENSE file for more info.
