//
//  CityItemCell.swift
//  Weather-Wanted
//
//  Created by 신병기 on 2022/09/13.
//

import UIKit

class CityItemCell: UICollectionViewCell {
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialize()
    }

    func initialize() {
        
    }
    
    func set(item: String, value: Any) {
        itemLabel.text = item
        valueLabel.text = "\(value)"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        itemLabel.text = ""
        valueLabel.text = ""
    }
}
