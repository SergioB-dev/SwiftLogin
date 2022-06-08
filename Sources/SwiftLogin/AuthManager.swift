//
//  File.swift
//  
//
//  Created by Sergio Bost on 6/7/22.
//

import Foundation
import FirebaseAuth

open class FirebaseAuthProvider {
    public let auth = Auth.auth()
    public init() {}
}

public final class FirebaseAuthManager: FirebaseAuthProvider, ObservableObject {
    @Published public var userLoggedIn = false
    @Published public var email = ""
    @Published public var password = ""
    
    public override init() {
        super.init()
    }
    
    // TODO: Refactor, get rid of unused callback
    public func login(completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        auth.signIn(withEmail: self.email, password: self.password) { fbResult, error in
            if error != nil {
                print(error!.localizedDescription)
                completion(.failure(error!))
                return
            }
            if let fbResult = fbResult {
                self.userLoggedIn = true
                completion(.success(fbResult))
            }
        }
    }
    
    public func registerUser() {
        auth.createUser(withEmail: self.email, password: self.password) { authDataResult, error in
            if error != nil {
                
            }
            if authDataResult != nil {
                self.userLoggedIn = true
                do {
                    try FirebaseFirestoreManager().createUserCollection(auth: self.auth)
                } catch  {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    public func currentUser() -> User? {
        auth.currentUser
    }
    
    public func logout() {
        do {
            try auth.signOut()
            self.userLoggedIn = false
        } catch {
            print(error.localizedDescription)
            return
        }
    }
    
    public func autoLogUser() {
        if auth.currentUser != nil {
            self.userLoggedIn = true
        }
    }
}
