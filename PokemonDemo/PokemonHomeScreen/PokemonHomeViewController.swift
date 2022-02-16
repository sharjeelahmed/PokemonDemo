//
//  PokemonHomeViewController.swift
//  PokemonDemo
//
//  Created by Shairjeel Ahmed on 10/02/2022.
//

import UIKit
import FloatingPanel

class PokemonHomeViewController: UIViewController {
	
	class func instantiateFromStoryboard() -> PokemonHomeViewController {
		return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: self)) as! PokemonHomeViewController
	}
	
	@IBOutlet weak var userImageView:UIImageView?
	var fpc: FloatingPanelController!
	var cachePokemon:CachePokemon!
	var selectedPokemonListViewController:SelectedPokemonListViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.cachePokemon = CachePokemon.init()

		self.setupFPC()
		self.getUserImage()
		let alert = UIAlertController(title: "Warning", message: "Images of pokemon are showing ramdomly. kindly just check the pokemon name for funtionality", preferredStyle: UIAlertController.Style.alert)
		alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
			 }))
		self.present(alert, animated: true, completion: nil)
		
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.fpc.show()
		selectedPokemonListViewController?.reloadData()
	}
	
	private func setupFPC() {
		// Initialize a `FloatingPanelController` object.
		fpc = FloatingPanelController()
		fpc.delegate = self

		// Set a content view controller.
		let contentVC = SelectedPokemonListViewController.instantiateFromStoryboard()
		self.selectedPokemonListViewController = contentVC
		let cachePokemon = CachePokemon.init()
		let viewModel = SelectedPokemonListViewModel.init(cachePokemon: cachePokemon, selectedPokemonViewProtocol: contentVC)
		contentVC.viewModel = viewModel
		fpc.set(contentViewController: contentVC)
		
		// Add and show the views managed by the `FloatingPanelController` object to self.view.
		fpc.addPanel(toParent: self)
		fpc.isRemovalInteractionEnabled = true
		fpc.surfaceView.layer.cornerRadius = 40
		fpc.hide()
	}
	
	func getUserImage(){
		if let image = cachePokemon.getImageFromUserDefault(){
			self.userImageView?.image = image
		}
	}
	
	@IBAction func btnTapped(_ sender: Any) {
		let imagePickerController = UIImagePickerController()
		imagePickerController.allowsEditing = false //If you want edit option set "true"
		imagePickerController.sourceType = .photoLibrary
		imagePickerController.delegate = self
		present(imagePickerController, animated: true, completion: nil)
		
	}
	
}

extension PokemonHomeViewController: FloatingPanelControllerDelegate {
	func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
		PokemonPanelLayout()
	}
}

extension PokemonHomeViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
		userImageView?.image  = tempImage
		cachePokemon.saveImageInUserDefault(img: tempImage)
		self.dismiss(animated: true, completion: nil)
	}

	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		dismiss(animated: true, completion: nil)
	}
}

