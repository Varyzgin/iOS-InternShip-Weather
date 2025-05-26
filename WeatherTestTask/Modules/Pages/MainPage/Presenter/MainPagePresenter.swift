//
//  MainPagePresenter.swift
//  WeatherTestTask
//
//  Created by Dim on 23.05.2025.
//

import Foundation

protocol MainPagePresenterProtocol: AnyObject {
    var data: [WeatherData] { get }
}

class MainPagePresenter: MainPagePresenterProtocol {
    private weak var view: MainPageViewControllerProtocol?
    
    lazy var data: [WeatherData] = []
    
    init(view: MainPageViewControllerProtocol) {
        self.view = view
    }
    
    func loadForecast() {
        let components = RequestComponents(baseURL: "https://api.weatherapi.com/", path: "/v1/forecast.json",params: ["key": "8b77633490004888943132753252205", "q": "Нижний Новгород", "days": "5", "lang": "ru"])
        
        let service = NetworkService()
        service.sendRequest(components: components, responseType: WeatherResponse.self) {
            self.data = $0.getForecast()
            DispatchQueue.main.async {
                self.view?.tableView.reloadData()
            }
        }
    }
}
