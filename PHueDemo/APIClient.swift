//
//  APIClient.swift
//  PHueDemo
//
//  Created by Liu Jinyu on 9/11/16.
//  Copyright © 2016 Liu Jinyu. All rights reserved.
//

import Foundation
import Alamofire

class APIClient: NSObject {
    
    
    func PUTBrightness(value: Int){

        Alamofire.request(Router.PUTBri(value))
    }
}
