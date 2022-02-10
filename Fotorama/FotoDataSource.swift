//
//  FotoDataSource.swift
//  Fotorama
//
//  Created by Michael Worden on 2/8/22.
//

import UIKit

class FotoDataSource: NSObject, UICollectionViewDataSource {

	var fotos = [Foto]()
	
	func collectionView(_ collectionView: UICollectionView,
						numberOfItemsInSection section: Int) -> Int {
		return fotos.count
	}
	
	func collectionView(_ collectionView: UICollectionView,
						cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let identifier = "FotoCollectionViewCell"
		let cell =
		collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
										   for: indexPath)as! FotoCollectionViewCell
		
		
		return cell
	}



}


