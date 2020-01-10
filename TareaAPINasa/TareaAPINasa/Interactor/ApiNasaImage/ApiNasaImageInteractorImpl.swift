//
//  ApiNasaImageInteractorImpl.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 09/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import UIKit

class ApiNasaImageInteractorImpl: ApiNasaImageInteractor {
    
    private var repository: ApiNasaImageRepository
    
    init(repository: ApiNasaImageRepository) {
        self.repository = repository
    }
    
    func reatriveApiInformation(conceptCode: String, output: @escaping (_ result: NasaImageRequestResult, _ list: [ItemsDatails]?) -> Void) {
        self.repository.getData(conceptCode: conceptCode) { (result, list)  in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let info):
                output(.success, info)
            }
        }
    }
}
