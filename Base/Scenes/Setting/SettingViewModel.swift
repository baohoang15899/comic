//  SettingViewModel.swift
//  Base
//
//  Created by baohoang on 24/06/2023.
//  Copyright (c) baohg. All rights reserved.
//
//  This file was generated by the Educa MVVM-C Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  Template created by baohg - bao15899@gmail.com

import Foundation
import RxSwift
import RxCocoa

class SettingViewModel: BaseViewModel {
    
    struct Input {
        let domainString: Driver<String>
        let submitAction: Driver<Void>
        let clearCacheAtion: Driver<Void>
    }
    
    struct Output {
        let isEnableButton: Driver<Bool>
        let showAlert: Driver<Void>
        let showClearCacheAlert: Driver<Void>
    }
    
    private let bag = DisposeBag()
    let confirmClearCache = PublishSubject<Void>()
    
    func transform(input: Input) -> Output {
        
        var keyword: String = ""
        
        confirmClearCache
            .subscribe(onNext: {
                CommonMethod.clearCache()
            })
            .disposed(by: bag)
        
        let canSubmit = input.domainString
            .do(onNext: { key in
                keyword = key
            })
            .map { !$0.isEmpty }
        
        let submit = input.submitAction
            .do(onNext: { _ in
                if (!keyword.isEmpty) {
                    CommonMethod.saveDomain(domain: keyword)
                }
            })
                .mapToVoid()
                
                let clearCacheAction = input.clearCacheAtion.mapToVoid()
                
                return Output(isEnableButton: canSubmit,
                              showAlert: submit,
                              showClearCacheAlert: clearCacheAction)
                
                }
}
