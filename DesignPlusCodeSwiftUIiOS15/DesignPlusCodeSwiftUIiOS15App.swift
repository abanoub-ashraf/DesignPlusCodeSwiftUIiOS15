//
//  DesignPlusCodeSwiftUIiOS15App.swift
//  DesignPlusCodeSwiftUIiOS15
//
//  Created by Abanoub Ashraf on 19/11/2022.
//

import SwiftUI

@main
struct DesignPlusCodeSwiftUIiOS15App: App {
    ///
    /// the observable object model class that we have
    ///
    @StateObject var model = Model()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                ///
                /// - pass the model above to the whole app through this parent view
                /// - now each child view will need to have this model defined as an environment object variable
                ///
                .environmentObject(model)
        }
    }
}
