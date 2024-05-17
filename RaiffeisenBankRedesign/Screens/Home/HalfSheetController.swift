//
//  HalfSheetController.swift
//  RaiffeisenBankNeomorphStyleRedesign
//
//  Created by Макс Лахман on 14.05.2024.
//

import SwiftUI

struct MyCustomDetent: CustomPresentationDetent {
    static func height(in context: Context) -> CGFloat? {
        if context.verticalSizeClass == .regular {
            return context.maxDetentValue * 0.8
        } else {
            return context.maxDetentValue
        }
    }
}

struct HalfSheet<Content>: UIViewControllerRepresentable where Content : View {

    private let content: Content
    
    @inlinable init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    func makeUIViewController(context: Context) -> HalfSheetController<Content> {
        return HalfSheetController(rootView: content)
    }
    
    func updateUIViewController(_: HalfSheetController<Content>, context: Context) {
    }
}

class HalfSheetController<Content>: UIHostingController<Content> where Content : View {
    @State private var currentTab: Tab = .history
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let presentation = sheetPresentationController {
            presentation.detents = [.custom { context in
                return context.maximumDetentValue * 0.35
            }, .medium(), .large()]
            presentation.prefersGrabberVisible = true
            presentation.largestUndimmedDetentIdentifier = .medium
        }
    }
}


#Preview {
    RootTabBar(.placeholder)
}

struct ListItem: View, Identifiable {
    
    let id = UUID()
    let image: String
    let title: String
    let subtitle: String
    let price: String
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 15)
                .frame(maxWidth: .infinity)
                .frame(height: 70, alignment: .center)
                .foregroundColor(Color.white)
                .shadow(color: Color.secondary, radius: 2, x: 2, y: 2)
                
            HStack {
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 40)
                    .padding()
                    
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .bold()
                        
                        
                    Text(subtitle)
                        
                        
                
                }
                .font(.system(size: 10))
                
                    Spacer()
                
                Text(price)
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


struct ListView: View {
    
    init() {
    
        UITableView.appearance().separatorColor = UIColor.clear
        UITableViewCell.appearance().backgroundColor = UIColor.clear

    }
    
    var body: some View {
//        GeometryReader { geo in
            List {
                Section(header: Text("Today").padding(.vertical, 5).bold().font(.system(size: 20))) {
                    ListItem(image: "applelogo", title: "APPLE.COM", subtitle: "Monthly Subscription", price: "-2,99 $")
                    ListItem(image: "shareplay", title: "NETFLIX.COM", subtitle: "Monthly Subscription", price: "-14,49 $")
                    ListItem(image: "ipad.homebutton.landscape", title: "AMAZON.COM", subtitle: "Shopping", price: "-218,60 $")
                }
                Section(header: Text("Yesterday").padding(.vertical, 5).bold().font(.system(size: 20))) {
                    ListItem(image: "Spotify", title: "SPOTIFY.COM", subtitle: "Monthly Subscription", price: "-6,49 $")
                    ListItem(image: "Shopping", title: "SHOPPING", subtitle: "Grocery Store", price: "-24,40 $")
                    ListItem(image: "Shopping", title: "SHOPPING", subtitle: "Clothes Store", price: "-28,30 $")
                }
                Section(header: Text("Today").padding(.vertical, 5).bold().font(.system(size: 20))) {
                    ListItem(image: "applelogo", title: "APPLE.COM", subtitle: "Monthly Subscription", price: "-2,99 $")
                    ListItem(image: "shareplay", title: "NETFLIX.COM", subtitle: "Monthly Subscription", price: "-14,49 $")
                    ListItem(image: "ipad.homebutton.landscape", title: "AMAZON.COM", subtitle: "Shopping", price: "-218,60 $")
                }
                Section(header: Text("Yesterday").padding(.vertical, 5).bold().font(.system(size: 20))) {
                    ListItem(image: "Spotify", title: "SPOTIFY.COM", subtitle: "Monthly Subscription", price: "-6,49 $")
                    ListItem(image: "Shopping", title: "SHOPPING", subtitle: "Grocery Store", price: "-24,40 $")
                    ListItem(image: "Shopping", title: "SHOPPING", subtitle: "Clothes Store", price: "-28,30 $")
                }
            }
            .background(Color.mainYellow)
            .listStyle(.plain)
            .scrollIndicators(.hidden)
//            .frame(width: geo.size.width/1.005, height: geo.size.height)
//        }
//        
//        .background(Color(red: 235, green: 235, blue: 235))
            
        
    }
}
