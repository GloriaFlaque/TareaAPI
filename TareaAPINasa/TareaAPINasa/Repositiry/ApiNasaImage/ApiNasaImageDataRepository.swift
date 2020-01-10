//
//  ApiNasaImageDataRepository.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 09/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import Foundation

class ApiNasaImageDataRepository: ApiNasaImageRepository {
    
    func getData (conceptCode: String, completion: @escaping(Result<[ItemsDatails], NasaImageError>, [ItemsDatails]?) -> Void) {
        let resourceString = "https://images-api.nasa.gov/search?q=\(conceptCode)"
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
