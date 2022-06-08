import FirebaseAuth

public struct SwiftLogin {
    public private(set) var text = "Hello, World!"

    public init() {

    }
    
    public func printHello() {
        print("Hello!")
    }
}


public final class FirebaseAuthManager: ObservableObject {
    @Published public var userLoggedIn = false
    @Published public var email = ""
    @Published public var password = ""
    
    private let auth = Auth.auth()
    
    public init() {   }
    
    public func login(completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        auth.signIn(withEmail: self.email, password: self.password) { fbResult, error in
            if error != nil {
                completion(.failure(error!))
                return
            }
            if let fbResult = fbResult {
                self.userLoggedIn = true
                completion(.success(fbResult))
            }
        }
    }
}
