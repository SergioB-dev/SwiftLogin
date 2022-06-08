//
//  SwiftUIView.swift
//  
//
//  Created by Sergio Bost on 6/7/22.
//

import SwiftUI

struct LoginView: View {
    @StateObject var fbManager = FirebaseAuthManager()
    var body: some View {
        VStack {
            Group {
                TextField("Email", text: $fbManager.email)
                TextField("Password", text: $fbManager.password)
            }
            .textFieldStyle(.roundedBorder)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
