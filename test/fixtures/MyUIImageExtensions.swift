extension UIImage {
    
    enum AssetIdentifier: String {
        case MyAppLogo = "MyAppLogo"
        case PrimaryButton = "PrimaryButton"
    }
    
    convenience init!(assetIdentifier: AssetIdentifier) {
        self.init(named: assetIdentifier.rawValue)
    }
    
}
