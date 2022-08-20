//
//  ListingTableViewCell.swift
//  ListingsApp
//
//  Created by Rana Ijaz Ahmad on 20/08/2022.
//

import UIKit

class ListingTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var latLongLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    
    var listing:WeatherBO! {
        didSet {
            cityLbl.text = String("City:  \(listing.city.name)")
            latLongLbl.text = String("lat long:  \(listing.city.coord.lat), \(listing.city.coord.lon)")
            temperatureLbl.text = String("Temperature:  \(listing.main.temp)")
            countryLbl.text = String("Country:  \(listing.city.country)")
        }
    }

}
