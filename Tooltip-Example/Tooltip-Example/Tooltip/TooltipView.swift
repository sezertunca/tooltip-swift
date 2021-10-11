import UIKit

class TooltipView: UIView {

	private let dimmingViewColor = UIColor.black
	private let dimmingViewFadedOutAlpha: CGFloat = 0.0
	private let dimmingViewFadedInAlpha: CGFloat = 0.8
	private let dimmingAnimationDuration = 0.6

	let dimmingView: UIView = {

		let view = UIView()
		view.isUserInteractionEnabled = true
		return view
	}()

	var topPadding: CGFloat = 0
	var bottomPadding: CGFloat = 0

	var bubbles = [TooltipBubbleView]() {

		didSet {

			// First popup should be visible
			if bubbles.count == 1 {
				bubbles.first?.alpha = 1
			}
		}
	}

	func layoutDimmingView(with size: CGSize) {

        dimmingView.backgroundColor = dimmingViewColor
        dimmingView.alpha = dimmingViewFadedOutAlpha

		addSubview(dimmingView)

		dimmingView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			dimmingView.topAnchor.constraint(equalTo: topAnchor),
			dimmingView.leftAnchor.constraint(equalTo: leftAnchor),
			dimmingView.bottomAnchor.constraint(equalTo: bottomAnchor),
			dimmingView.rightAnchor.constraint(equalTo: rightAnchor)
		])
    }

	func displayDimmingView() {

		UIView.animate(withDuration: dimmingAnimationDuration, animations: {

			self.dimmingView.alpha = self.dimmingViewFadedInAlpha
        })
	}

	func layoutSubviewsForOrientationChange(size: CGSize) {

		dimmingView.frame = .init(x: 0, y: topPadding, width: size.width, height: size.height - (topPadding + bottomPadding) )

		layoutIfNeeded()
	}

	func displayNextPopup(index: Int) {

		bubbles[index - 1].alpha = 0

        UIView.animate(withDuration: dimmingAnimationDuration, animations: {

            self.bubbles[index].alpha = 1
        })
	}

	func position(_ popup: TooltipBubbleView) {

		// Assing a tag number so we can determine if should display the next popup or dismiss the Hints
		popup.dismissButton.tag = bubbles.count

		bubbles.append(popup)

		addSubview(popup)

		let screenWidth = UIScreen.main.bounds.size.width

		let popupWidth: CGFloat = screenWidth * 0.9


		popup.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			popup.widthAnchor.constraint(equalToConstant: popupWidth),
			popup.heightAnchor.constraint(equalToConstant: 199),
		])

		switch popup.position {

		case .top:

			NSLayoutConstraint.activate([
				popup.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: popup.verticalPadding + 40),
				popup.centerXAnchor.constraint(equalTo: centerXAnchor),
			])

		case .bottom:

			NSLayoutConstraint.activate([
				popup.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -popup.verticalPadding),
				popup.centerXAnchor.constraint(equalTo: centerXAnchor),
			])

		case .center:

			NSLayoutConstraint.activate([
				popup.centerYAnchor.constraint(equalTo: centerYAnchor),
				popup.centerXAnchor.constraint(equalTo: centerXAnchor),
				popup.widthAnchor.constraint(equalToConstant: screenWidth * 0.9),
				popup.heightAnchor.constraint(equalToConstant: screenWidth),
			])
		}
	}
}

