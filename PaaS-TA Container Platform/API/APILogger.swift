//
//  APILogger.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/27.
//

import Foundation
import Alamofire

final class ApiLogger: EventMonitor {
    let queue = DispatchQueue(label: "PaaS-TA Container Platform Logger")
    
    // Event called when any type of Request is resumed.
    func requestDidResume(_ request: Request) {
        print("APILogger - Resuming: \(request)")
    }
    
    // Event called whenever a DataRequest has parsed a response.
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        debugPrint("APILogger - Finished: \(response)")
    }
}
