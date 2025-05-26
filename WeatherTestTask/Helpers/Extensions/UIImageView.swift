//
//  UIImageView.swift
//  WeatherTestTask
//
//  Created by Dim on 23.05.2025.
//

import UIKit

extension UIImageView {
    func load(urlString: String) {
        if let url = URL(string: urlString) {
            DispatchQueue.global(qos: .utility).async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
