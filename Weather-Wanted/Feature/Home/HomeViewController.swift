//
//  HomeViewController.swift
//  Weather-Wanted
//
//  Created by 신병기 on 2022/09/13.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    func initUI() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "emptyCell")

        let cityCellNib = UINib(nibName: "CityCell", bundle: Bundle(for: self.classForCoder))
        collectionView.register(cityCellNib, forCellWithReuseIdentifier: "cell")
    }

}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let cell = cell as? CityCell {
            cell.set(name: "서울", temp: "28", humidity: "66", url: "https://openweathermap.org/img/wn/10d@2x.png")
            return cell
        }
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: "emptyCell", for: indexPath)
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width / 2 - 10
        let height = width
        
        return CGSize(width: width, height: height)
    }
}

