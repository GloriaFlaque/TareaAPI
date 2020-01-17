//
//  ApiNasaInteractorImpl.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 09/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import UIKit

class ApiNasaInteractorImpl: ApiNasaInteractor {
    
    private var repository: ApiNasaRepository
    
    init(repository: ApiNasaRepository) {
        self.repository = repository
    }

    func reatriveApiInformation(searchText: String, output: @escaping (_ result: NasaRequestResult, _ list: [ItemDefault]?) -> Void) {
        self.repository.getData(searchText: searchText) { (result, list)  in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let info):
                output(.success, info)
            }
        }
    }
    
    func setFavorites(item: ItemDefault, output: @escaping (_ result: NasaRequestResult, _ list: [ItemDefault]?) -> Void) {
        self.repository.setFavorites(item: item) { (result, list)  in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let info):
                output(.success, info)
            }
        }
    }
    
    func reatriveFavorites(output: @escaping (_ list: [ItemDefault]?) -> Void) {
        self.repository.getFavorites() { (list) in
            output(list)
            
        }
    }
    
    func deleteFavorites(item: ItemDefault, output: @escaping (_ result: NasaRequestResult, _ list: [ItemDefault]?) -> Void) {
        self.repository.deleteFavorites(item: item) { (result, list)  in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let info):
                output(.success, info)
            }
        }
    }
}
