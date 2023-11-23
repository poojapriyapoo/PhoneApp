//
//  ListsView.swift
//  contacts
//
//  Created by poojapriyanagaraj on 22/11/23.
//

import SwiftUI

struct ListsView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Button("Edit") {
                        // Action for Edit button
                    }
                    .padding(.leading,-375)
                    
                }
               
                HStack {
                    Spacer()
                    Button("Add List") {
                        // Action for Add List button
                    }
                    .padding(.trailing,20)
                  
                }
                Spacer()
                
                VStack {
                    Text("Lists")
                        .font(.title)
                        .padding()
                    
                    
                    Text("iCloud")
                        .font(.title)
                        .padding()
                    
                }
                
                
            }
        }
    }
}

struct ListsView_Previews: PreviewProvider {
    static var previews: some View {
        ListsView()
    }
}
