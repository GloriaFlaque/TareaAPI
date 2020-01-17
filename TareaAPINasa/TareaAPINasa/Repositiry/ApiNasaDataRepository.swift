//
//  ApiNasaDataRepository.swift
//  TareaAPINasa
//
//  Created by Gloria Flaqué García on 09/01/2020.
//  Copyright © 2020 Gloria Flaqué García. All rights reserved.
//

import Foundation

/// API implementaion for repository.
class ApiNasaDataRepository: ApiNasaRepository {    
    var position = -1
    
    func getData (searchText: String, completion: @escaping(Result<[ItemDefault], NasaError>, [ItemDefault]?) -> Void) {
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
                var itemsFavorites: [ItemDefault] = []
                for i in itemResponse {
                    if self.checkIfIsFavorite(item: i) {
                        let item = ItemDefault(data: i.data, links: i.links, favorite: true)
                            itemsFavorites.append(item)
                    } else {
                       let item = ItemDefault(data: i.data, links: i.links, favorite: false)
                       itemsFavorites.append(item)
                    }
                }
                completion(.success(itemsFavorites), itemsFavorites)
            } catch {
                completion(.failure(.canNotProcessData), nil)
            }
        }
        dataTask.resume()
    }
    
    func setFavorites(item: ItemDefault, completion: @escaping(Result<[ItemDefault], NasaError>, [ItemDefault]?) -> Void) {
        let defaults = UserDefaults.standard
        guard let defaultData = defaults.object(forKey: "favorites") as? Data else {
            let encodedData = try? PropertyListEncoder().encode([item])
            UserDefaults.standard.set(encodedData, forKey:"favorites")
            UserDefaults.standard.synchronize();
            return
        }
        let decoder = PropertyListDecoder()
        guard let itemDefault = try? decoder.decode([ItemDefault].self, from: defaultData) else {
            return
        }
        var favoriteList = itemDefault
        if !self.checkIfWasFavorite(items: favoriteList, item: item) {
            favoriteList.append(item)
        }
        let encodedData = try? PropertyListEncoder().encode(favoriteList)
        UserDefaults.standard.set(encodedData, forKey:"favorites")
        UserDefaults.standard.synchronize();
        completion(.success(favoriteList), favoriteList)
    }
    
    func deleteFavorites(item: ItemDefault, completion: @escaping(Result<[ItemDefault], NasaError>, [ItemDefault]?) -> Void) {
        let defaults = UserDefaults.standard
        guard let defaultData = defaults.object(forKey: "favorites") as? Data else {
            return
        }
        let decoder = PropertyListDecoder()
        guard let itemDefault = try? decoder.decode([ItemDefault].self, from: defaultData) else {
            return
        }
        var favoriteList = itemDefault
        for _ in favoriteList {
            if self.checkIfWasFavorite(items: favoriteList, item: item) {
                favoriteList.remove(at: position)
            }
        }
        let encodedData = try? PropertyListEncoder().encode(favoriteList)
        UserDefaults.standard.set(encodedData, forKey:"favorites")
        UserDefaults.standard.synchronize();
        completion(.success(favoriteList), favoriteList)
    }
    
    func getFavorites (completion: @escaping([ItemDefault]?) -> Void) {
        let defaults = UserDefaults.standard
        guard let defaultData = defaults.object(forKey: "favorites") as? Data else {
            return
        }
        let decoder = PropertyListDecoder()
        guard let itemDefault = try? decoder.decode([ItemDefault].self, from: defaultData) else {
            return
        }
        for i in itemDefault {
            i.favorite = true
        }
        completion(itemDefault)
    }
    
    func checkIfIsFavorite(item: ItemDetails) -> Bool {
        var isFav = false
        let defaults = UserDefaults.standard
        guard let playerData = defaults.object(forKey: "favorites") as? Data else {
            return false
        }
        let decoder = PropertyListDecoder()
        guard let itemDefault = try? decoder.decode([ItemDetails].self, from: playerData) else {
            return false
        }
        for i in itemDefault {
            for i in i.data {
                for x in item.data {
                    if i.title == x.title {
                        isFav = true
                    }
                }
            }
        }
        return isFav
    }
    
    func checkIfWasFavorite(items: [ItemDefault], item: ItemDefault) -> Bool {
        var wasFav = false
        var position2 = 0
        for i in items {
            for x in i.data {
                for e in item.data {
                    if x.title == e.title {
                        wasFav = true
                        position = position2
                    }
                    position2 = position2 + 1
                }
            }
        }
        return wasFav
    }
}
