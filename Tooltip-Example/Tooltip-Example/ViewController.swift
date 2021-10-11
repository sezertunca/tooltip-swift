//
//  ViewController.swift
//  Tooltip-Example
//
//  Created by Sezer Tunca on 11/10/2021.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		let tooltipShown = UserDefaults.standard.bool(forKey: "hasTooltipShown")

//		if tooltipShown {
//			return
//		}

		let intro = Tooltip(title: "Welcome",
							subtitle: "Use these 2 quick options to find what to watch.",
							dismissTitle: "OK",
							arrowDirection: .none,
							position: .bottom)

		let home = Tooltip(title: "Home",
						   subtitle: "See the curated watchlists including what is trending on streaming platforms",
						   dismissTitle: "OK",
						   arrowDirection: .tab2,
						   position: .bottom)

		let search = Tooltip(title: "Search",
							 subtitle: "Browse, discover popular movies and TV shows, genres, watch latest trailers.",
							 dismissTitle: "OK",
							 arrowDirection: .tab2,
							 position: .bottom)


		let test1 = Tooltip(title: "Search",
							 subtitle: "Browse, discover popular movies and TV shows, genres, watch latest trailers.",
							 dismissTitle: "OK",
							 arrowDirection: .tab3,
							position: .top)

		let test2 = Tooltip(title: "Search",
							 subtitle: "Browse, discover popular movies and TV shows, genres, watch latest trailers.",
							 dismissTitle: "OK",
							 arrowDirection: .none,
							position: .center)


		let viewController = TooltipViewController(tooltips: [intro, home, search, test1, test2])
		viewController.delegate = self
		viewController.modalPresentationStyle = .overCurrentContext
		navigationController?.present(viewController, animated: true)
	}
}

extension ViewController: TooltipDelegate {
	func didFinishDisplayingTooltips() {
		UserDefaults.standard.set(true, forKey: "hasTooltipShown")
	}
}

