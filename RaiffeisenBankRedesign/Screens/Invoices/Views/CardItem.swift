//
//  CardItem.swift
//  RaiffeisenBankRedesign
//
//  Created by Макс Лахман on 26.05.2024.
//

import SwiftUI
import SwiftData

struct ButtonDeleteCard: View {
    
    @Bindable var card : Card
    
    var body: some View {
        NavigationLink {
            ParametersCardView(card: card)
        } label: {
            ZStack {
                Circle()
                    .fill(.gray)
                Image(systemName: "scale.3d")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16, alignment: .center)
                    .padding(14)
                    .foregroundColor(Color("MainBackgroundIconColor"))
            }
            .frame(width: 20, height: 20, alignment: .center)
            .padding(.trailing, 10)
        }
    }
}

struct HomeItemAdditionalFunctionalityCard: View {
    
    @Environment(\.modelContext) private var context
    
    var selectedCard : Card
    
    @EnvironmentObject var itemCardViewModel : ItemCardViewModel
    
    var body: some View {
        ZStack {
            UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 40, bottomTrailingRadius: 40, topTrailingRadius: 0, style: .continuous)
                .fill(selectedCard.hexColor)
            
            VStack(alignment: .trailing, spacing: 0) {
                Spacer()
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 0){
                        HStack(alignment: .bottom, spacing: 0) {
                            Text(String(format: "%.2f", selectedCard.coins - itemCardViewModel.totalTransactionAmount(transactions: selectedCard.transactionItemsDataModel ?? [])))
                                .font(.system(size: 32, weight: .medium, design: .serif))
                        }
                    }
                    Spacer()
                    Image(selectedCard.logoCard.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 40)
                }
                .padding(20)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                ZStack{
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color.mainYellow)
                        .padding(.bottom, 20)
                        .padding(.horizontal, 20)
                    HStack(alignment: .center){
                        Spacer()
                        VStack(alignment: .leading){
                            Text("Зараховано")
                            Text(String(format: "%.2f", selectedCard.coins))
                        }
                        Spacer()
                        Divider()
                            .background(Color(selectedCard.hexColor))
                        
                            .padding(.vertical, 20)
                        Spacer()
                        VStack(alignment: .leading){
                            Text("Витрачено")
                            if itemCardViewModel.totalTransactionAmount(transactions: selectedCard.transactionItemsDataModel ?? []) == 0.00 {
                                Text(String(format: "%.2f", itemCardViewModel.totalTransactionAmount(transactions: selectedCard.transactionItemsDataModel ?? [])))
                            } else {
                                Text(String(format: "-%.2f", itemCardViewModel.totalTransactionAmount(transactions: selectedCard.transactionItemsDataModel ?? [])))
                            }
                            
                        }
                        Spacer()
                    }
                    .padding(.vertical, 20)
                }
                .frame(maxHeight: UIScreen.main.bounds.height / 7)
            }
            
        }
        .navigationTitle(selectedCard.name)
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(edges: .top)
        .frame(width: UIScreen.main.bounds.width / 1, height: UIScreen.main.bounds.height / 4)
    }
    
    
}

struct HomeItemEmptyAddTeamButtonView: View {
    var selectedCard : Card
    var body: some View {
        NavigationLink {
            CreateTeamView(card: selectedCard)
        } label: {
            ZStack{
                Capsule()
                    .strokeBorder(Color(selectedCard.hexColor), style: .init(lineWidth: 2.2, dash: [4.5]))
                HStack {
                    Text("Додай команду")
                    Image(systemName: "plus.circle.fill")
                        .scaleEffect(1.4)
                }
                .foregroundStyle(Color(selectedCard.hexColor))
            }
            .frame(maxHeight: 70)
            .padding(.horizontal, 20)
        }
    }
}

struct HorisontalSVAllTeams: View {
    
    var card : Card
    var teams : [TeamModel]
    
    var body: some View {
        HStack {
            TeamFlowView(items: teams) { team in
                NavigationLink {
                    TeamView(team: team, card: card)
                } label: {
                    TeamPanelView(team: team, card: card)
                }
            }
            NavigationLink {
                CreateTeamView(card: card)
            } label: {
                ZStack {
                    Capsule()
                        .strokeBorder(Color(card.hexColor), style: .init(lineWidth: 2.2, dash: [4.5]))
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16, alignment: .center)
                        .foregroundStyle(Color(card.hexColor))
                }
                .frame(maxWidth: 80, maxHeight: 180)
            }
        }
        .padding(.trailing, 20)
    }
}


struct TeamPanelView: View {
    var team: TeamModel
    var card : Card
    @State private var scaleAnimationButton = true
    var body: some View {
        ZStack {
            UnevenRoundedRectangle(topLeadingRadius: 20, bottomLeadingRadius: 20, bottomTrailingRadius: 20, topTrailingRadius: 20)
                .fill(team.hexColor.opacity(1))
            VStack(alignment: .center) {
                if team.arrUsers?.isEmpty == true {
                    VStack{
                        HStack(spacing : 0) {
                            Text(team.teamName)
                                .padding(.vertical, 5)
                                .font(.system(size: 18, design: .rounded))
                                .fontWeight(.bold)
                            Text(team.region.description)
                                .font(.system(size: 10, design: .rounded))
                                .fontWeight(.bold)
                                .offset(y : -8)
                        }
                        .foregroundStyle(.black)
                        Text("Наразі порожня")
                            .foregroundStyle(.black)
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(.darkGray))
                            Text("Додати")
                                .foregroundStyle(Color(team.hexColor))
                        }
                        .padding(.top, 20)
                        .scaleEffect(scaleAnimationButton ? 0.8 : 0.7)
                        .onAppear() {
                            withAnimation(Animation.easeInOut(duration: 1.0).repeatForever()) {
                                scaleAnimationButton.toggle()
                            }
                        }
                        
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical ,20)
                } else {
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: -20){
                            if team.arrUsers?.count ?? 0 > 4{
                                ForEach(team.arrUsers?.prefix(3) ?? [], id: \.self) { user in
                                    ZStack {
                                        Circle()
                                            .fill(Color(user.hexColor))
                                            .frame(maxHeight: 50)
                                            .padding(.horizontal, 5)
                                        
                                        Text(String(user.name.first ?? " "))
                                            .padding(10)
                                            .font(.system(size: 12))
                                        
                                    }
                                    .padding(.top, 20)
                                }
                                Text("+\((team.arrUsers?.count ?? 0) - 3)")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                    .frame(width: 50, height: 50)
                                    .background(Color.gray)
                                    .clipShape(Circle())
                            } else {
                                ForEach(team.arrUsers?.prefix(4) ?? [], id: \.self) { user in
                                    ZStack {
                                        Circle()
                                            .fill(Color(user.hexColor))
                                            .frame(maxHeight: 50)
                                            .padding(.horizontal, 5)
                                        
                                        Text(String(user.name.first ?? " "))
                                            .padding(10)
                                            .font(.system(size: 12))
                                        
                                    }
                                    .padding(.top, 10)
                                }
                            }
                            
                        }
                    }
                    HStack(spacing: 0) {
                        Text(team.teamName)
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .fontWeight(.bold)
                        Text(team.region.description)
                            .font(.system(size: 10, design: .rounded))
                            .fontWeight(.bold)
                            .offset(y : -8)
                    }
                    .padding()
                    NavigationLink {
                        ReceiveView(card: card)
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(.darkGray))
                            Text("Оплатити")
                                .padding(10)
                                .foregroundStyle(Color(team.hexColor))
                        }
                        .padding(.vertical ,20)
                        .padding(.horizontal ,10)
                    }
                    
                    //                    Button(action: {
                    //
                    //                    }, label: {
                    //
                    //                    })
                    //                    .buttonStyle(.borderless)
                }
                
                
            }
            .foregroundStyle(Color("MainTextAndForegroundIconColor"))
        }
    }
    
}


struct TeamFlowView<Content: View, Item: RandomAccessCollection>: View where Item.Element == TeamModel {
    var items : Item
    var content : (Item.Element) -> Content
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(items) { item in
                            content(item)
                                .padding(.leading, 20)
                                .padding(.trailing, 25)
                                .frame(width: geometry.size.width)
                                .visualEffect { content, geometryProxy in
                                    content
                                        .scaleEffect(scale(geometryProxy, scale: 0.1), anchor: .trailing)
                                        .rotationEffect(rotation(geometryProxy, rotation: 4))
                                        .offset(x: minX(geometryProxy))
                                        .offset(x : exessMinX(geometryProxy, offset: 4))
                                }
                                .zIndex(Array(items).zIndex(item))
                            
                        }
                    }
                    .padding(.vertical, 15)
                }
                .scrollTargetBehavior(.paging)
            }
            
        }
    }
    
    
    
    func minX(_ proxy : GeometryProxy) -> CGFloat {
        let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
        return minX < 0 ? 0 : -minX
    }
    
    func progress(_ proxy : GeometryProxy, limit : CGFloat = 2) -> CGFloat {
        let maxX = proxy.frame(in: .scrollView(axis: .horizontal)).maxX
        let width = proxy.bounds(of: .scrollView(axis: .horizontal))?.width ?? 0
        let progress = (maxX / width) - 1.0
        let cappedProgress = min(progress, limit)
        return cappedProgress
    }
    
    func scale(_ proxy : GeometryProxy, scale : CGFloat = 0.1) -> CGFloat{
        let progress = progress(proxy)
        return 1 - (progress * scale)
    }
    
    func exessMinX(_ proxy: GeometryProxy, offset : CGFloat = 10) -> CGFloat{
        let progress = progress(proxy)
        
        return progress * offset
    }
    
    func rotation(_ proxy: GeometryProxy, rotation : CGFloat = 5) -> Angle {
        let progress = progress(proxy)
        
        return .init(degrees: progress * rotation)
    }
}


extension Array where Element == TeamModel {
    func zIndex(_ item: TeamModel) -> CGFloat {
        if let index = firstIndex(where: { $0.id == item.id }) {
            return CGFloat(count) - CGFloat(index)
        }
        return 0
    }
}



fileprivate extension View {
    @ViewBuilder
    func reflection(added: Bool) -> some View {
        self.overlay {
            if added {
                GeometryReader { geometry in
                    let size = geometry.size
                    self
                        .scaleEffect(y: 1)
                        .mask {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(
                                    LinearGradient(colors: [.white, .white.opacity(0.7), .white.opacity(0.5), .white.opacity(0.3),
                                                            .white.opacity(0.1),
                                                            .white.opacity(0),] + Array(repeating: Color.clear, count: 5), startPoint: .center, endPoint: .bottomLeading))
                                .frame(width: UIScreen.main.bounds.height / 1.4)
                        }
                        .offset(x: size.width - 410)
                        .rotation3DEffect(.init(degrees: 50), axis: (x: 1, y: 0, z: 0), anchor: .leading)
                        .opacity(0.5)
                    
                }
            } else {
                EmptyView()
            }
        }
    }
    
}




struct ItemCardView: View {
    @Binding var present : Bool
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Query private var creatingTeamsModelData: [TeamModel]
    
    var selectedCard : Card
    @Query private var selectedArrayOfTransactions: [TransactionItemDataModel]
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10){
                
                HomeItemAdditionalFunctionalityCard(selectedCard: selectedCard)
                
                if creatingTeamsModelData.isEmpty {
                    HomeItemEmptyAddTeamButtonView(selectedCard: selectedCard)
                } else {
                    HorisontalSVAllTeams(card: selectedCard, teams: creatingTeamsModelData)
                }
                
                
            }
            
        }
        .task {
            present = false
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "xmark")
                })
                
            }
            ToolbarItem(placement: .topBarTrailing) {
                ButtonDeleteCard(card: selectedCard)
            }
        }
        
    }
}


//struct TransactionListView: View {
//    @Environment(\.modelContext) private var context
//    let cards : [Card]
//
//    init(cards : [Card]) {
//        self.cards = cards
//        UITableView.appearance().separatorColor = UIColor.clear
//        UITableViewCell.appearance().backgroundColor = UIColor.clear
//
//    }
//
//    var body: some View {
//        NavigationStack {
////            Section(header: Text("Транзакції").padding(.vertical, 5).bold().font(.system(size: 20))) {
//                List(cards) { card in
//                    let transactionSoft = card.transactionItemsDataModel?.sorted(using: KeyPathComparator(\TransactionItemDataModel.userTransfers)).reversed() ?? []
//
//                    ForEach(transactionSoft){ transaction in
//
//                        NavigationLink {
//                            TransactionDetailsView(transactionItemDataModel: transaction)
//                        } label: {
//                            TransactionDetailsView(transactionItemDataModel: transaction)
//                        }
//                        .listRowSeparator(.hidden)
//                    }
//                    //                    ListItem(image: "applelogo", title: "APPLE.COM", subtitle: "Monthly Subscription", price: "-2,99 $")
//
//                }
//                .background(Color.mainYellow)
//                .listStyle(.plain)
//                .scrollIndicators(.hidden)
////            }
//        }
//
//    }
//
//}


struct TransactionListView: View {
    @Environment(\.modelContext) private var context
    let cards : [TransactionItemDataModel]
    
    init(cards : [TransactionItemDataModel]) {
        self.cards = cards
        UITableView.appearance().separatorColor = UIColor.clear
        UITableViewCell.appearance().backgroundColor = UIColor.clear
        
    }
    
    private var sortedCards: [TransactionItemDataModel] {
        cards.sorted { $0.currentTimeAndDate > $1.currentTimeAndDate } // Сортування в зворотному порядку
    }
    
    
    @State private var path = NavigationPath()
    
    
    
    var body: some View {
        NavigationStack(path: $path) {
            Section(header: HStack{
                Text("Транзакції")
                    .padding(.leading, 20)
                    .padding(.vertical, 10)
                Spacer()
                }
                .padding(.vertical, 5)
                .bold()
                .font(.system(size: 20))) {
                    List(sortedCards) { card in
                        Button{
                            path.append(card)
                        } label: {
                            TransactionDetailsView(transactionItemDataModel: card)
                        }
                        .listRowSeparator(.hidden)
                    }
                    .background(Color.mainYellow)
                    .listStyle(.plain)
                    .scrollIndicators(.hidden)
                    .navigationDestination(for: TransactionItemDataModel.self) { card in
                        TransactionDetailsView(transactionItemDataModel: card)
                    }
                }
        }
        
    }
    
}



struct TransactionDetailsView: View {
    
    let transactionItemDataModel : TransactionItemDataModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(maxWidth: .infinity)
                .frame(height: 70, alignment: .center)
                .foregroundColor(Color.white)
                .shadow(color: Color.secondary, radius: 2, x: 2, y: 2)
            
            HStack {
                Image(systemName: "apple.logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 40)
                    .padding()
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(transactionItemDataModel.card?.name ?? "")
                        .bold()
                    Text(transactionItemDataModel.currentTimeAndDate.description)
                }
                .font(.system(size: 10))
                
                Spacer()
                
                Text(String(format: "-%.2f", transactionItemDataModel.userTransfers))
                    .font(.system(size: 20))
                    .bold()
                    .padding()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 70, alignment: .center)
        .listRowBackground(Color.clear)
        
    }
}

