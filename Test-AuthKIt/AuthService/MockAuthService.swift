//
//  MockAuthService.swift
//  Test-AuthKIt
//
//  Created by Александр Богачев on 12.10.24.
//

import Foundation

class MockAuthService: AuthServiceProtocol {
    
    func login(with code: String, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if code == "111111" {
                completion(.success(()))
            } else {
                completion(.failure(AuthError.invalidCredentials))
            }
        }
    }
}

enum AuthError: Error, LocalizedError {
    case invalidCredentials
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Неправильный код."
        }
    }
}

