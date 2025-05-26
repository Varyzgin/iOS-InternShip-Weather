//
//  DayForecastCellView.swift
//  WeatherTestTask
//
//  Created by Dim on 25.05.2025.
//

import UIKit

final class DayForecastCellView: UITableViewCell {
    static let identifier: String = UUID().uuidString
    
    let elementDimention: CGFloat = 30

    lazy var dateLabel: UILabel = {
        $0.numberOfLines = 2
        $0.font = .systemFont(ofSize: 30, weight: .medium)
        $0.textAlignment = .center
        return $0
    }(UILabel(frame: CGRect(
        origin: CGPoint(x: clippingView.bounds.minX, y: clippingView.bounds.midY - clippingView.frame.height / 2),
        size: CGSize(width: 80, height: clippingView.frame.height)
    )))
    
    
    lazy var huminityIcon: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(systemName: "drop") // капля
        return $0
    }(UIImageView(frame: CGRect(x: 0, y: 0, width: elementDimention, height: elementDimention)))
    
    lazy var huminityLabel: UILabel = {
        $0.numberOfLines = 1
        $0.font = .systemFont(ofSize: 17, weight: .medium)
        $0.textAlignment = .left
        return $0
    }(UILabel(frame: CGRect(x: huminityIcon.frame.maxX + Margins.XS, y: huminityIcon.frame.midY - elementDimention / 2, width: 80, height: elementDimention)))
    
    lazy var wingIcon: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(systemName: "wind")
        return $0
    }(UIImageView(frame: CGRect(x: 0, y: huminityIcon.frame.maxY + Margins.XS, width: elementDimention, height: elementDimention)))
   
    lazy var wingLabel: UILabel = {
//        $0.text = "13.4km/h"
        $0.numberOfLines = 1
        $0.font = .systemFont(ofSize: 17, weight: .medium)
        $0.textAlignment = .left
        return $0
    }(UILabel(frame: CGRect(x: wingIcon.frame.maxX + Margins.XS, y: wingIcon.frame.midY - elementDimention / 2, width: 80, height: elementDimention)))
    
    
    lazy var extraInfoView: UIView = {
        return $0
    }(UIView(frame: CGRect(
        origin: CGPoint(x: clippingView.bounds.midX - 70, y: clippingView.bounds.midY - clippingView.bounds.height / 2),
        size: CGSize(width: 100, height: clippingView.bounds.height)
    )))
    
    lazy var tempLabel: UILabel = {
        $0.numberOfLines = 1
        $0.font = .systemFont(ofSize: 50, weight: .medium)
        $0.textAlignment = .center
        return $0
    }(UILabel(frame: CGRect(
        origin: CGPoint(x: clippingView.bounds.maxX - 120, y: clippingView.bounds.midY - clippingView.frame.height / 2),
        size: CGSize(width: 120, height: clippingView.frame.height)
    )))
    
    lazy var clippingView: UIView = {
        return $0
    }(UIView(frame: CGRect(
        origin: CGPoint(x: Margins.S, y: Margins.S),
        size: CGSize(width: frame.width - Margins.S * 2, height: frame.height - Margins.S * 2)
    )))
    
    lazy var weatherPicture: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.tintColor = .yellow
        $0.layer.masksToBounds = true
        return $0
    }(UIImageView(frame: baseView.bounds))
    
    lazy var blurEffectView: UIVisualEffectView = {
        $0.effect = UIBlurEffect(style: .systemUltraThinMaterial)
        $0.layer.cornerRadius = 20
        $0.alpha = 0.9
        $0.layer.masksToBounds = true
        return $0
    }(UIVisualEffectView(frame: baseView.bounds))
    
    lazy var baseView: UIView = {
        $0.layer.cornerRadius = 20
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowOpacity = 0.5
        $0.layer.shadowRadius = 7
        return $0
    }(UIView(frame: frame))
    
    func configure(weather: WeatherData, size: CGSize) {
        self.frame = CGRect(
            origin: CGPoint(x: Margins.M, y: Margins.S),
            size: CGSize(width: size.width - Margins.M * 2, height: size.height - Margins.S * 2)
        )
        
        if let iconURL = URL(string: weather.iconUrl) {
            weatherPicture.load(urlString: "https:\(iconURL)")
        }
        dateLabel.text = DateFormatter.formatDate(from: weather.date)
        wingLabel.text = "\(weather.maxwind_kph) м/с"
        huminityLabel.text = "\(weather.avgtemp_c) мм"
        tempLabel.text = "\(Int(weather.avgtemp_c))°C"
        
        clippingView.addSubview(dateLabel)
        extraInfoView.addSubview(wingIcon)
        extraInfoView.addSubview(wingLabel)
        extraInfoView.addSubview(huminityIcon)
        extraInfoView.addSubview(huminityLabel)
        clippingView.addSubview(extraInfoView)
        clippingView.addSubview(tempLabel)
        
        baseView.addSubview(weatherPicture)
        baseView.addSubview(blurEffectView)
        
        baseView.addSubview(clippingView)

        contentView.addSubview(baseView)
    }
}
