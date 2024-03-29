//  CategoryAPIRouter.swift
//  Base
//
//  Created by BaoHoang on 31/01/2023.
//  Copyright (c) baohg. All rights reserved.
//
//  This file was generated by the Educa MVVM-C Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  Template created by baohg - bao15899@gmail.com

import UIKit
import Alamofire

enum CategoryRouter {
    case allComic(page: Int, url: String)
    case allCategory
}

extension CategoryRouter: APIInputBase {
    
    var headers: Alamofire.HTTPHeaders? {
        return nil
    }
    
    var url: String {
        switch self {
        case .allCategory:
            return "\(DomainUrl().domain)\(nettruyenPath.all)"
        case .allComic(_ , let url):
            return url
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .allComic:
            return .get
        case .allCategory:
            return .get
        }
    }
    
    var encoding: Alamofire.ParameterEncoding {
        return method == .get ? URLEncoding.default : JSONEncoding.default
    }
    
    
    var parameters: [String : Any]? {
        switch self {
        case .allComic(let page, _):
            return ["page": page]
        case .allCategory:
            return [:]
        }
    }
}
