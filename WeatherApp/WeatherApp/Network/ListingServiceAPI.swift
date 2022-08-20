//
//  ListingServiceAPI.swift
//  ListingsApp
//
//  Created by Rana Ijaz on 20/08/2022.
//

import Foundation

class ListingServiceAPI: WebServiceApi {
    
    override var baseUrl: String! {
        
        NetworkConfiguration.baseURL()
    }
    
}
