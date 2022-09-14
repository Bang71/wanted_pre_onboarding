//
//  CityViewController.swift
//  Weather-Wanted
//
//  Created by 신병기 on 2022/09/13.
//

import UIKit

class CityViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var id: Int?
    var name: String?
    
    let apiService = ApiService()
    var weather: CurrentWeatherListResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiService.delegate = self
        
        self.navigationItem.title = name ?? ""
        
        initUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let id = id {
            apiService.getRequestData(city: "\(id)")
        }
    }
    
    func initUI() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "emptyCell")
        
        let cityItemCellNib = UINib(nibName: "CityItemCell", bundle: Bundle(for: self.classForCoder))
        collectionView.register(cityItemCellNib, forCellWithReuseIdentifier: "cell")
    }
}

extension CityViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let cell = cell as? CityItemCell {
            
            if let weather = weather,
               let weatherWithCity = weather.list.first {
                switch indexPath.row {
                case 0: cell.set(item: "temperature", value: weatherWithCity.main.temp)
                case 1: cell.set(item: "wind chill", value: weatherWithCity.main.feels_like)
                case 2: cell.set(item: "humidity", value: weatherWithCity.main.humidity)
                case 3: cell.set(item: "min temp", value: weatherWithCity.main.temp_min)
                case 4: cell.set(item: "max temp", value: weatherWithCity.main.temp_max)
                case 5: cell.set(item: "pressure", value: weatherWithCity.main.pressure)
                case 6: cell.set(item: "wind speed", value: weatherWithCity.wind.speed)
                case 7: cell.set(item: "weather", value: weatherWithCity.weather.description)
                default: cell.set(item: "test", value: "test")
                }
            }
            
            return cell
        }
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: "emptyCell", for: indexPath)
    }
    
}

extension CityViewController: UICollectionViewDelegate {
    
}

extension CityViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width / 3 - 10
        let height = width
        
        return CGSize(width: width, height: height)
    }
}

extension CityViewController: ApiServiceDelegate {
    
    func updateData(weather: CurrentWeatherListResponse) {
        self.weather = weather
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
