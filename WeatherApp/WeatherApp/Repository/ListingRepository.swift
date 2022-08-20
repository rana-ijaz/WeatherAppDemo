//
//  ListingRepository.swift
//  ListingsApp
//
//  Created by Rana Ijaz Ahmad on 20/08/2022.
//

import Foundation

class ListingRepository: ListingServiceAPI {
    
    override var path: String! {
        return "lat=25&lon=55&appid=e5dccc89673035744ca78b8a21dc48d5"
    }
    
    override var httpMethod: HttpMethod! {
        return .get
    }
    
    func fetchListings(complete :@escaping (WeatherResponse) -> Void, failure:@escaping onFailure) {
        /*self.network.request(self.httpRequest, success: { (response: WeatherResponse) in
            complete(response)
        }) { (error: NetworkError) in
            failure(error)
        }*/
        
        // Uncomment above code to get data from API. Below code get data from json file
        let weatherResponse = self.readFileLineByLine()
        complete(weatherResponse)
    }
    
    func readFileLineByLine() -> WeatherResponse{
        
        var weatherResponse: WeatherResponse = WeatherResponse(weatherList: [])
        
        if let bundleURL = Bundle.main.url(forResource: "weather_14", withExtension: "json"),
           let contentsOfFile = try? String(contentsOfFile: bundleURL.path, encoding: .utf8) {
            var components = contentsOfFile.components(separatedBy: .newlines)
            components.removeLast()
            //print(components)
            for component in components {
                let data = component.data(using: .utf8) //try? Data(contentsOf: url),
                do {
                    let decodedData = try JSONDecoder().decode(WeatherBO.self, from: data!)
                    
                    weatherResponse.weatherList.append(decodedData)
                } catch {
                    print("decode error")
                }
            }
        }
        
        return weatherResponse
    }
}
