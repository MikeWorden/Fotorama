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
		
		store.fetchInterestingPhotos()
	}
	
	


}

