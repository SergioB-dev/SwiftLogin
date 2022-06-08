//
//  SwiftUIView.swift
//  
//
//  Created by Sergio Bost on 6/7/22.
//

import SwiftUI

public struct LoginView: View {
    @StateObject public var fbManager = FirebaseAuthManager()
    public var body: some View {
        VStack {
            Group {
                TextField("Email", text: $fbManager.email)
                TextField("Password", text: $fbManager.password)
            }
            .textFieldStyle(.roundedBorder)
        }
    }
}

public struct LoginView_Previews: PreviewProvider {
    static public var previews: some View {
        LoginView()
    }
}
