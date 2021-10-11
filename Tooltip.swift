import Foundation

struct Tooltip {

	let title : String
	let subtitle : String
	let dismissTitle : String
	let arrowDirection: TooltipBubbleArrowDirection
	let position: TooltipBubblePosition

	enum TooltipBubblePosition {
		case up
		case center
		case bottom
	}

	enum TooltipBubbleArrowDirection {
		case none
		case up
		case down
		case center
		case tab1
		case tab2
		case tab3
		case tab4
		case tab5
		case upTab4
	}
}



