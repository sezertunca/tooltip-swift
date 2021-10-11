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

//    private let arrowView: ArrowView = {
//		let view = ArrowView(frame: .init(x: 0, y: 0, width: 35, height: 17))
//        return view
//    }()

	private let arrowView: UIImageView = {
		let view = UIImageView()
		view.image = UIImage(named: "popupArrow")?.withRenderingMode(.alwaysTemplate)
		view.tintColor = .white
		return view
	}()

	let infoView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
		view.backgroundColor = .white
		view.clipsToBounds = true
		view.layer.cornerRadius = 12
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
		button.backgroundColor = .orange
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

		infoView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			infoView.topAnchor.constraint(equalTo: topAnchor, constant: 17),
			infoView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
			infoView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
			infoView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
		])

        infoView.addSubview(titleLabel)
		infoView.addSubview(dismissButton)
		infoView.addSubview(descriptionLabel)

		titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)


		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 25),
			titleLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 10),
			titleLabel.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: -10),
		])

		descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
			descriptionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: padding),
			descriptionLabel.bottomAnchor.constraint(equalTo: dismissButton.topAnchor, constant: -padding),
			descriptionLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: -padding),
		])

		dismissButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			dismissButton.widthAnchor.constraint(equalToConstant: 100),
			dismissButton.heightAnchor.constraint(equalToConstant: 40),
			dismissButton.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -padding),
			dismissButton.centerXAnchor.constraint(equalTo: centerXAnchor),
		])

		arrowView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			arrowView.widthAnchor.constraint(equalToConstant: 35),
			arrowView.heightAnchor.constraint(equalToConstant: 17)
		])

		addArrow()
	}

    private func addArrow() {

		if arrowDirection == .none {
			return
		}

		addSubview(arrowView)

		arrowView.translatesAutoresizingMaskIntoConstraints = false

		switch arrowDirection {
		
		case .up:

			arrowView.transform = arrowView.transform.rotated(by: CGFloat(Double.pi / 2))

			NSLayoutConstraint.activate([
				arrowView.bottomAnchor.constraint(equalTo: infoView.topAnchor),
				arrowView.centerXAnchor.constraint(equalTo: centerXAnchor),
			])

		case .down, .center:

			NSLayoutConstraint.activate([
				arrowView.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -2),
				arrowView.centerXAnchor.constraint(equalTo: centerXAnchor),
			])

		case .tab1:

			NSLayoutConstraint.activate([
				arrowView.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -2),
				arrowView.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 5),
			])

		case .tab2:

			NSLayoutConstraint.activate([
				arrowView.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -2),
				arrowView.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: arrowOffset),
			])
		
		case .tab4:

			NSLayoutConstraint.activate([
				arrowView.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -2),
				arrowView.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: arrowOffset),
			])
			
		case .tab5:
			NSLayoutConstraint.activate([
				arrowView.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -2),
				arrowView.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: -arrowOffset),
			])

		case .upTab4:

			arrowView.transform = arrowView.transform.rotated(by: .pi)
			NSLayoutConstraint.activate([
				arrowView.bottomAnchor.constraint(equalTo: infoView.topAnchor, constant: -2),
				arrowView.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: arrowOffset),
			])
			
			
		default: break
        }
    }
}
