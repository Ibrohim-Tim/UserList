//
//  UserListNetworkService.swift
//  UserList
//
//  Created by Ibrahim Timurkaev on 29.02.2024.
//

import Foundation

final class UserListNetworkService {
    
    enum NetworkError: Error {
        case invalidURL
        case invalidResponse
        case noData
    }
    
    static let shared = UserListNetworkService()
    
    private let baseURL = "https://jsonplaceholder.typicode.com"
    
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/users") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let users = try decoder.decode([User].self, from: data)
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

