//
//  ApiNasaDayInteractor.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 09/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import UIKit

enum NasaDayRequestResult: Int {
    
    case success, error
    
    init() {
        
        self = .success
    }
}

protocol ApiNasaDayInteractor {
    
    func reatriveApiInformation(conceptCode: String, output: @escaping (_ result: NasaDayRequestResult, _ list: [Info]?) -> Void)
}
