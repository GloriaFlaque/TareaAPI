//
//  ApiNasaInteractor.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 09/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import UIKit

enum NasaImageRequestResult: Int {
    
    case success, error
    
    init() {
        
        self = .success
    }
}

protocol ApiNasaInteractor {
    
    func reatriveApiInformation(searchText: String, output: @escaping (_ result: NasaImageRequestResult, _ list: [ItemDetails]?) -> Void)
}


