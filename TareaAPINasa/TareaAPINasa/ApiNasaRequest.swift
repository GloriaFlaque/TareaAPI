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
