//
//  SwiftUIView.swift
//  
//
//  Created by Sergio Bost on 6/7/22.
//

import SwiftUI

public struct LoginView<PostLoginView: View>: View {
    let postLoginView: PostLoginView
    public init(@ViewBuilder postLoginView: () -> PostLoginView) {
        self.postLoginView = postLoginView()
    }
    @StateObject public var fbManager = FirebaseAuthManager()
    public var body: some View {
        NavigationStack {
            VStack {
                Group {
                    TextField("Email", text: $fbManager.email)
                    TextField("Password", text: $fbManager.password)
                    NavigationLink(destination: postLoginView, isActive: $fbManager.userLoggedIn) {
                        Text("We are logged in!")
                    }
                }
                .padding()
                .textFieldStyle(.roundedBorder)
                Button(action: login){
                    Text("Login")
                        .padding()
                        .frame(width: 150)
                        .background(.blue)
                        .cornerRadius(10)
                }
            }
            }
        
        }
   public func login() {
        fbManager.login(){  _ in }
    }
}
