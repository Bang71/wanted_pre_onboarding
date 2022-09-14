//
//  ImageCacheManager.swift
//  Weather-Wanted
//
//  Created by 신병기 on 2022/09/14.
//

import Foundation
import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {
        
    }
}
