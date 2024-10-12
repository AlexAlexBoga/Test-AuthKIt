//
//  AuthService.swift
//  Test-AuthKIt
//
//  Created by Александр Богачев on 12.10.24.
//

import Foundation

protocol AuthServiceProtocol {
    func login(with code: String, completion: @escaping (Result<Void, Error>) -> Void)
}

class AuthService: AuthServiceProtocol {
    
    private let baseURL = URL(string: "https://test-auth-kit.herokuapp.com")!
    private let userDefaults = UserDefaults.standard
    private let tokenKey = "authToken"
    
    func login(with code: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let loginURL = baseURL.appendingPathComponent("/auth/login")
        
        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = ["code": code]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let token = json["token"] as? String {
                self.saveToken(token)
                completion(.success(()))
            } else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid credentials"])
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    private func saveToken(_ token: String) {
        userDefaults.set(token, forKey: tokenKey)
    }
    
    func getToken() -> String? {
        return userDefaults.string(forKey: tokenKey)
    }
    
    func isLoggedIn() -> Bool {
        return getToken() != nil
    }
    
    func logout() {
        userDefaults.removeObject(forKey: tokenKey)
    }
}
