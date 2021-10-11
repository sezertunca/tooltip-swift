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
		dimmingView.fillSuperView()
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

		popup.infoView.rounded(corners: [.bottomLeft, .bottomRight, .topLeft, .topRight], radius: 12)

		addSubview(popup)

		let screenWidth = UIScreen.main.bounds.size.width

		let popupWidth: CGFloat = screenWidth * 0.9

		let horizontalPadding: CGFloat = 25

		popup.constrainWidth(constant: popupWidth)
		popup.constrainHeight(constant: 199)

		switch popup.position {

		case .up:
			popup.anchor(top: safeAreaLayoutGuide.topAnchor,
						 left: nil,
						 bottom: nil,
						 right: nil,
						 padding: .init(top: popup.verticalPadding + 40, left: horizontalPadding, bottom: 0, right: horizontalPadding))

			popup.anchorCenterXToSuperview()

		case .bottom:
			popup.anchor(top: nil,
						 left: nil,
						 bottom: safeAreaLayoutGuide.bottomAnchor,
						 right: nil,
						 padding: .init(top: 0, left: horizontalPadding, bottom: popup.verticalPadding, right: horizontalPadding))

			popup.anchorCenterXToSuperview()

		case .center:

			popup.centerInSuperView(size: .init(width: screenWidth.percentage(90), height: screenWidth))
		}
	}
}

