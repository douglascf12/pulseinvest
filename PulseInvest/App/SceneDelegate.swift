import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window: UIWindow = UIWindow(windowScene: windowScene)
        let container: AppContainer = AppContainer()
        let coordinator: AppCoordinator = AppCoordinator(window: window, container: container)
        
        self.coordinator = coordinator
        coordinator.start()
        
        self.window = window
    }
}
