//
//  ViewController.swift
//  WeatherTestTask
//
//  Created by Dim on 23.05.2025.
//

import UIKit

class MainPageViewController: UIViewController {
    
    lazy var weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 100, y: 100, width: 64, height: 64)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .red
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(weatherIcon)
        
        let components = RequestComponents(baseURL: "https://api.weatherapi.com/", path: "/v1/forecast.json",params: ["key": "8b77633490004888943132753252205", "q": "Нижний Новгород", "days": "5", "lang": "ru"])
        
        let service = NetworkService()
        service.sendRequest(components: components, responseType: WeatherResponse.self) {
            
            if let iconURL = URL(string: $0.getForecast()[0].iconUrl) {
                print(iconURL)
                
                self.weatherIcon.load(urlString: "https:\(iconURL)")
            }
        }
    }
}

