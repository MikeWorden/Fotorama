//
//  FotoStore.swift
//  Fotorama
//
//  Created by Michael Worden on 2/1/22.
//


import Foundation

class FotoStore {
	
	
	private let session: URLSession = {
			let config = URLSessionConfiguration.default
			return URLSession(configuration: config)
		}()
	
	
	
	func fetchInterestingPhotos() {
		
		let url = FlickrAPI.interestingPhotosURL
		let request = URLRequest(url: url)
		let task = session.dataTask(with: request) {
			(data, response, error) in
			
			if let jsonData = data {
				if let jsonString = String(data: jsonData,
										   encoding: .utf8) {
					print(jsonString)
				}
			} else if let requestError = error {
				print("Error fetching interesting photos: \(requestError)")
			} else {
				print("Unexpected error with the request")
			}
		}
		task.resume()
	}

	
}


