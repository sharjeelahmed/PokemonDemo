//
//  PokemonListTableViewCell.swift
//  PokemonDemo
//
//  Created by Shairjeel Ahmed on 10/02/2022.
//

import UIKit
import SkeletonView
import BEMCheckBox

class PokemonListTableViewCell: UITableViewCell {
	
	@IBOutlet weak var pokemonNameLabel:UILabel?
	@IBOutlet weak var pokemonImageView:UIImageView!
	@IBOutlet weak var checkBox: BEMCheckBox!

	var pokemon:Pokemon?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		self.pokemonImageView?.layer.cornerRadius = self.pokemonImageView.frame.height/2
		/*let unselectedImage = UIImage(named: "checkbox-blank-circle-outline")
		let selectedImage = UIImage(named: "check-circle-outline")
		self.checkBtn?.setImage(unselectedImage, for: .normal)
		self.checkBtn?.setImage(selectedImage, for: .selected)*/
		
		self.checkBox.boxType = .circle
		self.checkBox.onAnimationType = .fill
		self.checkBox.offAnimationType = .bounce
		self.checkBox.animationDuration = 0.3
		
		self.pokemonNameLabel?.showAnimatedGradientSkeleton()
		self.pokemonImageView.showAnimatedGradientSkeleton()
		self.checkBox?.showAnimatedGradientSkeleton()

    }
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		self.checkBox.setOn(selected, animated: (self.checkBox.on != selected))

		/*if isSelected{
			self.checkBtn?.isSelected = true
		}else{
			self.checkBtn?.isSelected = false
		}*/
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		self.checkBox?.setOn(false, animated: false)
		pokemonImageView.image = nil
		
	}
	
	func setData(pokemon:Pokemon){
		self.pokemonNameLabel?.text = pokemon.name?.capitalized ?? ""
		if let name = pokemon.imageName{
			if let image = UIImage.init(named: name){
				self.pokemonImageView.image = image
			}
		}
		self.pokemonNameLabel?.hideSkeleton(transition: .crossDissolve(0.9))
		self.pokemonImageView?.hideSkeleton(transition: .crossDissolve(0.9))
		self.checkBox.hideSkeleton(transition: .crossDissolve(0.9))
	}
    
}
