//
//  NetworkApi.swift
//  ListingsApp
//
//  Created by Rana Ijaz on 20/08/2022.
//

import Foundation

class NetworkApi: NetworkRequest {
    
    var session : URLSession = URLSession.shared
    var currentTask : URLSessionTask!
    var url : URL! //Holds the current request url
    
    init() {
    }
    
    func request<T: Decodable>(_ request : URLRequest, success : @escaping ResultSuccess<T>,failure : @escaping ResultFailure){
                
        #if DEBUG
        print("URL --> \(String(describing: request.url?.absoluteURL))")
        #endif
        
        self.cancelTask()
        let networkError : NetworkError = NetworkError()
        self.currentTask = self.session.dataTask(with: request, completionHandler: { (data, response, error) in
            if let _ = error {//Check the client side error
                 networkError.statusCode = Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue)
                if let err =  error as NSError? {
                    networkError.statusCode = err.code
                }
               
                failure(networkError)
            }else{
                guard let httpRespone = response as? HTTPURLResponse, (200...299).contains(httpRespone.statusCode) else {
                    networkError.statusCode = (response as? HTTPURLResponse)?.statusCode
                    //if let data = data {
                    if data != nil { //Temporary for the warning fix
  
                        // TODO: Check for the error
//                        if let responseObject = try? JSONDecoder().decode(ErrorMessage.self, from:data) {
//                            networkError.errorMessage = responseObject.errorDescription
//                            networkError.error_description = responseObject.error_description
//
//                        }
                    }
                    failure(networkError)
                    return
                    
                }
                if let data = data {
                    //Hanlde data
                    print(String(decoding: data, as: UTF8.self))
                    
                    if let responseObject = try? JSONDecoder().decode(T.self, from:data) {
                        success(responseObject)
                    }
                    
                }
                
            }
        })
        self.currentTask.resume()
    }
    
    func cancelTask(){
        if self.currentTask != nil {
            self.currentTask.cancel()
        }
    }
    
    
    
}
