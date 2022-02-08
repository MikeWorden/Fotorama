//
//  ViewController.swift
//  Fotorama
//
//  Created by Michael Worden on 2/1/22.
//

import UIKit

class FotosViewController: UIViewController {

	
	@IBOutlet private var imageView: UIImageView!
	var store: FotoStore!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		store.fetchInterestingPhotos {
			(photosResult) in
			
			switch photosResult {
			case let .success(photos):
				print("Successfully found \(photos.count) photos.")
				if let firstPhoto = photos.first {
					self.updateImageView(for: firstPhoto)
				}

			case let .failure(error):
				print("Error fetching interesting photos: \(error)")
			}
			
		}
		
		
	}
	
	
	func updateImageView(for foto: Foto) {
		store.fetchImage(for: foto) {
			(imageResult) in

			switch imageResult {
			case let .success(image):
				self.imageView.image = image
			case let .failure(error):
				print("Error downloading image: \(error)")
			}
		}
	}


	
	
	
}

