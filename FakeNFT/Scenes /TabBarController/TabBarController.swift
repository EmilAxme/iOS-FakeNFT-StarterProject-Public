import UIKit

final class TabBarController: UITabBarController {
    
    var servicesAssembly: ServicesAssembly!
    
    private let catalogTabBarItem = UITabBarItem(
        title: NSLocalizedString("Tab.catalog", comment: ""),
        image: UIImage(systemName: "square.stack.3d.up.fill"),
        tag: 0
    )
    
    private let cartTabBarItem = UITabBarItem(
        title: NSLocalizedString("Tab.cart", comment: ""),
        image: UIImage(resource: .cartIcon).withRenderingMode(.alwaysOriginal),
        selectedImage: UIImage(resource: .cartIcon).withRenderingMode(.alwaysTemplate)
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let catalogController = TestCatalogViewController(
            servicesAssembly: servicesAssembly
        )
        
        let cartViewController = CartViewController()
        let cartRouter = CartRouter(viewController: cartViewController)
        let cartPresenter = CartPresenter(view: cartViewController, router: cartRouter)
        cartViewController.presenter = cartPresenter
        
        let cartNavController = UINavigationController(rootViewController: cartViewController)
        
        catalogController.tabBarItem = catalogTabBarItem
        cartViewController.tabBarItem = cartTabBarItem
        
        viewControllers = [catalogController, cartNavController]
        
        view.backgroundColor = .systemBackground
    }
}
