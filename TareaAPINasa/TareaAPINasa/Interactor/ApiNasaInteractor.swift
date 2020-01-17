//
//  ApiNasaInteractor.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 09/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import UIKit

/// Enum to know user repository operation result.
///
/// - success: operation finished without error.
/// - error: operation finished with error.
enum NasaRequestResult: Int {
    
    case success, error
    
    init() {
        
        self = .success
    }
}

protocol ApiNasaInteractor {
    
    /// Reatrive data
    /// - Parameter searchText: seach name
    /// - Parameter output: result with enum option
    func reatriveApiInformation(searchText: String, output: @escaping (_ result: NasaRequestResult, _ list: [ItemDefault]?) -> Void)
    
    /// Reatrive data
    /// - Parameter searchText: seach name
    /// - Parameter output: result with enum option
    func setFavorites(item: ItemDefault, output: @escaping (_ result: NasaRequestResult, _ list: [ItemDefault]?) -> Void)
    
    /// Reatrive favorites
    /// - Parameter output: result with favorite list
    func reatriveFavorites(output: @escaping (_ list: [ItemDefault]?) -> Void)
    
    /// Reatrive favorites
    /// /// - Parameter item: item to delete from favorite list
    /// - Parameter output: result with favorite list
    func deleteFavorites(item: ItemDefault, output: @escaping (_ result: NasaRequestResult, _ list: [ItemDefault]?) -> Void)
}


