//
//  MainPageModel.swift
//  WeatherTestTask
//
//  Created by Dim on 23.05.2025.
//

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

struct WeatherData {
    let date: String
    let text: String
    let iconUrl: String
    let avgtemp_c: Double
    let maxwind_kph: Double
    let avghumidity: Double
}
