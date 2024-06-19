//
//  CustomTabBar.swift
//  customtabbarpsapp
//
//  Created by Иван Чернокнижников on 13.06.2024.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var activeTab: Tab
    var body: some View {
        VStack(spacing :0 ) {
            HStack(spacing :0 ) {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Image(tab.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            print("ONTAP")
                            withAnimation(.interactiveSpring(response: 0.5,dampingFraction: 0.7,blendDuration: 0.7)) {
                                 activeTab = tab
                            }
                        }
                        .offset(y: offset(tab))
                        .frame(width: 30,height: 30)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.top,12)
            .padding(.bottom, 20)
        }
        .padding(.bottom,safeArea.bottom == 0 ? 15 : safeArea.bottom)
        .background(content: {
            ZStack {
                
                TabBarTopCurve()
                    .stroke(.white,lineWidth: 0.5)
                    .blur(radius: 0.5)
                    .padding(.horizontal,-10)
                TabBarTopCurve()
                    .fill(Color("BG").opacity(0.5).gradient )
            }
        })
        .overlay(content: {
            GeometryReader { proxy in
                let rect = proxy.frame(in: .global)
                let width = rect.width
                let maxedWidth = width * 5
                let height = rect.height
                Circle()
                    .fill(.clear)
                    .frame(width: maxedWidth,height: maxedWidth)
                  
                    .background(alignment: .top) {
                        Rectangle()
                            .fill(.linearGradient(colors: [
                                Color(.systemGray5),
                                Color("BG"),
                                Color("BG"),

                            ], startPoint: .top, endPoint: .bottom))
                            .frame(width: width,height: height)
                            // Masking in native big circle
                            .mask(alignment: .top) {
                                Circle()
                                    .frame(width: maxedWidth,height: maxedWidth,alignment: .top)
                            }
                    }
                    .overlay(content: {
                        Circle()
                            .stroke(.white,lineWidth: 0.5)
                            .blur(radius: 0.5)
                    })
                    .frame(width: width)
                    // Indicator
                    .background(content: {
                        Rectangle()
                            .fill(.white)
                            .frame(width: 45, height: 4)
                            // Glow
                            .glow(.white.opacity(0.5), radius: 50)
                            .glow(.blue.opacity(0.5), radius: 50)
                            .offset(y: -1.5)
                            .offset(y: -maxedWidth / 2)
                            .rotationEffect(.init(degrees: calculateRotation(maxedWidth: maxedWidth / 2, actualWidth: width,true)))
                            .rotationEffect(.init(degrees: calculateRotation(maxedWidth: maxedWidth / 2, actualWidth: width)))
                    })
                    .offset(y: height / 2.1)
            }
        })
        .overlay(alignment: .bottom, content: {
            Text(activeTab.rawValue)
                .font(.system(size: 14))
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .offset(y: safeArea.bottom == 0 ? 15 : -safeArea.bottom + 12)
        })
        .preferredColorScheme(.dark)
    }
    
    /// Calculationg Rotation using Trigonomentry
    func calculateRotation(maxedWidth y :CGFloat, actualWidth: CGFloat, _ isInitial: Bool = false) -> CGFloat {
        let tabWidth = actualWidth / Tab.count
        // This is actually X
        let firstTabPositionX: CGFloat = -(actualWidth - tabWidth) / 2
        let tan = y / firstTabPositionX
        let radians = atan(tan)
        let degree = radians * 180 / .pi
        if isInitial {
            return -(degree + 90)
        }
        let x = tabWidth * activeTab.index
        let tan_ = y / x
        let radians_ = atan(tan_)
        let degree_ = radians_ * 180 / .pi
        return -(degree_ - 90)
    }
    
    /// Offset based on tab position
    func offset(_ tab: Tab) -> CGFloat {
        let totalIndices = Tab.count
        let currentIndex = tab.index
        let progress = currentIndex / totalIndices
        return progress < 0.5 ? (currentIndex * -10) : ((totalIndices - currentIndex - 1) * -10)
    }
}

#Preview {
    ContentView()
//    CustomTabBar(activeTab: .constant(Tab.play))
}


// Tab bar custom shape

struct TabBarTopCurve : Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let width = rect.width
            let height = rect.height
            
            let minWidth = width / 2
            path.move(to: .init(x: 0, y: 5))
            path.addCurve(to: .init(x: minWidth, y: -20), control1: .init(x: minWidth / 2, y: -20), control2: .init(x: minWidth, y: -20))
            
            path.addCurve(to: .init(x: width, y: 5), control1: .init(x: (minWidth + (minWidth / 2)), y: -20), control2: .init(x: width, y: 5))
            
            /// Completing Rectangle
            path.addLine(to: .init(x: width, y: height))
            path.addLine(to: .init(x: 0, y: height))
            path.closeSubpath()
        }
    }
    
    
}
