import UIKit

class TooltipViewController: UIViewController {

	weak var delegate: TooltipDelegate?
	private let tooltips: [Tooltip]

	init(tooltips: [Tooltip]) {

		self.tooltips = tooltips
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		mainView?.layoutDimmingView(with: UIScreen.main.bounds.size)

		tooltips.forEach { (hint) in
			createAndPositionHint(hint: hint)
		}
	}

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
		mainView?.displayDimmingView()
    }

	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		mainView?.layoutSubviewsForOrientationChange(size: size)
	}

	var mainView: TooltipView? {
		return self.view as? TooltipView
    }

    override func loadView() {
		view = TooltipView(frame: UIScreen.main.bounds)
		mainView?.dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDimmingViewTap)))
    }

	private func createAndPositionHint(hint: Tooltip) {

		let bottomPadding: CGFloat = 25
		var arrowOffset: CGFloat = 0
		let screenSize = UIScreen.main.bounds

		switch hint.arrowDirection {
		case .tab1:
			let offsetPartBasedOnScreenSize = screenSize.width * 0.80
			arrowOffset = offsetPartBasedOnScreenSize / CGFloat(6)
		case .tab2:
			let offsetPartBasedOnScreenSize = screenSize.width * 0.85
			arrowOffset = offsetPartBasedOnScreenSize / CGFloat(4)
		case .tab5:
			let offsetPartBasedOnScreenSize = screenSize.width * 0.85
			arrowOffset = offsetPartBasedOnScreenSize / CGFloat(4)
		default: break
		}

		let bottom = UIDevice.current.hasNotch ? bottomPadding : 26
		let popup = TooltipBubbleView(tooltip: hint, arrowOffset: arrowOffset, bottomPadding: bottom)
        popup.dismissButton.addTarget(self, action: #selector(handleOkOrDismiss(_:)), for: .touchUpInside)
		mainView?.position(popup)
    }
	
	@objc
	private func handleDimmingViewTap() {
		nextBubble()
	}

	@objc
	private func handleOkOrDismiss(_ sender: UIButton) {
		nextBubble()
	}

	var currentPopupIndex = 0

	func nextBubble() {

		currentPopupIndex += 1

		// On last popup, dismiss this entire view
		if currentPopupIndex == tooltips.count {

			delegate?.didFinishDisplayingTooltips()

			dismiss(animated: false, completion: nil)
            return
        }

		mainView?.displayNextPopup(index: currentPopupIndex)
	}
}
