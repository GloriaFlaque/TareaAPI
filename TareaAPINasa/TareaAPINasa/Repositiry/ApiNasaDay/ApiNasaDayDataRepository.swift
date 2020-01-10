//
//  ApiNasaDayDataRepository.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 09/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import Foundation

class ApiNasaDayDataRepository: ApiNasaDayRepository {
    
    func getData (conceptCode: String, completion: @escaping(Result<[Info], NasaImageError>, [Info]?) -> Void) {
        let resourceString = "https://api.nasa.gov/planetary/apod?date=\(conceptCode)&hd=True&api_key=UTF2I6JZm2mafnf8rYbibCa6kwg4fW88hm0Nwqf7"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, error in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable), nil)
                return
            }
            do{
                let decoder = JSONDecoder()
                let infoResponse = try decoder.decode(Info.self, from: jsonData)
                completion(.success([infoResponse]), [infoResponse])
            } catch {
                completion(.failure(.canNotProcessData), nil)
            }
        }
        dataTask.resume()
    }
}
