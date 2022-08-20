//
//  ListingViewModel.swift
//  ListingsApp
//
//  Created by Rana Ijaz Ahmad on 20/08/2022.
//

import Foundation

class ListingViewModel {
    var listings: Box<[WeatherBO]>
    var listingRepository: ListingRepository
    var weatherList: [WeatherBO] = []
    
    var apiError:Box<NetworkError>? = Box(NetworkError())
    
    init(repo : ListingRepository = ListingRepository()) {
        listings = Box([WeatherBO]())
        listings.shouldCallListenerForIntialValue = false
        listingRepository = ListingRepository()
    }
    
    func fetchListings() {
        self.listingRepository.fetchListings(complete: {[weak self] (response) in
            if response.weatherList.count > 0 {
                self?.weatherList = response.weatherList
                self?.listings.value = response.weatherList
            }else {
                let error = NetworkError()
                error.statusCode = 400
                self?.apiError?.value = error
            }
        }) { (networkError) in
            if let error = networkError {
                self.apiError?.value = error
            }
            
        }
    }
    
    func filterList(cityName: String){
        if cityName == "" {
            self.listings.value = self.weatherList
        }
        else{
            self.listings.value = self.weatherList.filter({ $0.city.name.localizedCaseInsensitiveContains(cityName) })
        }
    }
}
