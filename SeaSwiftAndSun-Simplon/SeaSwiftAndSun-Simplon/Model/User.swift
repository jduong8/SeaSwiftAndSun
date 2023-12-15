//
//  User.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Jonathan Duong on 14/12/2023.
//

import Foundation

struct User : Identifiable {

    let id: String
    let idSignInWithApple: String
    let email: String
    let firstName: String
    let lastName: String

    static func createUser(user: User) -> [String : Any] {
        [
            "doucmentId": user.id,
            "idSignInWithApple" : user.idSignInWithApple,
            "email" : user.email,
            "firstName": user.firstName,
            "lastName": user.lastName
        ]
    }
}
