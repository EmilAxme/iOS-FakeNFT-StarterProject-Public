import UIKit

final class TabBarController: UITabBarController {
    
    var servicesAssembly: ServicesAssembly!
    
    private enum Strings {
        static let catalogTitle = "Tab.catalog".localized
        static let cartTitle = "Tab.cart".localized
    }
    
    private lazy var catalogTabBarItem: UITabBarItem = {
        UITabBarItem(
            title: Strings.catalogTitle,
            image: UIImage(systemName: "square.stack.3d.up.fill"),
            tag: 0
        )
    }()
    
    private lazy var cartTabBarItem: UITabBarItem = {
        UITabBarItem(
            title: Strings.cartTitle,
            image: UIImage(resource: .cartIcon).withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(resource: .cartIcon).withRenderingMode(.alwaysTemplate)
        )
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        view.backgroundColor = .systemBackground
    }
    
    private func setupTabs() {
        let catalogController = TestCatalogViewController(servicesAssembly: servicesAssembly)
        catalogController.tabBarItem = catalogTabBarItem
        
        let cartViewController = CartViewController()
        let cartRouter = CartRouter(viewController: cartViewController)
        let cartPresenter = CartPresenter(view: cartViewController, router: cartRouter)
        cartViewController.presenter = cartPresenter
        
        let cartNavController = UINavigationController(rootViewController: cartViewController)
        cartNavController.tabBarItem = cartTabBarItem
        
        viewControllers = [catalogController, cartNavController]
    }
}
