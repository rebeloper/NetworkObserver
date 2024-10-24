//
//  NetworkObserver.swift
//  
//
//  Created by Alex Nagy on 24.10.2024.
//

import SwiftUI
import Network

@Observable
public class NetworkObserver: @unchecked Sendable {
    private let networkMonitor = NWPathMonitor()
    private var workerQueue = DispatchQueue(label: "NetworkObserver")
    public var isConnected = false
    
    public init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        networkMonitor.start(queue: workerQueue)
    }
}

public extension EnvironmentValues {
    @Entry var network = NetworkObserver()
}

public extension View {
    func listenToNetworkChanges() -> some View {
        environment(\.network, .init())
    }
}

