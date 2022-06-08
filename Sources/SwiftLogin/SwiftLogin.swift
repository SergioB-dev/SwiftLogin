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
    
    public func login(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { fbResult, error in
            if error != nil {
                completion(.failure(error!))
                return
            }
            if let fbResult = fbResult {
                completion(.success(fbResult))
            }
        }
    }
}
