//
//  ApiNasaRequest.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 26/12/2019.
//  Copyright © 2019 Gloria Flaqué García. All rights reserved.
//

import Foundation

enum NasaError: Error {
    case noDataAvailable
    case canNotProcessData
}

struct ApiNasaRequest {
    let resourceURL:URL
    let API_KEY = "UTF2I6JZm2mafnf8rYbibCa6kwg4fW88hm0Nwqf7"
    
    init(dateCode:String){
        let resourceString = "https://api.nasa.gov/planetary/apod?date=\(dateCode)&hd=True&api_key=\(API_KEY)"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    func getData (completion: @escaping(Result<[Info], NasaError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do{
                let decoder = JSONDecoder()
                let nasaResponse = try decoder.decode(Info.self, from: jsonData)
                completion(.success([nasaResponse]))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}

struct ApiNasaNameRequest {
    let resourceURL:URL
    let API_KEY = "UTF2I6JZm2mafnf8rYbibCa6kwg4fW88hm0Nwqf7"
    
    init(conceptCode:String){
        let resourceString = "https://images-api.nasa.gov/search?q=sun"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    func getData (completion: @escaping(Result<[ItemsDatails], NasaError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, error in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do{
                let decoder = JSONDecoder()
                let collectionResponse = try decoder.decode(CollectionInfo.self, from: jsonData)
                let itemResponse = collectionResponse.collection.items
                completion(.success(itemResponse))
            } catch {
                
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}
