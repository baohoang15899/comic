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
    }
    
    struct Output {
        let isEnableButton: Driver<Bool>
        let showAlert: Driver<Void>
    }
    
    private let bag = DisposeBag()

    func transform(input: Input) -> Output {
        
        var keyword: String = ""
        
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
        
        return Output(isEnableButton: canSubmit, showAlert: submit)
    }
}