
import UIKit

class ArrowView : UIView {

	private let color: UIColor

	init(frame: CGRect, color: UIColor = .white) {
		self.color = color
		super.init(frame: frame)
		backgroundColor = .clear
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func draw(_ rect: CGRect) {

		guard let context = UIGraphicsGetCurrentContext() else { return }

		context.beginPath()
		context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
		context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
		context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.minY))
		context.closePath()

		context.setFillColor(color.cgColor)
		context.fillPath()
	}
}
