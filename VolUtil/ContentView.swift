//
//  ContentView.swift
//  VolUtil
//
//  Created by SunnyFlops on 14/07/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var systemVolume: Float = 0 {
        didSet {
            setSystemVolume(systemVolume)
        }
    }

    
    
    var body: some View {
        VStack {
            Text("Master Volume")
            
            Slider(value: $systemVolume, in: 0...1) {}
            minimumValueLabel: {
                Image(systemName: "speaker.fill")
            } maximumValueLabel: {
                Image(systemName: "speaker.wave.3.fill")
            }
            .frame(width: 150)
            .onChange(of: systemVolume) { newValue in
                setSystemVolume(newValue)
            }
            
            Divider()
            
            Text("Apps")
            
            // Apps volume sliders
            // [AppIcon] [AppName] [Slider]
            
            // submenu for system things which may not be an "app"
            // Extra >
            
            
            
            Divider()
            
            Text("Microphone Input Volume")
            
            // slider
            
            Divider()
            
            HStack {
                Button("Quit") {
                    NSApp.terminate(nil)
                }
                .tint(.red)
                
                Button("About") {
                    NSApp.terminate(nil)
                }
            }
        }
        .padding(.top)
        .padding(.bottom)
        .onAppear {
            systemVolume = getSystemVolume()
        }
        .onChange(of: systemVolume) { newValue in
            setSystemVolume(newValue)
        }
    }
}
