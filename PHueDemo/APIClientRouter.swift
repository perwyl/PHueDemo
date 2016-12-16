//
//  APIClientRouter.swift
//  PHueDemo
//
//  Created by Liu Jinyu on 9/11/16.
//  Copyright © 2016 Liu Jinyu. All rights reserved.
//

import Foundation
import Alamofire

struct spotifyAPISettings {
    static let clientID = "f9d43014a8bd4c259c14d8093faa9aed"
    static let clientSecret = "3a3866b3d96b4a2aa664802220cfedef"
}

struct APISettings {
    static let azureURLString = "http://10.10.43.133/api/zoG5NHui7WTIgaJQUkEDl51Rl1xTqYHhyy8wtKVV/lights/1/state"
    static let baseURLString = azureURLString
    static let changeHuePath = "/bri"
    static var bulbID = "1"
}

enum Router: URLRequestConvertible {
    
    static let baseURLString = ("\(APISettings.baseURLString)/\(APISettings.bulbID)/state")
    
    case PUTBri(Int)
    case PUTHue([Double])
    case PutHueBri([Double], Int)
    
    var method: HTTPMethod {
        switch self {
        case .PUTBri, .PUTHue, .PutHueBri:
            return .put
        }
    }
    
    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        
        let urlString = Router.baseURLString
        let url = try urlString.asURL()
    
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .PUTBri(let value):
            let json = ["bri": value]
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: json)
        case .PUTHue(let values):
            let json = ["xy": values]
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: json)
        case .PutHueBri(let hue, let bri):
            let json: [String: Any] = ["xy": hue, "bri": bri]
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: json)
        }
        return urlRequest        
    }
}

