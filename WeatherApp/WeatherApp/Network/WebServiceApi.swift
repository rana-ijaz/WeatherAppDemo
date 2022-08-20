//
//  WebServiceApi.swift
//  ListingsApp
//
//  Created by Rana Ijaz on 20/08/2022.
//

import Foundation

typealias onFailure = (NetworkError?) -> Void

class WebServiceApi:  EndPointType {
    var network : NetworkApi!
    
    init(network : NetworkApi = NetworkApi()) {
        self.network = network
    }
    
    var baseUrl: String! { return nil }
    
    var path: String!{ return "" }
    var httpMethod: HttpMethod!{ .get }
    
    private var httpBody:Data? {
        if (self.paramters[kRequestParam] is [String : String]) {
            let parm =  self.paramters[kRequestParam] as! [String : String]
            return parm.queryString.data(using: .utf8)
            
        }else{
            return ((self.paramters[kRequestParam])! as! String).data(using: .utf8)
        }
        
    }
    
    var httpRequest: URLRequest! {
        var request : URLRequest = URLRequest.init(url: URL.init(string: self.url)!)
        
        if self.httpMethod == .post {
            if let body = httpBody {
                request.httpBody = body
            }
            request.setValue(kJSONValue, forHTTPHeaderField: kContentTypeHeader)
            
        } else if self.httpMethod == .delete {
            
        } else {
            request.setValue(kCharsetUTF8Value, forHTTPHeaderField: kContentTypeHeader)
        }
        
        request.httpMethod = self.httpMethod.rawValue
        request.cachePolicy = .reloadIgnoringCacheData
        request.timeoutInterval = 30
        return request
    }
    
    var url:String {
        var urlString  = "https://api.openweathermap.org/data/2.5/forecast?" + self.path ///*self.baseUrl*/"https://ey3f2y0nre.execute-api.us"
        if self.httpMethod == .get {
            if String.isSringEmpty( self.paramters.queryString){
                urlString += "?" + self.paramters.queryString
            }
            
        }
        return urlString
    }
    
    var paramters: [String : Any]! { ["":""] }
    
    func cancelService(){
        if self.network != nil {
            self.network.cancelTask()
        }
    }
    
    deinit {
        print("deinit network")
    }
}

