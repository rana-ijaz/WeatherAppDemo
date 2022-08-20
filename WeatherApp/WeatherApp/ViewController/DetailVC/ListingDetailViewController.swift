//
//  ListingDetailViewController.swift
//  ListingsApp
//
//  Created by Rana Ijaz Ahmad on 20/08/2022.
//

import UIKit

class ListingDetailViewController: UIViewController {
    
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var latLongLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!

    @IBOutlet weak var imageDownloadActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configureView()
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        cityLbl.text = String("City:  \(listing?.city.name)")
        latLongLbl.text = String("lat long:  \(listing?.city.coord.lat), \(listing?.city.coord.lon)")
        temperatureLbl.text = String("Temperature:  \(listing?.main.temp)")
        countryLbl.text = String("Country:  \(listing?.city.country)")
    }
    
    var listing: WeatherBO? {
        didSet {
            configureView()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
