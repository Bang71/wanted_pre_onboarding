//
//  CityViewController.swift
//  Weather-Wanted
//
//  Created by 신병기 on 2022/09/13.
//

import UIKit

class CityViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        initUI()
    }
    
    func initUI() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "emptyCell")

        let cityItemCellNib = UINib(nibName: "CityItemCell", bundle: Bundle(for: self.classForCoder))
        collectionView.register(cityItemCellNib, forCellWithReuseIdentifier: "cell")
    }
}

extension CityViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let cell = cell as? CityItemCell {
            return cell
        }
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: "emptyCell", for: indexPath)
    }
    
}

extension CityViewController: UICollectionViewDelegate {
    
}

extension CityViewController: UICollectionViewDelegateFlowLayout {
    
}
