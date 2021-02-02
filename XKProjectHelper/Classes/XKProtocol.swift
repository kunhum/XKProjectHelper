//
//  XKProtocol.swift
//  XKProjectHelper
//
//  Created by Nicholas on 2021/2/2.
//

import Foundation
import HandyJSON

protocol XKViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
    
//    func transform(input: Input) -> Output
}

protocol XKResponseProtocol: HandyJSON {
    
    func xk_isSuccessfulCode() -> Bool
    
    func xk_fetchMessage() -> String
}
