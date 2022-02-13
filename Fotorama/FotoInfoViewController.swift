//
//  FotoInfoViewController.swift
//  Fotorama
//
//  Created by Michael Worden on 2/11/22.
//

import UIKit

class FotoInfoViewController: UIViewController {

	@IBOutlet var imageView: UIImageView!
	
	
	var foto: Foto! {
		didSet {
			navigationItem.title = foto.title
		}
	}
	var store: FotoStore!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		store.fetchImage(for: foto) { (result) -> Void in
			switch result {
			case let .success(image):
				self.imageView.image = image
			case let .failure(error):
				print("Error fetching image for photo: \(error)")
			}
		}
	}
}
 
