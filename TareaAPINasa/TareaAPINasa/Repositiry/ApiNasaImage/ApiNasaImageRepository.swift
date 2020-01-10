//
//  ApiNasaImageRepository.swift
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

protocol ApiNasaImageRepository {
    func getData (conceptCode: String, completion: @escaping(Result<[ItemsDatails], NasaImageError>, [ItemsDatails]?) -> Void)
}
