//
//  SelectedPokemonListViewController.swift
//  PokemonDemo
//
//  Created by Shairjeel Ahmed on 10/02/2022.
//

import UIKit
import Lightbox
import ViewAnimator

protocol SelectedPokemonViewProtocol:AnyObject{
	func reloadSelectedPokemonView()
}

class SelectedPokemonListViewController: UIViewController {
	
	class func instantiateFromStoryboard() -> SelectedPokemonListViewController {
		return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: self)) as! SelectedPokemonListViewController
	}
	
	@IBOutlet weak var searchTextField:UITextField!
	@IBOutlet weak var cancelButton:UIButton!
	@IBOutlet weak var collectionView:UICollectionView!

	var selectedPokemons:[Pokemon] = [Pokemon]()
	var searchedPokemon:[Pokemon] = [Pokemon]()
	//var cachePokemon:CachePokemon!
	var viewModel:SelectedPokemonListViewModel?{
		didSet{
			//self.reloadData()
		}
	}
	private let zoomAnimations = [AnimationType.zoom(scale: 0.5)]
	//var isSearching:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
		self.addObserver()
		self.searchTextField.delegate = self
		//cachePokemon = CachePokemon.init()
		/*self.viewModel?.queryDidChange = { [weak self] (quering) in
			self?.reloadData()
		}*/
		
		/*viewModel?.locationDidChange = { [unowned self] (locations) in
			self.tableView.reloadData()
		}*/
	
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		//self.loadPokemons()
		self.viewModel?.pokemonsDidChange = { [weak self] (pokemons) in
			self?.reloadData()
		}
	}
	
	/*func loadPokemons(){
		self.selectedPokemons.removeAll()
		let pokemons = cachePokemon.getPokemons()
		let pokemon = pokemonsName.map{Pokemon.init(object: ["name":$0]) }
		self.selectedPokemons.append(contentsOf: pokemons)
		self.collectionView.reloadData()
	}*/
	
	
	
	func addObserver(){
		self.searchTextField.addTarget(self, action: #selector(SelectedPokemonListViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
	}
	
	@objc func textFieldDidChange(_ textField: UITextField) {
		if textField.text == ""{
			//self.cancelButton.isHidden = true
			//self.isSearching = false
			//self.reloadData()
			return
		}else{
			self.cancelButton.isHidden = false
		}
	}
	
	func reloadData(){
		self.collectionView.reloadData()
	}
	
	@IBAction func searchCloseBtnPressed(_ sender:UIButton){
		self.searchTextField.resignFirstResponder()
		self.searchTextField.text = nil
		self.viewModel?.query = nil
		//self.reloadData()
	}
	
	func setupLightBox(){
		var ligthBoxImageArray:[LightboxImage] = [LightboxImage]()
		//let array =  isSearching == false ? self.selectedPokemons : self.searchedPokemon
		let array = self.viewModel?.pokemons

		for obj in array ?? []{
			let random = Int.random(in: 0...9)
			if let image = UIImage.init(named: "pokemon\(random)"){
				let lightBox = LightboxImage.init(image: image, text: obj.name ?? "", videoURL: nil)
				ligthBoxImageArray.append(lightBox)
			}
		}
		
		let controller = LightboxController(images: ligthBoxImageArray)

		// Set delegates.
		//controller.pageDelegate = self
		//controller.dismissalDelegate = self

		// Use dynamic background.
		controller.dynamicBackground = true

		// Present your controller.
		present(controller, animated: true, completion: nil)
	}
	
	

}

extension SelectedPokemonListViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		//return isSearching == false ? self.selectedPokemons.count : self.searchedPokemon.count
		guard let viewModel = viewModel else{
			return 0
		}
		
		return viewModel.numberOfRows
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SelectedPokemonCollectionViewCell.self), for: indexPath) as!  SelectedPokemonCollectionViewCell
		let pokemon =  self.viewModel?.viewModel(for: indexPath.row)
		cell.setData(pokemonViewModel: pokemon!)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		var collectionViewSize = collectionView.frame.size
		let width = (collectionViewSize.width - CGFloat(10))/2
		collectionViewSize.width = width
		collectionViewSize.height =  164
		return collectionViewSize
		
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		self.setupLightBox()
	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		cell.animate(animations: zoomAnimations)
	}
}

extension SelectedPokemonListViewController:UITextFieldDelegate{
	func textFieldDidEndEditing(_ textField: UITextField) {
		//self.viewModel?.queryDidChange = false
		
		//isSearching = false
	}
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		//self.viewModel?.queryDidChange = true
		//isSearching = true
	}
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		if string.count == 0 && range.length > 0 {
			let text = textField.text?.dropLast() ?? ""
			self.viewModel?.query = String(text)
			//let filteredArray = self.selectedPokemons.filter { $0.name!.localizedCaseInsensitiveContains(text)}
			//self.searchedPokemon = filteredArray
			//self.reloadData()
		}else{
			let text = (textField.text ?? "") + string
			self.viewModel?.query = text
				//let filteredArray = self.selectedPokemons.filter { $0.name!.localizedCaseInsensitiveContains(text)}
				//self.searchedPokemon = filteredArray
				//self.reloadData()
		}
		return true
	}
}

extension SelectedPokemonListViewController:SelectedPokemonViewProtocol{
	func reloadSelectedPokemonView() {
		self.reloadData()
	}
}
