//
//  Foto.swift
//  Fotorama
//
//  Created by Michael Worden on 2/3/22.
//

import Foundation


class Foto: Codable {
	let title: String
	let remoteURL: URL?
	let fotoID: String
	let dateTaken: Date

	enum CodingKeys: String, CodingKey {
		case title
		case remoteURL = "url_z"
		case fotoID = "id"
		case dateTaken = "datetaken"
	}
}

extension Foto: Equatable {
	static func == (lhs: Foto, rhs: Foto) -> Bool {
		// Two Photos are the same if they have the same photoID
		
		return lhs.fotoID == rhs.fotoID
	}
}
		 
