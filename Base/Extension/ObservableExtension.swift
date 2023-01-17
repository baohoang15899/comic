//
//  ObservableExtension.swift
//  Base
//
//  Created by BaoHoang on 30/11/2022.
//

import Foundation
import RxSwift

extension Observable {
    
    func handleErr() -> Observable {
        return `catch` { error in
            print("request error: \(error)")
            return .empty()
        }
    }
    
}
