//
//  FotoCollectionViewCell.swift
//  Fotorama
//
//  Created by Michael Worden on 2/10/22.
//

import UIKit

class FotoCollectionViewCell: UICollectionViewCell {

	
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var spinner: UIActivityIndicatorView!

	
	func update(displaying image: UIImage?) {
		if let imageToDisplay = image {
			spinner.stopAnimating()
			imageView.image = imageToDisplay
			
		} else {
			spinner.startAnimating()
			imageView.image = nil
		}
	}

}

