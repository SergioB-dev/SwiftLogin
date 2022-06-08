//
//  SwiftUIView.swift
//  
//
//  Created by Sergio Bost on 6/7/22.
//

import SwiftUI



public struct LoginView<PostLoginView: View>: View {
    @Environment(\.presentationMode) var pMode
    @StateObject var fbManager = FirebaseAuthManager()
    @State private var loginStep: LoginStep = .signIn
    let postLoginView: PostLoginView
    public init(@ViewBuilder postLoginView: () -> PostLoginView) {
        self.postLoginView = postLoginView()
    }
    public var body: some View {
        routerView()
    }
    @ViewBuilder public func routerView() -> some View {
        if fbManager.userLoggedIn {
            NavigationStack {
                postLoginView
                    .toolbar {
                        Text("Logout")
                            .onTapGesture {
                                fbManager.logout()
                            }
                    }
            }
        } else {
            VStack {
                if loginStep == .signIn {
                    LoginBlock(fbManager: fbManager, loginStep: .signIn)
                } else {
                    LoginBlock(fbManager: fbManager, loginStep: .register)
                }
                Picker("Login Items", selection: $loginStep) {
                    ForEach(LoginStep.allCases, id: \.hashValue) { item in
                        Text(item.rawValue).tag(item)
                    }
                }.pickerStyle(.segmented)
                    .padding()
            }
        }
    }
}

struct LoginBlock: View {
    @ObservedObject var fbManager: FirebaseAuthManager
    let loginStep: LoginStep
    
    var body: some View {
        VStack {
            Group {
                TextField("Email", text: $fbManager.email)
                TextField("Password", text: $fbManager.password)
            }
            .onAppear {
                fbManager.autoLogUser()
            }
            .padding()
            .textFieldStyle(.roundedBorder)
            Button(action: login){
                Text("Login")
                    .foregroundColor(.white)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .frame(width: 150)
                    .background(.blue)
                    .cornerRadius(10)
            }
        }
    }
    public func login() {
        if loginStep == .signIn {
            fbManager.login(){_ in}
        } else {
            fbManager.registerUser()
        }
    }
}

enum LoginStep: String, CaseIterable {
    case signIn = "Sign in"
    case register = "Register"
}
