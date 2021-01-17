//
//  NetworkClient.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 14/01/2021.
//

import Foundation

private struct Configuration {
    static let codesSuccess = 200..<300
    static let codeUnknownError = 400
}

extension NetworkClient {
    final class Client: NetworkClientInterface {
        func get(baseurl: String, endpoint: String, headers: [String: String], completion: @escaping NetworkClient.Completion) {
            task(baseurl: baseurl, endpoint: endpoint, headers: headers, completion: completion)
        }

        private func task(baseurl: String, endpoint: String, headers: [String: String], completion: @escaping Completion) {
            guard let request = makeRequest(baseurl: baseurl, endpoint: endpoint, headers: headers) else {
                completion(.failure(.invalidUrl))
                return
            }

            URLSession.shared.dataTask(with: request) { data, response, error in
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? Configuration.codeUnknownError
                print("response \(request.url?.absoluteString ?? "") \(Configuration.codesSuccess ~= statusCode ? "✅" : "🚫") \(statusCode)")

                if let error = error {
                    DispatchQueue.main.async { completion(.failure(.urlSessionError(error))) }
                    return
                }

                guard Configuration.codesSuccess ~= statusCode else {
                    DispatchQueue.main.async { completion(.failure(.invalidStausCode(statusCode))) }
                    return
                }

                guard let data = data else {
                    DispatchQueue.main.async { completion(.failure(.noDataError)) }
                    return
                }

                DispatchQueue.main.async { completion(.success(data)) }
            }.resume()
        }

        private func makeRequest(baseurl: String, endpoint: String, headers: [String: String]) -> URLRequest? {
            guard let url = URL(string: baseurl + endpoint) else {
                return nil
            }

            var request = URLRequest(url: url)

            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }

            return request
        }
    }
}
