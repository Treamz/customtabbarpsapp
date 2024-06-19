//
//  hime.swift
//  customtabbarpsapp
//
//  Created by Иван Чернокнижников on 13.06.2024.
//

import SwiftUI

struct HomeView: View {
    
    @State private var activeTab = Tab.play
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack {
                    ForEach(1..<50) {_ in
                       Text("Test Data")
                    }
                }
            }
            CustomTabBar(activeTab: $activeTab)
            
        }
        .ignoresSafeArea(.all,edges: .bottom )
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Rectangle()
            .fill(Color("BG"))
            .ignoresSafeArea()
        )
    }
}

#Preview {
    HomeView()
}
