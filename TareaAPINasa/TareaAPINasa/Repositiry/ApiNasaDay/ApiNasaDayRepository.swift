//
//  ApiNasaDayRepository.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 09/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import Foundation

enum NasaDayError: Error {
    case noDataAvailable
    case canNotProcessData
}

protocol ApiNasaDayRepository {
    func getData (conceptCode: String, completion: @escaping(Result<[Info], NasaImageError>, [Info]?) -> Void)
}
