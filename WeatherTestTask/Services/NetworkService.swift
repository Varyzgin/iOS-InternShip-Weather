//
//  NetworkService.swift
//  WeatherTestTask
//
//  Created by Dim on 23.05.2025.
//

import Foundation

struct RequestComponents {
    let baseURL: String
    var path: String = ""
    var params: [String: String] = [:]
    var headers: [String: String] = [:]
    
    let httpMethod: String = "GET"
}

struct NetworkService {
    func sendRequest<T: Decodable>(components: RequestComponents, responseType: T.Type, completion: @escaping (T) -> Void) {
        var urlComponents = URLComponents(string: components.baseURL)
        urlComponents?.path = components.path
        var queryItems: [URLQueryItem] = []
        for item in components.params {
            queryItems.append(URLQueryItem(name: item.key, value: item.value))
        }
        urlComponents?.queryItems = queryItems
        
        if let fullUrl = urlComponents?.url {
//            print(fullUrl)
            var request = URLRequest(url: fullUrl)
            request.httpMethod = components.httpMethod
            for item in components.headers {
                request.setValue(item.value, forHTTPHeaderField: item.key)
            }
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                guard error == nil, let data = data else { return }
//                print(String(data: data, encoding: .utf8))
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    completion(response)
                } catch {
                    print(error.localizedDescription)
                }
            }.resume()
        }
    }
}
