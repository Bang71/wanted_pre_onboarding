//
//  HomeViewController.swift
//  Weather-Wanted
//
//  Created by 신병기 on 2022/09/13.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let apiService = ApiService()
    var weather: CurrentWeatherListResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiService.delegate = self
        
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        apiService.getRequestData()
    }
    
    func initUI() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "emptyCell")

        let cityCellNib = UINib(nibName: "CityCell", bundle: Bundle(for: self.classForCoder))
        collectionView.register(cityCellNib, forCellWithReuseIdentifier: "cell")
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weather?.cnt ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let cell = cell as? CityCell,
           let weather = weather {
            let weatherWithCity = weather.list[indexPath.row]
            
            let id = weatherWithCity.id
            let name = weatherWithCity.name
            let temp = weatherWithCity.main.temp
            let humidity = weatherWithCity.main.humidity
            let icon = weatherWithCity.weather.first?.icon ?? ""
            
            cell.set(id: id, name: name, temp: temp, humidity: humidity, url: "https://openweathermap.org/img/wn/\(icon)@2x.png")
            return cell
        }
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: "emptyCell", for: indexPath)
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CityCell {
            if let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CityViewController") as? CityViewController {
                nextVC.id = cell.id
                nextVC.name = cell.name
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width / 2 - 10
        let height = width
        
        return CGSize(width: width, height: height)
    }
}

extension HomeViewController: ApiServiceDelegate {
    
    func updateData(weather: CurrentWeatherListResponse) {
        self.weather = weather
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
