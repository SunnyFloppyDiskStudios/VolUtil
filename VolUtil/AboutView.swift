//
//  AboutView.swift
//  BoardMic
//
//  Created by SunnyFlops on 14/07/2025.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "person.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Created by SunnyFlops")
            
            Button("Discord Server") {
                @Environment(\.openURL) var openURL
                
                if let url = URL(string: "https://discord.gg/SGGnUUjf7P") {
                    openURL(url)
                }
            }
            
            Link("GitHub Repo", destination: URL(string: "https://github.com/SunnyFloppyDiskStudios/VolUtil")!)
            
            Link("sunnyflops.net", destination: URL(string: "https://sunnyflops.net")!)
            
            Spacer()
            
            Text("v0.0.0 (pa)")
            
        }
        .padding()
    }
}

#Preview {
    AboutView()
}
