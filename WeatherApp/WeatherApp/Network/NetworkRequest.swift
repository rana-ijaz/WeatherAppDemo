//
//  NetworkRequest.swift
//  ListingsApp
//
//  Created by Rana Ijaz on 20/08/2022.
//

import Foundation

typealias ResultSuccess<T> = (T) -> Void
typealias ResultFailure = (NetworkError)  -> Void

protocol NetworkRequest {
    
    func request<T: Decodable>(_ request : URLRequest, success : @escaping ResultSuccess<T>,failure : @escaping ResultFailure)
    
}
