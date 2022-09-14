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
    
    var id: Int?
    var name: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialize()
    }

    func initialize() {
        
    }
    
    func set(id: Int, name: String, temp: Float, humidity: Float, url: String) {
        self.id = id
        self.name = name
        
        cityLabel.text = name
        tempLabel.text = "\(temp)°"
        humidityLabel.text = "\(humidity)%"
    
        if let cachedImage = ImageCacheManager.shared.object(forKey: url as NSString) {
            weatherIcon.image = cachedImage
        } else if let imageURL = URL(string: url) {
            do {
                if let data = try? Data(contentsOf: imageURL) {
                    if let image = UIImage(data: data) {
                        weatherIcon.image = UIImage(data: data)
                        ImageCacheManager.shared.setObject(image, forKey: url as NSString)
                    }
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.id = nil
        cityLabel.text = ""
        tempLabel.text = ""
        humidityLabel.text = ""
        weatherIcon.image = nil
    }
}
