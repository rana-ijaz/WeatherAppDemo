//
//  NetworkConfiguration.swift
//  ListingsApp
//
//  Created by Rana Ijaz on 20/08/2022.
//

import Foundation

let kCharsetUTF8Value = "application/x-www-form-urlencoded"
let kJSONValue = "application/json"
let kMultiPartValue = "multipart/form-data"
let kContentTypeHeader  = "Content-Type"
let kContentLengthHeader = "Content-Length"
let kRequestParamInfo = "X-RequestParamInfo"
let kAcceptLanguage = "Accept-Language"
let kRequestTimeOut = "30"
let kAuthorizationKey = "Authorization"
let kRequestParam = "param"

protocol EndPointType {
    var baseUrl : String! {get}
    var path : String! {get}
    var httpMethod : HttpMethod! {get}
    var httpRequest : URLRequest! {get}
    var paramters : [String : Any]! {get}
}




final class NetworkConfiguration {
    static func baseURL () -> String? {
        // Check if URL is added in plist file.
        assert(Bundle.main.infoDictionary!["BASE_URL"] != nil)
        return Bundle.main.infoDictionary?["BASE_URL"] as? String
    }
}
