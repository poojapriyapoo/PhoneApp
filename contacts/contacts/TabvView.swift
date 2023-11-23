//
//  TabvView.swift
//  contacts
//
//  Created by poojapriyanagaraj on 20/11/23.
//

import SwiftUI

struct TabvView: View {
    var body: some View {
        
                 TabView {
                     
                     // Favorites Tab
                     Text("Favorites")
                         .tabItem {
                             Image(systemName: "star.fill")
                             Text("Favorites")
                         }
                     
                     
                     // Recents Tab
                     Text("Recents")
                         .tabItem {
                             Image(systemName: "clock.fill")
                             Text("Recents")
                         }
                     

                     // Contacts Tab
                     VStack {
                         ContentView()
                         
                     }
                     .tabItem {
                         Image(systemName: "person.fill")
                         Text("Contacts")
                     }
                     
                     // Keypad Tab
                     Text("Keypad")
                         .tabItem {
                             Image(systemName: "phone.fill")
                             Text("Keypad")
                         }

                     // Voicemail Tab
                     Text("Voicemail")
                         .tabItem {
                             Image(systemName: "recordingtape")
                             Text("Voicemail")
                         }
                 }
    }
}

struct TabvView_Previews: PreviewProvider{
    static var previews: some View{
        TabvView()
    }
}
