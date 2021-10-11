import UIKit

class TooltipBubbleView: UIView {

	let arrowDirection: Tooltip.TooltipBubbleArrowDirection
	let position: Tooltip.TooltipBubblePosition
	private let arrowOffset: CGFloat
	let verticalPadding: CGFloat

	init(tooltip: Tooltip, arrowOffset: CGFloat, bottomPadding: CGFloat) {

		titleLabel.text = tooltip.title
		titleLabel.textAlignment = .center

		descriptionLabel.text = tooltip.subtitle
		descriptionLabel.textAlignment = .center

		dismissButton.setTitle(tooltip.dismissTitle, for: .normal)

		self.position = tooltip.position
		self.arrowDirection = tooltip.arrowDirection
		self.arrowOffset = arrowOffset
		self.verticalPadding = bottomPadding

		super.init(frame: .zero)

		alpha = 0

		layout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let arrowImageView: UIImageView = {
		let view = UIImageView()
		view.image = UIImage(named: "popupArrow")?.withRenderingMode(.alwaysTemplate)
		view.tintColor = .white
        view.constrainWidth(constant: 35)
        view.constrainHeight(constant: 17)
        return view
    }()

	let infoView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
		view.backgroundColor = .white
        return view
    }()

	private let titleLabel: UILabel = {
        let label = UILabel()
		label.textColor = .black
		label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()

	let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
		label.textColor = .darkGray
		label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()

	let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
		button.backgroundColor = .wantedOrange
		button.setTitleColor(.black, for: .normal)
        return button
    }()

	private func setupAccessibility(label: String) {

		infoView.isAccessibilityElement = true
		infoView.accessibilityLabel = label
		accessibilityElements = [infoView, titleLabel, descriptionLabel, dismissButton]
		isAccessibilityElement = false
	}

	private func layout() {

		let padding: CGFloat = 15

        addSubview(infoView)

        infoView.fillSuperView(padding: .init(top: 17, left: 0, bottom: 0, right: 0))

        infoView.addSubview(titleLabel)
		infoView.addSubview(dismissButton)
		infoView.addSubview(descriptionLabel)

		titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)

        titleLabel.anchor(top: infoView.topAnchor,
						  left: infoView.leftAnchor,
						  bottom: nil,
						  right: infoView.rightAnchor,
						  padding: .init(top: 25, left: 10, bottom: 0, right: 10))

        descriptionLabel.anchor(top: titleLabel.bottomAnchor,
								left: titleLabel.leftAnchor,
								bottom: dismissButton.topAnchor,
								right: titleLabel.rightAnchor,
								padding: .init(top: 0, left: padding, bottom: 0, right: padding))

		dismissButton.anchor(top: nil,
							 left: nil,
							 bottom: infoView.bottomAnchor,
							 right: nil,
							 padding: .init(top: 0, left: 0, bottom: padding, right: 0))

        dismissButton.constrainWidth(constant: 100)
        dismissButton.constrainHeight(constant: 40)
        dismissButton.anchorCenterXToSuperview()

		addArrow()
	}

    private func addArrow() {

		if arrowDirection == .none {
			return
		}

		addSubview(arrowImageView)

		switch arrowDirection {
		
		case .up:

			arrowImageView.transform = arrowImageView.transform.rotated(by: .pi)
			arrowImageView.anchor(top: nil, left: nil, bottom: infoView.topAnchor, right: nil)
			arrowImageView.anchorCenterXToSuperview()
      
		case .down, .center:

            arrowImageView.anchor(top: infoView.bottomAnchor,
								  left: nil,
								  bottom: nil,
								  right: nil,
								  padding: .init(top: -2, left: arrowOffset, bottom: 0, right: 0))

			arrowImageView.anchorCenterXToSuperview()

		case .tab1:

			arrowImageView.anchor(top: infoView.bottomAnchor,
								  left: infoView.leftAnchor,
								  bottom: nil,
								  right: nil,
								  padding: .init(top: -2, left: 5, bottom: 0, right: 0))

		case .tab2:
			
			arrowImageView.anchor(top: infoView.bottomAnchor,
								  left: infoView.leftAnchor,
								  bottom: nil,
								  right: nil,
								  padding: .init(top: -2, left: arrowOffset, bottom: 0, right: 0))
			
		
		case .tab4:
			
			arrowImageView.anchor(top: infoView.bottomAnchor,
								  left: nil,
								  bottom: nil,
								  right: infoView.rightAnchor,
								  padding: .init(top: -2, left: 0, bottom: 0, right: arrowOffset))
			
		case .tab5:
		
		arrowImageView.anchor(top: infoView.bottomAnchor,
							  left: nil,
							  bottom: nil,
							  right: infoView.rightAnchor,
							  padding: .init(top: -2, left: 0, bottom: 0, right: arrowOffset))


		case .upTab4:

			arrowImageView.transform = arrowImageView.transform.rotated(by: .pi)
			arrowImageView.anchor(top: nil,
								  left: nil,
								  bottom: infoView.topAnchor,
								  right: infoView.rightAnchor,
								  padding: .init(top: -2, left: 0, bottom: 0, right: arrowOffset))
			
			
		default: break
        }
    }
}
