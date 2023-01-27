//
//  APIRequest.swift
//  Base
//
//  Created by BaoHoang on 14/10/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import SwiftSoup
import UIKit

class Service: APIService {
    
    static let shared : Service = {
        let instance = Service()
        return instance
    }()
    
}

class APIService {

    private let bag = DisposeBag()
    private let networkManager = Session.default
    
    private func cancelRequest(url: URL) {
        self.networkManager.request(url).cancel()
    }
    
    func requestEmptyBody<T:Codable>(input: APIInputBase, responseType: T.Type? = nil) -> Single<T> {
        return Single.create { single in
            
            self.networkManager.request(
                input.url,
                method: input.method,
                parameters: input.parameters,
                headers: input.headers
            )
            .validate(statusCode: 200..<300)
            .responseData { response in
                if let data = response.data {
                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    let jsonDict = json as? [String: Any]
                    //  theo format BE trả về
                    if let code = jsonDict?["status_code"] as? Int, let message = jsonDict?["status_message"] as? String { 
                        if code == ErrorCode.invalidApiKey.rawValue {
                            return single(.failure(APIError.error(code: code, message: message)))
                        } else {
                            // for post, delete, put method
                        }
                    }
                
                    else {
                        do {
                            if let responseType = responseType {
                                let res = try JSONDecoder().decode(responseType.self, from: data)
                                return single(.success(res))
                            }
                            
                            else {
                                return single(.failure(APIError.invalidResponseData(data: data)))
                            }
                        }
                        
                        catch {
                            return single(.failure(APIError.invalidResponseData(data: data)))
                        }
                    }
                    
                } else {
                    return single(.failure(APIError.requestFailed))
                }
                
            }
            
            return Disposables.create {
                self.cancelRequest(url: URL(fileURLWithPath: input.url))
            }
            
        }
    }
    
    func requestImage(input: APIInputBase, dataIndex: String) -> Single<ChapterImageModel> {
        return Single.create { single in
            
            self.networkManager.request(
                input.url,
                method: input.method,
                parameters: input.parameters,
                headers: input.headers
            )
            .validate(statusCode: 200..<500)
            .responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    guard let data = response.data else {
                        return single(.failure(APIError.invalidResponseData(data: data)))
                    }
                    return single(.success(ChapterImageModel(image: UIImage(data: data), index: Int(dataIndex))))
                case .failure(let error):
                    return single(.failure(APIError.error(code: error.responseCode ?? 401, message: error.localizedDescription)))
                }
            })
            
            return Disposables.create {
                self.cancelRequest(url: URL(fileURLWithPath: input.url))
            }
            
        }
    }
    
    func request(input: APIInputBase) -> Single<Document> {
        return Single.create { single in
            
            self.networkManager.request(
                input.url,
                method: input.method,
                parameters: input.parameters,
                headers: input.headers
            )
            .validate(statusCode: 200..<500)
            .responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    guard let data = response.data else {
                        return single(.failure(APIError.invalidResponseData(data: data)))
                    }
                    let html = String(data: data, encoding: .utf8) ?? ""
                    do {
                        let doc: Document = try SwiftSoup.parse(html)
                        return single(.success(doc))
                    } catch {
                        return single(.failure(APIError.invalidResponseData(data: data)))
                    }
                case .failure(let error):
                    return single(.failure(APIError.error(code: error.responseCode ?? 401, message: error.localizedDescription)))
                }
            })
            
            return Disposables.create {
                self.cancelRequest(url: URL(fileURLWithPath: input.url))
            }
            
        }
        
    }
    
    func requestArray<T:Decodable>(input: APIInputBase, responseType: [T].Type) -> Single<T> {
        return Single.create { single in
            
            self.networkManager.request(
                input.url,
                method: input.method,
                parameters: input.parameters,
                headers: input.headers
            )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: responseType.self) { response in
                switch response.result {
                case .success(let data):
                    guard let data = response.value?.first else {
                        return single(.failure(APIError.invalidResponseData(data: data)))
                    }
                    return single(.success(data))
                case .failure(let error):
                    return single(.failure(APIError.error(code: error.responseCode ?? 401, message: error.localizedDescription)))
                }
            }
            return Disposables.create {
                self.cancelRequest(url: URL(fileURLWithPath: input.url))
            }
            
        }
        
    }
    
}
