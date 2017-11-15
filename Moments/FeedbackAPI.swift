//
//  Feedback.swift
//  Moments
//
//  Created by user on 14/11/17.
//  Copyright © 2017 user. All rights reserved.
//

import Foundation
import Alamofire

enum Feedback : URLRequestConvertible{
    
    case feedback(text: String)
    
    func asURLRequest() throws -> URLRequest {
        
        let request: (method: HTTPMethod,queryParameters: Parameters?,parameter: Parameters, path: String,encoding: Alamofire.ParameterEncoding) = {
        
                    switch self {
        
                    case .feedback(let text):
        
                        return (.post,["json": true, "t": Date().timeIntervalSince1970 * 1000],FeedBackService.feedBack(text: text),"/forms/process",URLEncoding.default)
                    }
        
                }()
        
        let url = try! URL(string: "http://my.loopto.do")?.asURL()
        
        var urlRequest = URLRequest(url: (url?.appendingPathComponent(request.path))!)
        
        if let qParams = request.queryParameters {
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: qParams)
        }
        
        urlRequest.httpMethod = request.method.rawValue
        
        print(urlRequest)
        
        urlRequest = try request.encoding.encode(urlRequest, with: request.parameter)
        
        return urlRequest
    }
    
}


class FeedBackService {
   
    typealias completionHandler = (_ alertMsg: String?) -> Void
    
    static func sendFeedBack(feedback : Feedback,completion: completionHandler?) {
        
         Alamofire.request(feedback).responseString { (response) in
        
            switch response.result {
            case .success(let value):
                print("success",value)
                completion?("Feedback sent Successfully")
                
            case .failure(let error):
                print("failed to send the feedback",error)
                completion?("Something went wrong")
                
            }
        }
    }
    
   static func feedBack(text: String) -> [String:String]{
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? ""
        let currentDevice = UIDevice.current
        let deviceName = currentDevice.name
        let deviceId = currentDevice.identifierForVendor?.uuidString ?? ""
        let deviceModal = currentDevice.model
        let deviceOSVersion = currentDevice.systemVersion
        
        print(appVersion,currentDevice,deviceName,deviceId,deviceModal,deviceOSVersion)
        
        let feedbackParameter = "\(text)<br><br>-------------Application Info -------------<br>Application version: \(appVersion)<br><br>------------- Device Info -------------<br>Device ID: \(deviceId)<br>Device Name: \(deviceName)<br>Device Model: \(deviceModal)<br>DeviceOs Version: \(deviceOSVersion)"
        
        let feedBack: [String: String] = ["tag": "feedBack", "loopKey": "agtzfmxvb3BhYmFja3IRCxIETG9vcBiAgKCBz82QCgw","card_title": "IOS Full Learn Feedback","card_desc": feedbackParameter]
        
        return feedBack
        
    }
    
}
