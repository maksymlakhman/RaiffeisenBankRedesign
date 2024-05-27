//
//  CardList.swift
//  RaiffeisenBankRedesign
//
//  Created by Макс Лахман on 26.05.2024.
//

import SwiftUI
import SwiftData

struct CardList: View {
    @Binding var present : Bool
    @EnvironmentObject private var cardListViewModel : CardItemViewModel
    @Environment(\.modelContext) private var context
    
    @Query private var cards: [Card]
    @Query private var transactionItemDataModel: [TransactionItemDataModel]
    
    var body: some View {
        NavigationStack {
            VStack {
                if cards.isEmpty {
                    CardContentUnavailableView(present: $present)
                } else {
                    CoverFlowView(itemWidth: cardListViewModel.itemWidth, enableReflection: cardListViewModel.enableReflection, spacing: cardListViewModel.spacing, rotation: cardListViewModel.rotation, items: cards) { card in
                        NavigationLink {
                            ItemCardView(present: $present, selectedCard: card/*, selectedArrayOfTransactions: []*/)
                        } label: {
                            MoneyPanelView(card: card)
                        }
                        .task {
                            present = true
                        }
                        .sheet(isPresented: $present) {
                            HalfSheet {
                                ZStack(alignment: .bottom) {
                                    TransactionListView(cards: transactionItemDataModel)
                                }
                                .colorMultiply(Color.mainYellow)
                            }
                            .presentationDragIndicator(.visible)
                            .presentationBackgroundInteraction(.enabled(upThrough: .height(100)))
                            .bottomMaskForSheet()
                            .interactiveDismissDisabled()
                            .ignoresSafeArea()
                        }
                    }
                    

                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        
                    } label: {
                        HeaderView()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        CreateCardView(present: $present)
                    } label: {
                        ZStack{
                            Image(systemName: "folder.fill.badge.plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 26, height: 26)
                                .padding(8)
                                .foregroundColor(.mainYellow)
                                .background(.darkGray)
                                .clipShape(Circle())
                                .overlay {
                                    Circle().foregroundColor(.white).frame(width: 7, height: 7).position(CGPoint(x: 39.0, y: 20))
                                }
                        }
                    }
                }
            }
        }

    }
}

struct HeaderView: View {
    
    @EnvironmentObject private var userViewModel: UserViewModel
    
    var body: some View {
        HStack{
            ZStack{
                Image("header_circle")
                    .resizable()
                    .scaledToFit()
                    .phaseAnimator([false, true]) { stack, chroma in
                        stack
                            .hueRotation(.degrees(chroma ? 420 : 0))
                    } animation: { chroma in
                            .easeInOut(duration : 10)
                    }
                    .clipShape(Circle())
                
                Image(userViewModel.user.image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .padding(6)
                    
                    
            }
            .frame(width: 46, height: 46)
            
            
            Text("Hello, \(userViewModel.user.userName)!")
                            .font(.headline)
                            .foregroundColor(Color("MainTextAndForegroundIconColor"))
            
        }
    }
}


struct CardContentUnavailableView: View {
    @Binding var present : Bool
    var body: some View {
        NavigationLink {
            CreateCardView(present: $present)
        } label: {
            ContentUnavailableView {
                Image(systemName: "creditcard.fill")
                    .font(.largeTitle)
                Text("Додати картку")
                    .font(.title)
                    .bold()
            }
            .foregroundColor(.secondary)
        }
    }
}

#Preview {
    CardContentUnavailableView(present: .constant(true))
        .environmentObject(CardItemViewModel())
}


struct MoneyPanelView: View {
    
    var card: Card
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(card.hexColor))
            VStack(alignment: .leading) {
                Text(card.name).font(.title2)
                Text(String(format: "%.0f", card.coins - totalTransactionAmount(transactions: card.transactionItemsDataModel ?? [])))
                    .foregroundStyle(.secondary)
            }
            .foregroundColor(.darkGray)
            
        }
        .frame(width: UIScreen.main.bounds.width / 1.4, height: 150)
    }
    
    private func totalTransactionAmount(transactions : [TransactionItemDataModel]) -> Double {
        var totalAmount : Double = 0.0
        for transaction in transactions {
            totalAmount += transaction.userTransfers
        }
        return totalAmount
    }
    
}


struct CoverFlowView<Content : View, Item : RandomAccessCollection>: View where Item.Element : Identifiable{
    var itemWidth : CGFloat
    var enableReflection : Bool = false
    var spacing : CGFloat = 0
    var rotation : Double
    var items : Item
    var content : (Item.Element) -> Content
    var body: some View {
        GeometryReader{
            let size = $0.size
            
            ScrollView(.horizontal){
                HStack(spacing : 0){
                    ForEach(items) { item in
                        content(item)
                            .frame(width: itemWidth)
                            .reflection(added: enableReflection)
                            .visualEffect { content, geometryProxy in
                                content
                                    .rotation3DEffect(.init(degrees: rotation(geometryProxy)), axis: (x: 0, y: 1, z: 0), anchor: .center)
                            }
                            .padding(.trailing, item.id == items.last?.id ? 0 : spacing)
                    }
                }
                .padding(.horizontal, (size.width - itemWidth) / 2)
                .scrollTargetLayout()
            }
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
        .scrollClipDisabled()
    }
    
    func rotation(_ proxy : GeometryProxy) -> Double {
        let scrollViewWidth = proxy.bounds(of: .scrollView(axis: .horizontal))?.width ?? 0
        let midX = proxy.frame(in: .scrollView(axis: .horizontal)).midX
        
        let progress = midX / scrollViewWidth
        let cappedProgress = max(min(progress, 1), 0)
        
        let cappedRotation = max(min(rotation, 90),0)
        
        let dergee = cappedProgress * (cappedRotation * 2)
        
        return cappedRotation - dergee
    }
}




fileprivate extension View {
    @ViewBuilder
    func reflection(added : Bool) -> some View {
        self.overlay {
            if added {
                GeometryReader{
                    let size = $0.size
                    self
                        .scaleEffect(y : -1)
                        .mask {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(
                                    LinearGradient(colors: [.white, .white.opacity(0.7), .white.opacity(0.5), .white.opacity(0.3),
                                        .white.opacity(0.1),
                                                            .white.opacity(0),] + Array(repeating: Color.clear, count: 5), startPoint: .top, endPoint: .bottom))
                                .frame(width: UIScreen.main.bounds.width / 1.4)
                        }
                        .offset(y : size.height + 5)
                        .opacity(0.5)

                }
            }

        }
    }
    
}


struct ActivitiesView: View {
    
    
    let arrImages : [String] = ["1", "2", "3", "4", "3dPerson"]
    var cards: [Card]

    var body: some View {
        VStack {
            HStack(){
                Text("Activites")
                    
                Spacer()
            }
            .padding(.leading, 25)
            .font(.system(size: 20, weight: .semibold, design: .serif))
            .foregroundStyle(.darkGray)
            HStack(spacing: 8){
                VStack{
                    lastActivities(arrUsers: arrImages)
                    
                    HStack(spacing: 5){
                        defaultSystemIntergationCompanies(image: "payoneer", nameCorporation: "Payoneer")
                            
                        defaultSystemIntergationCompanies(image: "paypal", nameCorporation: "PayPal")
                    }
                }
                
                Button(action: {
                    
                }, label: {
                    payrollCalculation()
                })
                
                
            }
            .frame(maxHeight: 250)
            .padding(.horizontal, 10)
        }
    }
    
    func lastActivities(arrUsers : [String]) -> some View{
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("MainBackgroundIconColor"))
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Send Again")
                        .font(.system(size: 15, weight: .semibold, design: .rounded)).padding(.bottom, 10)
                        .foregroundStyle(Color("MainTextAndForegroundIconColor"))
                    Spacer()
                }
                
                HStack(spacing: -10) {
                    if arrUsers.count > 4 {
                        ForEach(arrUsers.prefix(3), id: \.self) { image in
                            Image(image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 45, height: 45)
                                .clipShape(Circle())
                        }
                        Text("+\(arrUsers.count - 3)")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .frame(width: 45, height: 45)
                            .background(Color.gray)
                            .clipShape(Circle())
                    } else {
                        ForEach(arrUsers.prefix(4), id: \.self) { image in
                            Image(image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 45, height: 45)
                                .clipShape(Circle())
                        }
                    }
                }
            }.padding(.leading, 15)
        }
    }
    
    func defaultSystemIntergationCompanies(image : String, nameCorporation : String) -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("MainBackgroundIconColor"))
            VStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 60)
                    
                Text(nameCorporation)
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color("MainTextAndForegroundIconColor"))
            }
        }
    }
    
    func payrollCalculation() -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("MainBackgroundIconColor"))
            VStack {
                Image(systemName: "banknote.fill")
                    .resizable()
                    .scaledToFit()
                    .padding(5)
                    .frame(maxWidth: 60)
                    .padding(25)
                    .background(Color("FirstBackgroundColor"))
                    .clipShape(Circle())
                
                Text("Розрахуємо заробітну плату?")
                    .multilineTextAlignment(.center)
            }


        }
        .foregroundColor(Color("MainTextAndForegroundIconColor"))
    }
}

//#Preview {
//    let preview = Preview(Card.self)
//    let cards = Card.sampleCards
//    preview.addExamples(Card.sampleCards)
//    return MoneyPanelView(card: cards[0])
//        .modelContainer(preview.container)
//        .environmentObject(CardItemViewModel())
//}
//
//
//
//#Preview {
//  let preview = Preview(Card.self)
//  preview.addExamples(Card.sampleCards)
//  return CardList()
//        .modelContainer(preview.container)
//        .environmentObject(CardItemViewModel())
//}
