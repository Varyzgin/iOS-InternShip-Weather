//
//  ViewController.swift
//  WeatherTestTask
//
//  Created by Dim on 23.05.2025.
//

import UIKit

protocol MainPageViewControllerProtocol: AnyObject {
    var tableView: UITableView { get set }
    var titleLabel: UILabel { get set }
}

class MainPageViewController: UIViewController, MainPageViewControllerProtocol {
    
    public var presenter: MainPagePresenterProtocol!
    
    lazy var titleLabel: UILabel = {
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.textAlignment = .center
        return $0
    }(UILabel(frame: CGRect(
        origin: CGPoint(x: Margins.M, y: 50),
        size: CGSize(width: view.frame.width - 2 * Margins.M, height: 50)
    )))
    
    lazy var tableView: UITableView = {
        $0.separatorStyle = .none
        $0.delegate = self
        $0.dataSource = self
        $0.register(DayForecastCellView.self, forCellReuseIdentifier: DayForecastCellView.identifier)
        return $0
    }(UITableView(frame: CGRect(
        origin: CGPoint(x: 0, y: titleLabel.frame.maxY),
        size: CGSize(width: view.frame.width, height: view.frame.height - titleLabel.frame.maxY - Margins.M)
    )))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .background
        
        self.view.addSubview(titleLabel)
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
