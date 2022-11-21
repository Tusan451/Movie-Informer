//
//  SettingsView.swift
//  Movie Informer
//
//  Created by Olegio on 18.11.2022.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("isLightMode") private var isLightMode = false
    @AppStorage("isSystemMode") private var isSystemMode = true
    @EnvironmentObject var csManager: ColorSchemeManager
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Back Main")
                    .ignoresSafeArea()
                VStack(spacing: 16) {
                    HStack {
                        Text("Темная тема")
                            .font(.custom("Inter-Medium", size: 15))
                            .foregroundColor(Color("Text Secondary"))
                            .frame(width: UIScreen.main.bounds.width / 2, alignment: .leading)
                        
                        Toggle("", isOn: $isDarkMode)
                            .tag(ColorScheme.dark)
                            .tint(Color("Primary Accent"))
                            .onChange(of: isDarkMode) { newValue in
                                if newValue {
                                    csManager.colorSheme = .dark
                                    isLightMode = false
                                    isSystemMode = false
                                }
                            }
                    }
                    .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height / 14, alignment: .bottom)
                    
                    HStack {
                        Text("Светлая тема")
                            .font(.custom("Inter-Medium", size: 15))
                            .foregroundColor(Color("Text Secondary"))
                            .frame(width: UIScreen.main.bounds.width / 2, alignment: .leading)
                        
                        Toggle("", isOn: $isLightMode)
                            .tag(ColorScheme.light)
                            .tint(Color("Primary Accent"))
                            .onChange(of: isLightMode) { newValue in
                                if newValue {
                                    csManager.colorSheme = .light
                                    isDarkMode = false
                                    isSystemMode = false
                                }
                            }
                    }
                    .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                    
                    HStack {
                        Text("Как в системе")
                            .font(.custom("Inter-Medium", size: 15))
                            .foregroundColor(Color("Text Secondary"))
                            .frame(width: UIScreen.main.bounds.width / 2, alignment: .leading)
                        
                        Toggle("", isOn: $isSystemMode)
                            .tag(ColorScheme.unspecified)
                            .tint(Color("Primary Accent"))
                            .onChange(of: isSystemMode) { newValue in
                                if newValue {
                                    csManager.colorSheme = .unspecified
                                    isDarkMode = false
                                    isLightMode = false
                                }
                            }
                    }
                    .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                    
                    Spacer()
                }
                .navigationTitle("Настройки")
            }
        }
        .tint(Color("Secondary Accent"))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ColorSchemeManager())
    }
}
