//
//  ContentView.swift
//  PhotoLib
//
//  Created by Erie on 2025/08/30.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var serviceFactory: ServiceFactory
        
    var body: some View {
        SearchPhotoView(dataSource: serviceFactory.searchDataSource)
    }
}

#Preview {
    ContentView()
        .environmentObject(MockServiceFactory())
}
