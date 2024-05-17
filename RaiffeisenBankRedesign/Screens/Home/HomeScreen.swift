//
//  HomeScreen.swift
//  RaiffeisenBankNeomorphStyleRedesign
//
//  Created by Макс Лахман on 08.05.2024.
//

import SwiftUI

struct HomeScreen: View {
    @State private var present : Bool = false
    var body: some View {
        NavigationStack{
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        UserCardsHeaderView(cardColor: .white, foregroundCardColor: .darkGray)
                        UserCardsHeaderView(cardColor: .mainYellow, foregroundCardColor: .darkGray)
                        UserCardsHeaderView(cardColor: .darkGray, foregroundCardColor: .mainYellow)
                    }
                    .padding(.leading, 16)
                }
                Section {
                    SendMoneyToView()
                } header: {
                    Text("Швидка відправка")
                        .textCase(.uppercase)
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                }
                Spacer()     
            }
            .background(.mainYellow.opacity(0.5))
            .toolbar {
                leadingNavItems()
                trailingNavItems()
            }
        }
    }
}

extension HomeScreen {
    @ToolbarContentBuilder
    private func leadingNavItems() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Menu {
                VStack {
                    Button {
                        
                    } label: {
                        VStack {
                            Label("Select Chats", systemImage: "checkmark.circle")
                        }
                    }
                    Button {
                        
                    } label: {
                        VStack {
                            Label("Select Chats", systemImage: "checkmark.circle")
                        }
                    }
                    Button {
                        
                    } label: {
                        VStack {
                            Label("Select Chats", systemImage: "checkmark.circle")
                        }
                    }
                    Button {
                        
                    } label: {
                        VStack {
                            Label("Select Chats", systemImage: "checkmark.circle")
                        }
                    }
                }
                
            } label: {
                Image(systemName: "line.horizontal.3.decrease")
                    .foregroundStyle(.darkGray)
            }
            
        }
    }
    
    
    @ToolbarContentBuilder
    private func trailingNavItems() -> some ToolbarContent {
        
        ToolbarItemGroup(placement: .topBarTrailing) {
            aiButton()
            cameraButton()
        }
        
    }
    
    private func aiButton() -> some View {
        Button {
            
        } label: {
            Image(systemName: "message")
                .foregroundStyle(.darkGray)
        }
        
    }
    
    private func cameraButton() -> some View {
        Button {
            Task{
                try? await AuthManager.shared.logOut()
            }
        } label: {
            Image(systemName: "person.circle")
                .foregroundStyle(.darkGray)
        }
        
    }
}

private struct UserCardsHeaderView : View {
    var cardColor: Color
    var foregroundCardColor: Color
    
    init(cardColor: Color, foregroundCardColor : Color) {
        self.cardColor = cardColor
        self.foregroundCardColor = foregroundCardColor
    }
    
    var body: some View {
        VStack(alignment: .leading , spacing: 10) {
            HStack(alignment: .center) {
                Image(systemName: "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left")
                    .foregroundStyle(foregroundCardColor)
                    .imageScale(.large)
                Spacer()
                Image(systemName: "chart.bar.fill")
                    .foregroundStyle(foregroundCardColor)
            }
            VStack(alignment: .leading , spacing: 0) {
                (
                    Text("23,097")
                        .font(.title2)
                        .bold()
                    +
                    Text(" ")
                        .bold()
                    +
                    Text("$")
                        .font(.system(size: 18))
                )
                Text("Platinum Plus")
                    .font(.system(size: 12))
            }
            .padding(.vertical, 20)
            .foregroundStyle(foregroundCardColor)
            HStack(spacing: 0) {
                Image(.mastercardLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 30)
                Spacer()
                VStack(alignment: .center ,spacing: 0){
                    Text("Дата закінчення")
                        .font(.system(size: 4.5))
                    Text("12/23")
                        .font(.system(size: 15))
                }
                .foregroundStyle(foregroundCardColor)
            }
        }
        .frame(minWidth: 140)
        .frame(maxHeight: 160)
        .padding()
        .background(cardColor)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding()
    }
}



private struct SendMoneyToView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                AddNewSendMoneyPlusButtonView()
                AddNewSendMoneyUserView()
                AddNewSendMoneyUserView()
                AddNewSendMoneyUserView()
            }
            .padding(.leading, 16)
        }
        
    }
    
    private func AddNewSendMoneyUserView() -> some View {
        HStack {
            VStack(alignment: .leading) {
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray)
                    VStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(maxWidth: 40, maxHeight: 40)
                        Text("User Name")
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                }
            }
            .padding(5)
            .frame(maxWidth: 200, maxHeight: 150)
        }
    }
    
    private func AddNewSendMoneyPlusButtonView() -> some View {
        Button {
            
        } label: {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 10, height: 10)
                .padding(15)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(.darkGray)
                }
                .foregroundStyle(.darkGray)
                .bold()
                .padding(16)
        }
        
    }
}

//#Preview {
//    NavigationStack {
//        HomeScreen()
//    }
//}
#Preview {
    RootTabBar(.placeholder)
}
