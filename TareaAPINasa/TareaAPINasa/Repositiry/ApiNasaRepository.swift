//
//  ApiNasaRepository.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 09/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import Foundation

enum NasaError: Error {
    case noDataAvailable
    case canNotProcessData
}

protocol ApiNasaRepository {
    
   /// Get data value.
   ///
   /// - Parameter searchText: the key word to serach
   /// - Parameter completion: data completion result.
    func getData (searchText: String, completion: @escaping(Result<[ItemDefault], NasaError>, [ItemDefault]?) -> Void)
    
    /// Set favorites values.
    ///
    /// - Parameter item: favorite to set
    /// - Parameter completion: favorite completion result.
    func setFavorites(item: ItemDefault, completion: @escaping(Result<[ItemDefault], NasaError>, [ItemDefault]?) -> Void)
    
    /// Get favorites values.
    ///
    /// - Parameter completion: return the lsit of favorites
    func getFavorites (completion: @escaping([ItemDefault]?) -> Void)
    
    /// Set favorites values.
    ///
    /// - Parameter item: set a delete favorite
    /// - Parameter completion: favorite completion result.
    func deleteFavorites(item: ItemDefault, completion: @escaping(Result<[ItemDefault], NasaError>, [ItemDefault]?) -> Void)
}
