//
//  ViewController.swift
//  Fotorama
//
//  Created by Michael Worden on 2/1/22.
//

import UIKit

class FotosViewController: UIViewController, UICollectionViewDelegate {

	
	//@IBOutlet private var imageView: UIImageView!
	@IBOutlet var collectionView: UICollectionView!
	
	var store: FotoStore!
	let fotoDataSource = FotoDataSource()
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		collectionView.dataSource = fotoDataSource
		collectionView.delegate = self

		
		
		store.fetchInterestingPhotos{
			(photosResult) in
			
			switch photosResult {
			case let .success(photos):
				print("Successfully found \(photos.count) photos.")
				self.fotoDataSource.fotos = photos

			case let .failure(error):
				print("Error fetching interesting photos: \(error)")
				self.fotoDataSource.fotos.removeAll()
			}
			self.collectionView.reloadSections(IndexSet(integer: 0))

			
			
		}
		
		
	}
	
	
	func collectionView(_ collectionView: UICollectionView,
						willDisplay cell: UICollectionViewCell,
						forItemAt indexPath: IndexPath) {
		
		let foto = fotoDataSource.fotos[indexPath.row]
		
		// Download the image data, which could take some time
		store.fetchImage(for: foto) { (result) -> Void in
			
			// The index path for the photo might have changed between the
			// time the request started and finished, so find the most
			// recent index path
			guard let fotoIndex = self.fotoDataSource.fotos.firstIndex(of: foto),
				  case let .success(image) = result else {
					  return
				  }
			let fotoIndexPath = IndexPath(item: fotoIndex, section: 0)
		
			// When the request finishes, find the current cell for this photo
			if let cell = self.collectionView.cellForItem(at: fotoIndexPath)
				as? FotoCollectionViewCell {
				cell.update(displaying: image)
			}
		}
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		switch segue.identifier {
		case "showFoto":
			if let selectedIndexPath =
				collectionView.indexPathsForSelectedItems?.first {
				
				let foto = fotoDataSource.fotos[selectedIndexPath.row]
				
				let destinationVC = segue.destination as! FotoInfoViewController
				destinationVC.foto = foto
				destinationVC.store = store
			}
		default:
			preconditionFailure("Unexpected segue identifier.")
		}
	}

	
	
	
}

