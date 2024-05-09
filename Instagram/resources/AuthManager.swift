//
//  AuthManager.swift
//  Instagram
//
//  Created by robusta on 05/05/2024.
//

import Foundation
import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    public func registerNewUser(username: String , email: String , password: String , completion: @escaping ((Bool) -> Void)){
        
        DatabaseManager.shared.canCreateNewUser(username: username, email: email) { canCreate in
            if canCreate {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    guard authResult != nil , error == nil else {
                        completion(false)
                        print(error as Any)
                        return
                    }
                    DatabaseManager.shared.insertNewUser(email: email, username: username) { inserted in
                        if inserted {
                            completion(true)
                        }else {
                            completion(false)
                        }
                    }
                }
            }else {
                completion(false)
            }
        }
    }
    
    public func loginUser(username: String? , email: String? , password: String , completion: @escaping ((Bool) -> Void)){
        
        if let userEmail = email {
            Auth.auth().signIn(withEmail: userEmail, password: password) { authResult, error in
                guard authResult != nil , error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
            
        }else if let userName = username {
            print(userName)
        }
    }
    
    public func logout(completion: ((Bool) -> Void)){
        
        do{
            try Auth.auth().signOut()
            completion(true)
        }catch {
            print(error)
            completion(false)
            return
        }
    }
}
