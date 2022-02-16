//
//  DismissiblePanelLayout.swift
//  QavaShop
//
//  Created by Akber Sayani on 15/09/2021.
//  Copyright © 2021 Shairjeel Ahmed. All rights reserved.
//

import Foundation
import FloatingPanel

class PokemonPanelLayout: FloatingPanelLayout {
	let position: FloatingPanelPosition = .bottom
	let initialState: FloatingPanelState = .half
	var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
		return [
			.full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
			.half: FloatingPanelLayoutAnchor(fractionalInset: 0.7, edge: .bottom, referenceGuide: .safeArea),
			.tip: FloatingPanelLayoutAnchor(absoluteInset: 44.0, edge: .bottom, referenceGuide: .safeArea),
		]
	}
}
