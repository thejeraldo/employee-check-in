//
//  AppDelegate.swift
//  employee-check-in
//
//  Created by Jerald Allen Abille on 10/30/24.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Migration: Create company and set employees
        Task {
            let dataManager = DataManager.shared
            let context = dataManager.persistentContainer.newBackgroundContext()
            try await context.perform {
                context.automaticallyMergesChangesFromParent = true
                let context = dataManager.persistentContainer.viewContext
                let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
                let results = try context.fetch(fetchRequest)
                if results.isEmpty {
                    let item = Company(context: context)
                    item.name = "Dunder Mifflin"
                    if context.hasChanges {
                        try context.save()
                    }
                    
                    let context = dataManager.persistentContainer.viewContext
                    let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
                    let employees = try context.fetch(fetchRequest)
                    item.employees = NSOrderedSet(array: employees)
                }
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

