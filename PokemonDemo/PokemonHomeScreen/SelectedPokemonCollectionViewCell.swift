//
//  SelectedPokemonCollectionViewCell.swift
//  PokemonDemo
//
//  Created by Shairjeel Ahmed on 10/02/2022.
//

import UIKit

class SelectedPokemonCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var titleLabel:UILabel!
	@IBOutlet weak var pokemonImageView:UIImageView!
	
	override func prepareForReuse() {
		super.prepareForReuse()
		self.pokemonImageView.image = nil
	}
	
	func setData(pokemonViewModel:PokemonListViewModel){
		self.titleLabel.text = pokemonViewModel.Name
		if let image = UIImage.init(named:  pokemonViewModel.ImageName){
			self.pokemonImageView.image = image
		}
	}
}

