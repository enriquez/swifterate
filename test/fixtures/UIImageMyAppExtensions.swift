extension UIImage {
    
    enum MyAppAsset: String {
        case MyAppLogo = "MyAppLogo"
        case PrimaryButton = "PrimaryButton"
    }
    
    convenience init!(assetIdentifier: MyAppAsset) {
        self.init(named: assetIdentifier.rawValue)
    }
    
}
