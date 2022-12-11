//
//  NetworkManager.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 09/12/22.
//

import Foundation

typealias ApiHandler = ((_ data: Data?,_ response: Any?, _ error: Error?) -> (Void))
typealias ApiCompletionHandler = (() -> (Void))

// MARK: - For Managing Network
class CTNetworkManager {
    static let sharedInstance = CTNetworkManager()
    
    private init() {
        
    }
    // MARK: - calling api with url session
    func apiRequestForRawData(urlString: String, httpMethod: HTTPMethod ,info: [String:Any]?, requestHeaders: [String:String]?, completion: @escaping ApiHandler) {
        let urlStr = Constants.BaseUrlType.ctBaseURL + urlString
        debugPrint("Url: --- \(urlStr)")
        debugPrint("Param: --- \(info ?? [:])")
        guard let url = URL(string: urlStr) else {debugPrint("URL issue"); return completion(nil, nil, nil)}
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: Constants.requsetTimeOut)
        request.httpMethod = httpMethod.rawValue
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                completion(nil, nil, nil)
            } else {
                guard let dataResponse = data, error == nil else {
                    debugPrint(error?.localizedDescription ?? "Response Error")
                    completion(nil, nil, nil)
                    return
                }
                if let stringData = String(data: dataResponse, encoding: String.Encoding.utf8) {
                    debugPrint("Response Data -- \(stringData)")
                    let data = stringData.data(using: .utf8)!
                    if let res = try? JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String: Any],let httpResponse = response as? HTTPURLResponse{
                        debugPrint(httpResponse.statusCode)
                        completion(data, res, nil)
                    }else if let res = try? JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [[String: Any]], let httpResponse = response as? HTTPURLResponse {
                        debugPrint(httpResponse.statusCode)
                        completion(data, res, nil)
                    } else {
                        completion(nil,nil,nil)
                    }
                }else{
                    completion(nil,nil,nil)
                }
            }
        })
        dataTask.resume()
    }
}
