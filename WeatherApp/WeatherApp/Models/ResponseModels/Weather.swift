//
//  Weather.swift
//  ListingsApp
//
//  Created by Rana Ijaz Ahmad on 20/08/2022.
//

import Foundation


// MARK: - Weather
struct WeatherResponse: Decodable {
    var weatherList: [WeatherBO]
    //let pagination: Pagination
    
    enum CodingKeys: String, CodingKey {
        case weatherList
        //case pagination
    }
}

struct WeatherBO: Codable {
    let city: City
    let time: Int
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let weather: [Weather]
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name, findname, country: String
    let coord: Coord
    let zoom: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
    let pressure, humidity: Int
    let tempMin, tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg, varBeg, varEnd: Int

    enum CodingKeys: String, CodingKey {
        case speed, deg
        case varBeg = "var_beg"
        case varEnd = "var_end"
    }
}
