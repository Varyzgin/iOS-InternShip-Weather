//
//  Builder.swift
//  WeatherTestTask
//
//  Created by Dim on 23.05.2025.
//

import UIKit

struct Builder {
    static func configureMainPage() -> UIViewController {
        let view = MainPageViewController()
        let presenter = MainPagePresenter(view: view)
        presenter.loadForecast()
        view.presenter = presenter
        return view
    }
}
