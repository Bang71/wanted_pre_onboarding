//
//  CurrentWeatherResponse.swift
//  Weather-Wanted
//
//  Created by 신병기 on 2022/09/14.
//

import Foundation

struct CurrentWeatherListResponse: Codable {
    let cnt: Int
    let list: [CurrentWeatherResponse]
    
    struct CurrentWeatherResponse: Codable {
        let weather: [WeatherResponse]
        let main: MainResponse
        let wind: WindResponse
        let name: String
        let id: Int
     
        struct WeatherResponse: Codable {
            let main: String
            let description: String
            let icon: String
        }

        struct MainResponse: Codable {
            let temp: Float
            let feels_like: Float
            let temp_min: Float
            let temp_max: Float
            let pressure: Float
            let humidity: Float
        }

        struct WindResponse: Codable {
            let speed: Float
        }
    }

}
