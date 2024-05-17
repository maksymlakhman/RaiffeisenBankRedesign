//
//  CustomTabbar.swift
//  RaiffeisenBankNeomorphStyleRedesign
//
//  Created by Макс Лахман on 09.05.2024.
//

import SwiftUI

struct RootTabBar: View {
    @State private var present : Bool = false
    private let currentUser: UserItem
    
    init(_ currentUser : UserItem) {
        self.currentUser = currentUser
    }
    
    @State private var currentTab: Tab = .home
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab){
                Group {
                    HomeScreen()
                        .tag(Tab.home)
                        .task {
                            present = true
                        }
                        .sheet(isPresented: $present) {
                            HalfSheet {
                                ZStack(alignment: .bottom) {
                                    ListView()
                                }
                            }
                            .presentationDragIndicator(.visible)
                            .presentationBackgroundInteraction(.enabled(upThrough: .height(100)))
                            .bottomMaskForSheet()
                            .interactiveDismissDisabled()
                            .ignoresSafeArea()
                        }
                    HistoryScreen()
                        .tag(Tab.history)
                        .task {
                            present = false
                        }
                    CreateScreen()
                        .tag(Tab.create)
                        .task {
                            present = false
                        }
                    ServicesScreen()
                        .tag(Tab.services)
                        .task {
                            present = false
                        }
                    ChatScreen()
                        .tag(Tab.chat)
                        .task {
                            present = false
                        }
                }
                .toolbar(.hidden, for: .tabBar)
                
            }
            CustomTabbar(currentTab: $currentTab)
                .background(.mainYellow)
                
        }
    }
}


struct CustomTabbar: View {
    @Binding var currentTab: Tab
//    @State var yOffset: CGFloat = -5
    
    @ViewBuilder private var backgroundView: some View {
        LinearGradient(colors: [.init(white: 0.9), .mainYellow, .white], startPoint: .topLeading, endPoint: .bottomTrailing)
            .mask {
                Circle()
                    .stroke(lineWidth: 3)
            }
            .shadow(color: .darkGray.opacity(0.3), radius: 2, x: 2.5, y: 5)
            .clipShape(Circle())
    }
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            HStack(spacing: 0) {
                ForEach(Tab.allCases,id: \.self){ tab in
                    Button {
                        withAnimation(.easeOut(duration: 0.2)){
                            currentTab = tab
//                            yOffset = 60
                        }
                        
                        withAnimation(.bouncy){
                            currentTab = tab
//                            yOffset = 60
                        }
                        
                        withAnimation(.easeOut(duration: 0.5).delay(0.07)){
//                            yOffset = -5
                        }
                    } label: {
                        VStack(spacing: 0) {
                            Image(systemName: currentTab == tab ? getImage(rawValue: tab.rawValue) : currentTabImage(rawValue: tab.rawValue))
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .frame(width: 25,height: 25)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(currentTab == tab ? .darkGray : .gray)
                                .scaleEffect(currentTab == tab ? 1 : 0.9)
                                .animation(currentTab == tab ? .spring(response: 0.5, dampingFraction: 0.3, blendDuration: 1) : .spring(), value: currentTab)
                                .rotationEffect(currentTab == tab && currentTab == .create ? .degrees(90) : .degrees(0), anchor: .center)

                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(alignment:.leading){
                VStack(alignment: .center, spacing: 0) {
                    backgroundView
                        .frame(width: 50, height: 50)
                        .offset(x: 10 , y: 5 /*y: -yOffset*/)
                        .offset(x:indicatorOffset(width: width))
                        
                    withAnimation(.easeOut(duration: 0.5).delay(1.7)){
                        Text(currentTab.rawValue)
                            .offset(x: 10 , y: 5 /*y: -yOffset*/)
                            .offset(x:indicatorOffset(width: width))
                            .font(.system(size: 10))
                            .bold()
                    }
                }
                
            }
        }
        .frame(height: 30)
        .padding(.bottom,10)
        .padding([.horizontal,.top])
    }

    
    func indicatorOffset(width:CGFloat) -> CGFloat{
        let index = CGFloat(getIndex())
        if index == 0 {
            return 0
        }
        let buttonWidth = width / CGFloat(Tab.allCases.count)
        return index * buttonWidth
    }
    
    func getIndex() -> Int{
        switch currentTab {
        case .home:
            return 0
        case .history:
            return 1
        case .create:
            return 2
        case .services:
            return 3
        case .chat:
            return 4
        }
    }
    
    func getImage(rawValue:String) -> String{
        switch rawValue {
        case "Головна":
            return "building.columns"
        case "Платежі":
            return "creditcard.fill"
        case "Перекази":
            return "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left"
        case "Рахунки":
            return "wallet.pass.fill"
        case "Чат":
            return "rectangle.3.group.bubble.fill"
        default:
            return ""
       }
    }
    
    func currentTabImage(rawValue:String) -> String{
        switch rawValue {
        case "Головна":
            return "building.columns.fill"
        case "Платежі":
            return "creditcard"
        case "Перекази":
            return "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left"
        case "Рахунки":
            return "wallet.pass"
        case "Чат":
            return "rectangle.3.group.bubble"
        default:
            return ""
       }
    }
    

}

extension View{
    func applyBG() -> some View{
        self
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .ignoresSafeArea()
    }
}

enum Tab: String,CaseIterable{
    case home = "Головна"
    case history = "Платежі"
    case create = "Перекази"
    case services = "Рахунки"
    case chat = "Чат"
}

#Preview {
    RootTabBar(.placeholder)
}
