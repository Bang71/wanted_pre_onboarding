//
//  CityCell.swift
//  Weather-Wanted
//
//  Created by 신병기 on 2022/09/13.
//

import UIKit

class CityCell: UICollectionViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialize()
    }

    func initialize() {
        
    }
    
    func set(name: String, temp: String, humidity: String, url: String) {
        cityLabel.text = name
        tempLabel.text = temp + "°"
        humidityLabel.text = humidity + "%"
        
        if let imageURL = URL(string: url) {
            if let data = try? Data(contentsOf: imageURL) {
                weatherIcon.image = UIImage(data: data)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cityLabel.text = ""
        tempLabel.text = ""
        humidityLabel.text = ""
    }
}
