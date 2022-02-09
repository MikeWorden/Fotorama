//
//  FlickerAPI.swift
//  Fotorama
//
//  Created by Michael Worden on 2/1/22.
//

import Foundation


enum EndPoint: String {
	case interestingPhotos = "flickr.interestingness.getList"
	case recentPhotos = "flickr.photos.getRecent"

}

struct FlickrAPI {
	
	private static let baseURLString = "https://api.flickr.com/services/rest"
	private static let apiKey = "a6d819499131071f158fd740860a5a88"

	

	private static func flickrURL(endPoint: EndPoint,
								  parameters: [String:String]?) -> URL {

		var components = URLComponents(string: baseURLString)!
		var queryItems = [URLQueryItem]()
		
		let baseParams = [
			"method": endPoint.rawValue,
			"format": "json",
			"nojsoncallback": "1",
			"api_key": apiKey
		]
		
		for (key, value) in baseParams {
			let item = URLQueryItem(name: key, value: value)
			queryItems.append(item)
		}
				
				
				
		if let additionalParams = parameters {
			for (key, value) in additionalParams {
				let item = URLQueryItem(name: key, value: value)
				queryItems.append(item)
			}
		}
		components.queryItems = queryItems
		
		return components.url!
		
		
	}
	
	static var interestingPhotosURL: URL {
		return flickrURL(endPoint: .interestingPhotos,
						 parameters: ["extras": "url_z,date_taken"])
	}
	
	static var recentPhotosURL: URL {
		return flickrURL(endPoint: .recentPhotos,
						 parameters: ["extras": "url_z,date_taken"])
	}
	
	struct FlickrResponse: Codable {
		
		let fotosInfo: FlickrPhotosResponse
		
		enum CodingKeys: String, CodingKey {
			case fotosInfo = "photos"
		}
	}

	struct FlickrPhotosResponse: Codable {
		
		
		let fotos: [Foto]
		enum CodingKeys: String, CodingKey {
				case fotos = "photo"

		}
	}

	static func fotos(fromJSON data: Data) -> Result<[Foto], Error> {
		do {
			let decoder = JSONDecoder()
			
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
			dateFormatter.locale = Locale(identifier: "en_US_POSIX")
			dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
			decoder.dateDecodingStrategy = .formatted(dateFormatter)

			
			let flickrResponse = try decoder.decode(FlickrResponse.self, from: data)
			let photos = flickrResponse.fotosInfo.fotos.filter { $0.remoteURL != nil }
					return .success(photos)

		} catch {
			return .failure(error)
		}
	}
	
}



