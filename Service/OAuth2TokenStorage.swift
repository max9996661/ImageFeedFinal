
import UIKit

protocol OAuth2TokenStorageProtocol {
    var token: String? { get set }
}

class OAuth2TokenStorage: OAuth2TokenStorageProtocol {
    private let userDefaults = UserDefaults.standard
    
    private enum Keys: String {
            case token
        }
    
    var token: String? {
        get {
            userDefaults.string(forKey: Keys.token.rawValue)
        }
        set {
            return userDefaults.set(newValue, forKey: Keys.token.rawValue)
        }
    }
    
    
    
}
