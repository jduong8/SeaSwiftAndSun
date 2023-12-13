//
//  SwiftUIView.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Mahdia Amriou on 13/12/2023.
//

import SwiftUI
import AuthenticationServices
import CryptoKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct User : Identifiable {
    var id, idSignInWithApple, email, firstName, lastName: String
    
    static func createUser(user: User) -> [String : Any]{
        
        [
            "doucmentId": user.id,
            "idSignInWithApple" : user.idSignInWithApple,
            "email" : user.email,
            "firstName": user.firstName,
            "lastName": user.lastName
        ]
    }
}
struct Main: View {
    var body: some View {
        Text("This is the Main Screen")
    }
}


struct SingInWitAppleView: View {
    @State private var currentNonce: String?
    @State private var toMain = false
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack {
            Color.init(uiColor: .systemGray5)
            appleButtonView
        }.fullScreenCover(isPresented: $toMain) {
            Main()
        }.ignoresSafeArea()
    }
    var appleButtonView: some View {
        SignInWithAppleButton(Auth.auth().currentUser != nil ? .signIn : .signUp) { asAuthorizationAppleIDRequest in
            asAuthorizationAppleIDRequest.requestedScopes = [.email,.fullName]
            asAuthorizationAppleIDRequest.nonce = startSignInWithAppleFlow()
        } onCompletion: { authResults in
            switch authResults {
            case .success(let auth):
                switch auth.credential {
                case let appleIdCrendetals as ASAuthorizationAppleIDCredential:
                    guard let nonce = currentNonce else {
                        return print("Error")
                    }
                    guard let appleIdToken = appleIdCrendetals.identityToken else {
                        return print("Error")
                    }
                    guard let idTokenString = String(data: appleIdToken, encoding: .utf8) else {
                        return print("Error")
                    }
                    let credential = OAuthProvider.appleCredential(withIDToken: idTokenString,
                                                                            rawNonce: nonce,
                                                                            fullName: appleIdCrendetals.fullName)
                    Auth.auth().signIn(with: credential) { authDataResult, error in
                        if error != nil {
                            print(error?.localizedDescription ?? "error")
                        } else {
                            // This is SignUP
                            if appleIdCrendetals.fullName?.givenName != nil {
                                guard let uid = authDataResult?.user.uid else { return }
                                let user = User(id: uid , idSignInWithApple: appleIdCrendetals.user, email: appleIdCrendetals.email ?? "nil", firstName: appleIdCrendetals.fullName?.givenName ?? "nil", lastName: appleIdCrendetals.fullName?.familyName ?? "nil")
                                
                                Firestore.firestore().collection("users").document(uid).setData(User.createUser(user: user))
                                
                                toMain.toggle()
                            } else {
                                // Sign in
                                toMain.toggle()
                            }
                        }
                    }
                            
                default:
                    print("")
                }
            case .failure(let error):
                print("error:\(error.localizedDescription)")
            }
        }.signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
            .frame(width: UIScreen.main.bounds.width - 30, height: 45)
            
    }
    func startSignInWithAppleFlow() -> String {
      let nonce = randomNonceString()
      currentNonce = nonce
      return sha256(nonce)
    }
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError(
              "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }

}



#Preview {
    SingInWitAppleView()
}
