//
//  PokemonListingViewController.swift
//  PokemonDemo
//
//  Created by Shairjeel Ahmed on 10/02/2022.
//

import UIKit
import SkeletonView
import UIScrollView_InfiniteScroll
import ViewAnimator


class PokemonListingViewController: UIViewController {
	
	@IBOutlet weak var tableView:UITableView?
	var pokemons:[Pokemon] = [Pokemon]()
	var pagination:PaginationModel = PaginationModel.init(object: ["":""])
	private let zoomAnimations = [AnimationType.zoom(scale: 0.9)]
	var cachePokemon:CachePokemon!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		setBackButtonTitle()
		cachePokemon = CachePokemon.init()
		self.getPokemon(nil)
		self.setupTableView()
	}
	
	func registerNib(){
		let nib = UINib.init(nibName: String(describing: PokemonListTableViewCell.self), bundle: nil)
		self.tableView?.register(nib, forCellReuseIdentifier: String(describing: PokemonListTableViewCell.self))
	}
	
	func setupTableView() {
		self.registerNib()
		self.tableView?.delegate = self
		self.tableView?.dataSource = self
		self.tableView?.allowsMultipleSelection = true
		self.tableView?.isSkeletonable = true
		self.tableView?.showAnimatedGradientSkeleton()
		self.tableView?.showSkeleton(usingColor: UIColor.lightGray, transition: .crossDissolve(0.2))
	}
	

	func MakeCellSelected(indexPath:IndexPath){
		let selectedPokemons = cachePokemon.getPokemons()
		guard selectedPokemons.count > 0 && self.pokemons.count > 0 else {
			return
		}
		let pokemon = self.pokemons[indexPath.row]
		
		if selectedPokemons.contains(pokemon) {
			self.tableView?.selectRow(at: indexPath, animated: true, scrollPosition: .none)
		}
	}
	func MakeSelectionOfCachePokemon(){
		/*let selectedPokemon = CachePokemon.getPokemons()
		for pokemon in selectedPokemon{
			if let index = self.pokemons.firstIndex(where: {$0.name == pokemon}){
				let indexPath = IndexPath.init(row: index, section: 0)
				self.tableView?.selectRow(at: indexPath, animated: true, scrollPosition: .none)
				if let tableVeiw = self.tableView{
					self.tableView(tableVeiw, didSelectRowAt: indexPath)
				}
			}
		}*/
	}
	
	func setBackButtonTitle(){
		self.navigationController?.navigationBar.tintColor = .black
		self.navigationController?.navigationBar.topItem?.backButtonTitle = "Pokemon List"
	}
	
	func getPokemon(_ completionHandler: (() -> Void)?){
		self.pagination.offset = self.pokemons.count
		self.pagination.limit = 20
		let param = ["offset":self.pagination.offset ?? 0,"limit":self.pagination.limit]
		PokemonService.getPokemonList(parameters:param) { (success, result) in
			if success == true{
				let array = result["results"].arrayValue
				let total =  result["count"].int ?? 0
				self.pagination.total = total
				if self.pagination.offset == 0{
					self.setupLoadMoreControl()
					let array = result["results"].arrayValue
					self.pokemons.removeAll()
					for obj in array {
						var pokemon = Pokemon.init(json: obj)
						let random = Int.random(in: 0...9)
						pokemon.imageName = "pokemon\(random)"
						self.pokemons.append(pokemon)
					}
					
					DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
						self.tableView?.stopSkeletonAnimation()
						self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.8))
						self.tableView?.reloadData()
						self.MakeSelectionOfCachePokemon()
					}
				}else{
					let pokemonCount = self.pokemons.count
					let (start, end) = (pokemonCount, array.count + pokemonCount)
					let indexPaths = (start..<end).map { return IndexPath(row: $0, section: 0) }
					
					for obj in array {
						var pokemon = Pokemon.init(json: obj)
						let random = Int.random(in: 0...9)
						pokemon.imageName = "pokemon\(random)"
						self.pokemons.append(pokemon)
					}
					
					// update collection view
					self.tableView?.performBatchUpdates({ () -> Void in
						self.tableView?.insertRows(at: indexPaths, with: .bottom)
						self.MakeSelectionOfCachePokemon()
					}, completion: { (finished) -> Void in
						completionHandler?()
					});
				}
			}
		}
	}
}

extension PokemonListingViewController:UITableViewDataSource,UITableViewDelegate{
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		self.pokemons.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonListTableViewCell", for: indexPath) as? PokemonListTableViewCell{
			cell.pokemon = self.pokemons[indexPath.row]
			cell.setData(pokemon: self.pokemons[indexPath.row])
			return cell
		}
		return UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 64
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		 let pokemon = self.pokemons[indexPath.row]
		cachePokemon.savePokemon(pokemon: pokemon)
		
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		self.MakeCellSelected(indexPath: indexPath)
		cell.animate(animations: zoomAnimations)
		
		
	}
	
	func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		let pokemon = self.pokemons[indexPath.row]
		cachePokemon.removePokemon(pokemon: pokemon)
	}
}

extension PokemonListingViewController:SkeletonTableViewDataSource{
	func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
		return String(describing: PokemonListTableViewCell.self)
	}
	
	func numSections(in collectionSkeletonView: UITableView) -> Int{
		return 1
	}
	
	func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 20
	}
	
}

extension PokemonListingViewController {
	func didScrolltoLastPage() -> Bool {
		let pokemonCount = self.pokemons.count
		let totalPokemonCount = self.pagination.total ?? 0
		if pokemonCount <= totalPokemonCount {
			return false
		}
		return true
	}
	
	func setupLoadMoreControl() {
		weak var weakSelf = self
		let activityIndicator = UIActivityIndicatorView(style: .gray)
		self.tableView?.infiniteScrollIndicatorMargin = 40.0
		self.tableView?.infiniteScrollIndicatorView = activityIndicator
		self.tableView?.infiniteScrollTriggerOffset = 100
		self.tableView?.addInfiniteScroll(handler: { collectionView in
			if weakSelf?.didScrolltoLastPage() ?? true {
				weakSelf?.tableView?.finishInfiniteScroll()
			} else {
				weakSelf?.getPokemon({
					self.tableView?.finishInfiniteScroll()
				})
			}
		})
		
		self.tableView?.setShouldShowInfiniteScrollHandler({ collectionView in
			// Only show up to last page
			let should = !(weakSelf?.didScrolltoLastPage())!
			weakSelf?.self.tableView?.infiniteScrollIndicatorView?.isHidden = !should
			return should
		})
	}
}


