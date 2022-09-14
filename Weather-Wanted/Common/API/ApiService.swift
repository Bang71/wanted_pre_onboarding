//
//  ApiService.swift
//  Weather-Wanted
//
//  Created by 신병기 on 2022/09/13.
//

import Foundation

protocol ApiServiceDelegate {
    func updateData(weather: CurrentWeatherListResponse)
}

class ApiService {
    
    var delegate: ApiServiceDelegate?
    
    func getRequestData(city: String = "all") {
        let openWeatherURL = "https://api.openweathermap.org/data/2.5/group?"
        let appid = "8439c5c6b1bb2dbada6cd009f5eb92fe"
        
        let id = (city != "all") ? city : "1842616,1841811,1842225,1842025,1835327,1835224,1841066,1838519,1835895,1835847,1836553,1835553,1835648,1833742,1843491,1845457,1846266,1845759,1845604,1845136"
        
        let urlString = "\(openWeatherURL)id=\(id)&units=metric&appid=\(appid)"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let dataTask = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                if let data = data,
                   let httpResponse = response as? HTTPURLResponse,
                   httpResponse.statusCode == 200 {
                    do {
                        let weather = try JSONDecoder().decode(CurrentWeatherListResponse.self, from: data)
                        self.delegate?.updateData(weather: weather)
                    } catch(let error) {
                        print(String(describing: error))
                        return
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    // 공주 Gongju, KR, 1842616
    // 광주 Gwangju, KR, 1841811
    // 구미 Gumi, KR, 1842225
    // 군산 Gunsan, KR, 1842025
    // 대구 Daegu, KR, 1835327
    // 대전 Daejeon, KR, 1835224
    // 목포 Mokpo, KR, 1841066
    // 부산 Busan, KR, 1838519
    // 서산 Seosan, KR, 1835895
    // 서울 Seoul, KR, 1835847
    // 속초 Sokcho, KR, 1836553
    // 수원 Suwon, KR, 1835553
    // 순천 Suncheon, KR, 1835648
    // 울산 Ulsan, KR, 1833742
    // 익산 Iksan, KR, 1843491
    // 전주 Jeonju, KR, 1845457
    // 제주시 Jeju City, KR, 1846266
    // 천안 Cheonan, KR, 1845759
    // 청주 Cheongju-si, KR, 1845604
    // 춘천 Chuncheon, KR, 1845136
    
    // 도시이름
    // 날씨 아이콘
    // 현재 기온
    // 체감 기온
    // 현재 습도
    // 최저 기온
    // 최고 기온
    // 기압
    // 풍속
    // 날씨 설명
    
    
}
