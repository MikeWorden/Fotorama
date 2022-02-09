//
//  FotoStore.swift
//  Fotorama
//
//  Created by Michael Worden on 2/1/22.
//


import UIKit

enum PhotoError: Error {
	case imageCreationError
	case missingImageURL
}



class FotoStore {
	
	
	private let session: URLSession = {
			let config = URLSessionConfiguration.default
			return URLSession(configuration: config)
		}()
	
	func bronzeChallenge19 (response: HTTPURLResponse) {
		print("URL:  \(String(describing:  response.url))")
		print("Response Code:  \(String(describing: response.statusCode))")
		print("HeaderFields:  \(String(describing:  response.allHeaderFields))")
		
	
	}
	
	func fetchInterestingPhotos(completion: @escaping (Result<[Foto], Error>) -> Void)  {
		
		let url = FlickrAPI.interestingPhotosURL
		let request = URLRequest(url: url)
		let task = session.dataTask(with: request) {
			(data, response, error) in
			if let response = response as? HTTPURLResponse {
				self.bronzeChallenge19(response: response)
			}
			let result = self.processPhotosRequest(data: data, error: error)
			OperationQueue.main.addOperation {
				completion(result)
			}
		}
		task.resume()
	}
	
	func fetchRecentPhotos(completion: @escaping (Result<[Foto], Error>) -> Void)  {
		
		let url = FlickrAPI.recentPhotosURL
		let request = URLRequest(url: url)
		let task = session.dataTask(with: request) {
			(data, response, error) in
			/*if let response = response as? HTTPURLResponse {
				self.bronzeChallenge19(response: response)
			}*/
			let result = self.processPhotosRequest(data: data, error: error)
			OperationQueue.main.addOperation {
				completion(result)
			}
			
		}
		task.resume()
	}
	
	private func processPhotosRequest(data: Data?,
									  error: Error?) -> Result<[Foto], Error> {
		guard let jsonData = data else {
			return .failure(error!)
		}
		
		return FlickrAPI.fotos(fromJSON: jsonData)
	}

	
	private func processImageRequest(data: Data?,
									 error: Error?) -> Result<UIImage, Error> {
		guard
			let imageData = data,
			let image = UIImage(data: imageData) else {

				// Couldn't create an image
				if data == nil {
					return .failure(error!)
				} else {
					return .failure(PhotoError.imageCreationError)
				}
		}

		return .success(image)
	}

	
	


	func fetchImage(for foto: Foto,
					completion: @escaping (Result<UIImage, Error>) -> Void) {
		guard let photoURL = foto.remoteURL else {
			completion(.failure(PhotoError.missingImageURL))
			return
		}
		let request = URLRequest(url: photoURL)
		
		let task = session.dataTask(with: request) {
			(data, response, error) in
			let result = self.processImageRequest(data: data, error: error)
			OperationQueue.main.addOperation {
				completion(result)
			}
			
		}
		task.resume()
	}

	
	
	

	
	
	
}


