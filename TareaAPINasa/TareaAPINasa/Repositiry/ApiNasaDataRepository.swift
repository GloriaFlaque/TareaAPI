//
//  ApiNasaDataRepository.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 09/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import Foundation

class ApiNasaDataRepository: ApiNasaRepository {
    
    func getData (searchText: String, completion: @escaping(Result<[ItemDetails], NasaImageError>, [ItemDetails]?) -> Void) {
        let resourceString = "https://images-api.nasa.gov/search?q=\(searchText)"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, error in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable), nil)
                return
            }
            do{
                let decoder = JSONDecoder()
                let collectionResponse = try decoder.decode(CollectionInfo.self, from: jsonData)
                let itemResponse = collectionResponse.collection.items
                completion(.success(itemResponse), itemResponse)
            } catch {
                
                completion(.failure(.canNotProcessData), nil)
            }
        }
        dataTask.resume()
    }
}
