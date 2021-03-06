//
//  AppDelegate.swift
//  TBMtimeProject
//
//  Created by 田彬彬 on 2020/12/22.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        configRootTabbar()
        
        return true
    }
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "TBMtimeProject")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}


extension AppDelegate {
    
    /// tabbar 设置
    func configRootTabbar() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        
        /// 1、 首页
//        let navOne = UINavigationController(rootViewController: MNFActorDetailVC())
//        navOne.tabBarItem.title = "首页"
//
//        /// 2、影人
//        let navTwo = UINavigationController(rootViewController: MNFMovieDetailVC())
//        navTwo.tabBarItem.title = "影人"
        
        let vc = ViewController()
        

        let tabbar = UITabBarController()
        tabbar.viewControllers = [vc]
        
        
        self.window?.rootViewController = tabbar
        self.window?.makeKeyAndVisible()
    }
}
