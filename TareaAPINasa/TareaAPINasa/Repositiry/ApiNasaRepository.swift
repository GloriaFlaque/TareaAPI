//
//  ApiNasaRepository.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 09/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import Foundation

enum NasaImageError: Error {
    case noDataAvailable
    case canNotProcessData
}

protocol ApiNasaRepository {
    func getData (searchText: String, completion: @escaping(Result<[ItemDetails], NasaImageError>, [ItemDetails]?) -> Void)
}
