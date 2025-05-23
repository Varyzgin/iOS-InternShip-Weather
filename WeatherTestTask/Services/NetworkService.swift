//
//  NetworkService.swift
//  WeatherTestTask
//
//  Created by Dim on 23.05.2025.
//

import Foundation

struct WeatherResponse: Decodable {
    let forecast: Forecast
    
    struct Forecast: Decodable {
        let forecastday: [ForecastDay]
        
        struct ForecastDay: Decodable {
            let date: String
            let day: Day
            
            struct Day: Decodable {
                let condition: Condition
                struct Condition: Decodable {
                    let text: String
                    let icon: String
                }
                
                let avgtemp_c: Double
                let maxwind_kph: Double
                let avghumidity: Double
            }
        }
    }
    
    struct WeatherData {
        let date: String
        let text: String
        let iconUrl: String
        let avgtemp_c: Double
        let maxwind_kph: Double
        let avghumidity: Double
    }
    
    func getForecast() -> [WeatherData] {
        var forecast: [WeatherData] = []
        self.forecast.forecastday.forEach {
            forecast.append(WeatherData(
                date: $0.date,
                text: $0.day.condition.text,
                iconUrl: $0.day.condition.icon,
                avgtemp_c: $0.day.avgtemp_c,
                maxwind_kph: $0.day.maxwind_kph,
                avghumidity: $0.day.avghumidity
            ))
        }
        return forecast
    }
}

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
