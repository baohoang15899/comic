//
//  ObservableExtension.swift
//  Base
//
//  Created by BaoHoang on 30/11/2022.
//

import Foundation
import RxSwift

extension Observable {
    
    func catchErrReturnEmpty() -> Observable {
        return `catch` { error in
            print("request error: \(error)")
            return .empty()
        }
    }
    
    func catchErrReturnElement(element: Element, handler: (() -> ())? = nil) -> Observable<Element> {
        return `catch` { error in
            handler?()
            print("err element\(element)")
            return .just(element)
        }
    }
    
}
