# Swifterate

Swift code generator. Generate strongly typed enums based on your Info.plist and Asset Catalog.

## Installation

Swifterate is distributed as a Ruby gem.

```bash
$ gem install swifterate
```

## Usage

After installing, the `swifterate` command is available:

```bash
$ swifterate --help

# TODO: show help here
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

The following is generated with the command: `swifterate MyApp-Info.plist InfoPlist`

```swift
enum InfoPlist: String {

    case CFBundleName = "CFBundleName"
    case CFBundleShortVersionString = "CFBundleShortVersionString"
    case CFBundleVersion = "CFBundleVersion"

    private var infoDictionary: [NSObject : AnyObject] {
        return NSBundle.mainBundle().infoDictionary!
    }

    var dictionary: [NSObject : AnyObject] {
        return infoDictionary[rawValue] as! [NSObject : AnyObject]
    }
    
    var array: [AnyObject] {
        return infoDictionary[rawValue] as! [AnyObject]
    }
    
    var data: NSData {
        return infoDictionary[rawValue] as! NSData
    }
    
    var date: NSDate {
        return infoDictionary[rawValue] as! NSDate
    }
    
    var number: NSNumber {
        return infoDictionary[rawValue] as! NSNumber
    }
    
    var string: String {
        return infoDictionary[rawValue] as! String
    }


    init(_ key: InfoPlist) {
        self = key
    }

}
```

To use the generated enum:

```swift
let appName = InfoPlist(.CFBundleName).string // "MyApp"
```

### Asset Catalog to UIImage Extension

Generate a `UIImage` extension with an enumerated list of assets from the Asset Catalog:

```bash
MyApp.xcassets/
  AppIcon.appiconset/
  LaunchImage.launchimage/
  MyAppLogo.appiconset/
  PrimaryButton.appiconset/
```

The following is generated with the command: `swifterate MyApp.xcassets AssetIdentifier`

```swift
extension UIImage {
    
    enum AssetIdentifier: String {
        case MyAppLogo = "MyAppLogo"
        case PrimaryButton = "PrimaryButton"
    }
    
    convenience init!(assetIdentifier: AssetIdentifier) {
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
