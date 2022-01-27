//
//  File.swift
//  NASA Picture of the Day
//
//  Created by Tiago Pereira on 26/01/22.
//


import Foundation

class PhotoInfoCoordinator {
    private let apodURLString = "https://api.nasa.gov/planetary/apod"
    // Key generated for tiagogomespereira@gmail.com
    private let apodAPIKey: String = "m2I4N03QGRpocrwaQvGPVSzxaDdPqFGzfWDdESHQ"
    
    private var apiURL: URL {
        var urlComponents = URLComponents(string: "https://api.nasa.gov/planetary/apod")!
        
        urlComponents.queryItems = [
            "api_key": apodAPIKey
        ].map{ URLQueryItem(name: $0.key, value: $0.value) }
        
        return urlComponents.url!
    }
    
    private func apiURL(for date: Date) -> URL {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "Y-MM-dd"
        
        let dateAsString = dateFormatter.string(from: date)
        
        var urlComponents = URLComponents(string: "https://api.nasa.gov/planetary/apod")!
        
        urlComponents.queryItems = [
            "api_key": apodAPIKey,
            "date": dateAsString
        ].map{ URLQueryItem(name: $0.key, value: $0.value) }
        
        return urlComponents.url!
    }
    
    func fetchPhotoInfo() async throws -> Result<PhotoInfo, Error> {
        do {
            let (data, _) = try await URLSession.shared.data(from: apiURL)
            let decodedPhotoInfo = try JSONDecoder().decode(PhotoInfo.self, from: data)
            return .success(decodedPhotoInfo)
        } catch {
            return .failure(error)
        }
    }
    
    func fetchPhotoInfo(for date: Date) async throws -> Result<PhotoInfo, Error> {
        let url = self.apiURL(for: date)
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedPhotoInfo = try JSONDecoder().decode(PhotoInfo.self, from: data)
            return .success(decodedPhotoInfo)
        } catch {
            return .failure(error)
        }
    }
}

