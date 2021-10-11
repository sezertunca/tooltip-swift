# tooltip-swift
A basic package to showcase features of an app

# How to install



# How to use

```
		let intro = Tooltip(title: "Welcome",
							subtitle: "Here is a quick tutorial to show you how to use the the app",
							dismissTitle: "OK",
							arrowDirection: .none,
							position: .bottom)
              
    let home = Tooltip(title: "Home",
						   subtitle: "Find curated watchlists under this tab",
						   dismissTitle: "OK",
						   arrowDirection: .tab1,
						   position: .bottom)


		let search = Tooltip(title: "Search",
							 subtitle: "To browse and discover use this tab",
							 dismissTitle: "OK",
							 arrowDirection: .tab2,
							 position: .bottom)

		let viewController = TooltipViewController(tooltips: [intro, home, search])

		viewController.delegate = delegate

```

You can use delegate to save to LocalStorage when tutorial has finished to only show once to new users
