//
//  ListUsers.swift
//  RaiffeisenBankRedesign
//
//  Created by Макс Лахман on 26.05.2024.
//

import SwiftUI

struct ListUsers: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var team: TeamModel
    var card : Card
    var teamUsers : [User]
    
    var body: some View {
        VStack{
            if teamUsers.isEmpty {
                withAnimation(.spring) {
                    VStack(spacing : 0) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(card.hexColor))
                            ContentUnavailableView {
                                ScrollView(.vertical, showsIndicators: false) {
                                    VStack(alignment: .leading) {
                                        Text("додавання співробітника")
                                            .font(.system(size: 20, weight: .bold, design: .serif))
                                            .padding(.vertical, 10)
                                        
                                        if !card.name.isEmpty {
                                            Text("Відкрийте мобільний додаток і перейдіть на головний екран або до розділу вашої картки \(card.name). \n\n У розділі 'Команда' натисніть кнопку 'Додати' або 'Відсканувати'. \n\n Після натискання кнопки ви побачите поле для введенняінформації або можливість сканування. \n\nОберіть 'Ввести інформацію'. \nВведіть ім'я та прізвище нового користувача у відповідні поля. \n\nОберіть колір для нового користувача. Зазвичай це може бути опція, представлена у вигляді випадаючого списку або палітри кольорів.\nПісля введення інформації та обрання кольору натисніть кнопку 'Готово' або 'Зберегти'.Новий користувач буде доданий до вашої команди з введеними даними та обраним кольором.\n\nГотово! Тепер новий користувач успішно доданий до вашої команди і має вказані характеристики.")
                                                .font(.system(size: 13, weight: .light, design: .serif))
                                                .multilineTextAlignment(.leading)
                                                .fontWeight(.bold)
                                        } else {
                                            Text("Відкрийте мобільний додаток і перейдіть на головний екран або до розділу вашої картки Команда. \n\n У розділі 'Команда' натисніть кнопку 'Додати' або 'Відсканувати'. \n\n Після натискання кнопки ви побачите поле для введенняінформації або можливість сканування. \n\nОберіть 'Ввести інформацію'. \nВведіть ім'я та прізвище нового користувача у відповідні поля. \n\nОберіть колір для нового користувача. Зазвичай це може бути опція, представлена у вигляді випадаючого списку або палітри кольорів.\nПісля введення інформації та обрання кольору натисніть кнопку 'Готово' або 'Зберегти'.Новий користувач буде доданий до вашої команди з введеними даними та обраним кольором.\n\nГотово! Тепер новий користувач успішно доданий до вашої команди і має вказані характеристики.")
                                                .font(.system(size: 13, weight: .light, design: .serif))
                                                .multilineTextAlignment(.leading)
                                                .fontWeight(.bold)
                                        }
                                        
                                    }
                                }
                                
                            }
                            .foregroundStyle(Color.black)
                        }
                        HStack(spacing : 0) {
                            Button{
                                
                            } label: {
                                ZStack{
                                    Circle()
                                        .foregroundStyle(Color(.darkGray))
                                    VStack{
                                        Image(systemName: "qrcode.viewfinder")
                                            .imageScale(.large)
                                            .font(.largeTitle)
                                        Text("Сканувати")
                                            .font(.caption)
                                            .bold()
                                    }
                                    .foregroundStyle(card.hexColor)
                                    
                                }
                            }
                            
                            NavigationLink {
                                CreateTeamUserSheetView(team: team)
                            } label: {
                                ZStack{
                                    Circle()
                                        .foregroundStyle(Color(team.hexColor))
                                    VStack{
                                        Image(systemName: "person.fill.badge.plus")
                                            .imageScale(.large)
                                            .font(.largeTitle)
                                        Text("Додати")
                                            .font(.caption)
                                            .bold()
                                    }
                                    .foregroundStyle(Color.darkGray)
                                }
                            }
                        }
                        .padding(.bottom, 65)
                    }
                    .padding(10)
                }

            } else {
                withAnimation(.snappy) {
                    VStack(spacing: 0) {
                        HStack(spacing : 0) {
                            Button{
                                
                                
                                
                                
                                
                            } label: {
                                ZStack{
                                    Circle()
                                        .foregroundStyle(Color(.darkGray))
                                    VStack{
                                        Image(systemName: "qrcode.viewfinder")
                                            .imageScale(.large)
                                            .font(.largeTitle)
                                        Text("Сканувати")
                                            .font(.caption)
                                            .bold()
                                    }
                                    .foregroundStyle(card.hexColor)
                                    
                                }
                            }
                            .buttonStyle(.borderless)
                            
                            Button{
//                                coordinator.present(sheet: .addTeamUserSheet)
                            } label: {
                                ZStack{
                                    Circle()
                                        .foregroundStyle(Color(team.hexColor))
                                    VStack{
                                        Image(systemName: "person.fill.badge.plus")
                                            .imageScale(.large)
                                            .font(.largeTitle)
                                        Text("Додати")
                                            .font(.caption)
                                            .bold()
                                    }
                                    .foregroundStyle(Color.darkGray)
                                }
                            }
                            .buttonStyle(.borderless)
                        }
                        List(){
                            Section("Список співробітників"){
                                ForEach(teamUsers){ teamUser in
                                    HStack {
                                        HStack{
                                            if let arrTeamUsers = team.arrUsers {
                                                if arrTeamUsers.isEmpty {
                                                    Button {
                                                        addRemove(teamUser)
                                                    } label: {
                                                        Image(systemName: "circle")
                                                    }
                                                    .foregroundStyle(teamUser.hexColor)
                                                } else {
                                                    Button {
                                                        addRemove(teamUser)
                                                    } label: {
                                                        Image(systemName: arrTeamUsers.contains(teamUser) ? "person.fill.checkmark" : "circle")
                                                    }
                                                    .foregroundStyle(teamUser.hexColor)
                                                }
                                                
                                            }
                                            
                                        }
                                        .buttonStyle(.borderless)
                                        Button {
//                                            coordinator.viewModel.user = teamUser
//                                            coordinator.push(.userView)
                                        } label: {
                                            HStack(spacing: 2.5) {
                                                Text(teamUser.name)
                                                Text(teamUser.userLastName)
                                                Spacer()
                                            }
                                            
                                        }
                                        .buttonStyle(.borderless)
                                    }
                                }
                                .onDelete(perform: { indexSet in
                                    indexSet.forEach { index in
                                        if let arrTeamUsers = team.arrUsers,
                                           arrTeamUsers.contains(teamUsers[index]),
                                           let arrTeamUsersIndex = arrTeamUsers.firstIndex(where: {$0.id == teamUsers[index].id}) {
                                            team.arrUsers?.remove(at: arrTeamUsersIndex)
                                        }
                                        context.delete(teamUsers[index])
                                    }
                                })
                            }
                        }
                        .padding(.bottom, 65)
                        .listStyle(.inset)
                        .scrollIndicators(.hidden)
                    }
                }
            }
        }
    }
    func addRemove(_ user: User) {
        if let teamUseres = team.arrUsers {
            if teamUseres.isEmpty {
                team.arrUsers?.append(user)
            } else {
                if teamUseres.contains(user),
                   let index = teamUseres.firstIndex(where: {$0.id == user.id}) {
                    team.arrUsers?.remove(at: index)
                } else {
                    team.arrUsers?.append(user)
                }
            }
        }
    }
}

