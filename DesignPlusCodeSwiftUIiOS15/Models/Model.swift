//
//  Model.swift
//  DesignPlusCodeSwiftUIiOS15
//
//  Created by Abanoub Ashraf on 24/02/2023.
//

import SwiftUI
import Combine

///
/// A type of object with a publisher that emits before the object has changed
///
class Model: ObservableObject {
    ///
    /// published to be used from other places
    ///
    @Published var showDetail: Bool = false
}
