//
//  ApiService.swift
//  YTSample
//
//  Created by robert john alkuino on 1/5/17.
//  Copyright © 2017 thousandminds. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class ApiService<T:Mappable> {
    
    private static var host: String {
        switch Env {
        case .Development: return "optonaut.ngrok.io"
        case .Staging: return "api-staging.dscvr.com"
        case .localStaging: return "https://www.googleapis.com"
        case .Production: return "api-production-v9.dscvr.com"
        }
    }
    
    func buildUrl(endPoint:String) -> URL {
        
        let urlStr = URL(string: ApiService.host + endPoint)!
        
        return urlStr
    }
    
    
    func request(keyPath: String,urlEndpoint: String,params: Dictionary<String, Any>?,method: HTTPMethod,completion: @escaping ([T]?) -> Void) {
        
        let urlString = buildUrl(endPoint: urlEndpoint)
        
        Alamofire.request(urlString, method: method, parameters: params, encoding: URLEncoding.default)
            .validate { request, response, data in
                return .success
            }
            .responseArray(keyPath: keyPath) { (response: DataResponse<[T]>) in
                completion(response.result.value)
            }
        
    }
    func request(urlEndpoint: String,params: Dictionary<String, Any>?,method: HTTPMethod,completion: @escaping (T?) -> Void) {
        
        let urlString = buildUrl(endPoint: urlEndpoint)
        
        Alamofire.request(urlString, method: method, parameters: params, encoding: URLEncoding.default)
            .validate { request, response, data in
                return .success
            }
            .responseObject{ (response: DataResponse<T>) in
                completion(response.result.value)
        }
    }
}
