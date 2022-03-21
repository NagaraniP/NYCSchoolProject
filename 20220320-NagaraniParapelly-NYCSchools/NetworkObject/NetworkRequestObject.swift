//
//  NetworkRequestObject.swift
//  20220320-NagaraniParapelly-NYCSchools
//
//  Created by raniraja on 3/20/22.
//

import UIKit

class NetworkRequestObject: NSObject {
    private let urlSession = URLSession.shared
    /*** Call network api to get respective responce and once we receive responce . Escaping closure will execute ***/
    func get<T>(endpoint: String, type: T.Type, completion: @escaping (Result<T, APIClientError>) -> Void) where T: Decodable {
        guard let urlObj = URL(string: endpoint) else {
            return
        }
        var request = URLRequest(url: urlObj)
        request.httpMethod = "GET"
        urlSession.dataTask(with: request) { data, _, error in
            if let data = data, error == nil {
                do {
                    let decoded = try JSONDecoder().decode(type, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(.decodingError))
                }
            } else {
               completion(.failure(.unknown(internalError: error)))
            }
        }.resume()
    }
}
