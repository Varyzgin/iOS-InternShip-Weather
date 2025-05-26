//
//  ViewController.swift
//  WeatherTestTask
//
//  Created by Dim on 23.05.2025.
//

import UIKit

protocol MainPageViewControllerProtocol: AnyObject {
    var tableView: UITableView { get set }
}

class MainPageViewController: UIViewController, MainPageViewControllerProtocol {
    
    public var presenter: MainPagePresenterProtocol!
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = view.frame
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DayForecastCellView.self, forCellReuseIdentifier: DayForecastCellView.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .background
        
        self.view.addSubview(tableView)
    }
}

extension MainPageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.data.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DayForecastCellView.identifier, for: indexPath) as? DayForecastCellView
        else { return UITableViewCell() }
        cell.configure(weather: self.presenter.data[indexPath.row], size: CGSize(width: UIScreen.main.bounds.width, height: 120))
        cell.selectionStyle = .none
        return cell
    }
}
