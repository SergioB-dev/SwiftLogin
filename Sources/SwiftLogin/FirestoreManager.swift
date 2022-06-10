//
//  File.swift
//  
//
//  Created by Sergio Bost on 6/7/22.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import SwiftUI

open class FirebaseFirestoreProvider {
    public let firestore = Firestore.firestore()
    public let auth = Auth.auth()
    public init() {}
}

public final class FirebaseFirestoreManager: FirebaseFirestoreProvider, ObservableObject {
    public override init() {
        super.init()
    }
    
    func createUserCollection(auth: Auth) throws {
        weak var user = auth.currentUser
        guard user != nil else { throw ClientErrors.noUser }
        if !userAlreadyExists(user!) {
            firestore.collection("users").addDocument(data: [
                "uid":user!.uid,
                "email": user!.email ?? "",
            ])
            
        }
    }
    
    private func userAlreadyExists(_ user: User) -> Bool {
        var doesUserExist = false
        firestore.collection("users").whereField("uid", isEqualTo: user.uid)
            .getDocuments { snapshots, error in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                if let snapshots = snapshots {
                    let results = snapshots.documents.first
                    if results != nil {
                        doesUserExist = true
                    }
                }
            }
        return doesUserExist
    }
    
}

enum ClientErrors: Error {
    case noUser
}
