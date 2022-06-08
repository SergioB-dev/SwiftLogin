import FirebaseAuth

public struct SwiftLogin {
    public private(set) var text = "Hello, World!"

    public init() {

    }
    
    public func printHello() {
        print("Hello!")
    }
}


public final class FirebaseAuthManager {
    private let auth = Auth.auth()
    
    public init() {   }
    
    public func login(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { x, y in
            print(x, y)
        }
    }
}
