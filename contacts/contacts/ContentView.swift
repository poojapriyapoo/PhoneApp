//
//  ContentView.swift
//  contacts
//
//  Created by poojapriyanagaraj on 15/11/23.
//

import SwiftUI

struct Contact: Identifiable {
    var id = UUID()
    var name: String
    var phoneNumber: String
}

struct ContentView: View {
    @State private var contacts: [Contact] = [
        Contact(name: "Pooja Priya", phoneNumber: "123-456-7890"),
        Contact(name: "Sebin Joseph", phoneNumber: "987-654-3210"),
        Contact(name: "Cherry Chai", phoneNumber: "123-456-7890"),
        Contact(name: "Jane Smith", phoneNumber: "987-654-3210"),
        Contact(name: "Virat Kohli", phoneNumber: "123-456-7890"),
        Contact(name: "Rohit Sharma", phoneNumber: "987-654-3210"),
        Contact(name: "Maria Luca", phoneNumber: "123-456-7890"),
        Contact(name: "Pruthvi Priya", phoneNumber: "987-654-3210"),
        Contact(name: "Abril Lopez", phoneNumber: "987-654-3210")
        
    ]
    @State private var newName: String = ""
    @State private var newPhoneNumber: String = ""
    @State private var isAddingContact = false
    @State private var searchText = ""
    @State private var selectedSection: String?
    
    
    
    var filteredContacts: [Contact] {
        
        var uniqueContacts = [Contact]()
        
        for contact in contacts {
            if !uniqueContacts.contains(where: { $0.name == contact.name }) {
                uniqueContacts.append(contact)
            }
        }
        
        if searchText.isEmpty {
            return uniqueContacts
        } else {
            return uniqueContacts.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    struct AddContactView: View {
        @Binding var isPresented: Bool
        @Binding var contacts: [Contact]
        @State private var newName: String = ""
        @State private var newPhoneNumber: String = ""
        @State private var newEmail: String = ""
        
        
        var body: some View {
            NavigationView {
                Form {
                    Section(header: Text("Contact Information")) {
                        TextField("Name", text: $newName)
                        TextField("Phone Number", text: $newPhoneNumber)
                        TextField("Email", text: $newEmail)                }
                    
                    Section {
                        Button("Save", action: saveContact)
                    }
                }
                .navigationBarTitle("Add Contact", displayMode: .inline)
                .navigationBarItems(trailing:
                                        Button("Cancel") {
                    isPresented = false
                }
                                    
                )
            }
        }
        
        
        func saveContact() {
            let newContact = Contact(name: newName, phoneNumber: newPhoneNumber)
            contacts.append(newContact)
            isPresented = false
        }
    }
    
    
    
    var body: some View {
        NavigationView {
            HStack{
                VStack {
                    Divider()
                        .background(Color.black)
                        .frame(width: 350, height: 60)
                        .padding(.horizontal)
                        .padding(.top,-28)
                    
                    
                    // Your contact card
                    HStack {
                        Image("pooja")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(radius: 5)
                        
                        
                        VStack(alignment: .leading) {
                            Text(" Pooja Priya")
                                .font(.headline)
                            Text(" My Card")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        
                        
                        
                    }
                    .padding(.leading,-185)
                    .padding(.top,-28)
                    .padding()
                    
                    
                    // Your search bar
                    
                    
                    
                    VStack {
                        
                        
                        
                        List {
                            ForEach(contacts.sorted(by: { $0.name < $1.name})) { contact in
                                
                                let section = String(contact.name.prefix(1)).uppercased()
                                
                                if selectedSection == nil || section == selectedSection {
                                    
                                    Section(header: Text(section)) {
                                        
                                        NavigationLink(destination: Text("Details for \(contact.name)")) {
                                            Text(contact.name)
                                        }
                                    }
                                }
                            }
                            .onDelete(perform: deleteContact)
                        }.listStyle(.inset)
                            .navigationTitle("Contacts")
                            .searchable(text: $searchText){
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                    TextField("Search", text: $searchText)
                                    
                                }
                                
                            }
                        
                        
                        
                        
                        
                        
                    }
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading) {
                            
                            Button(action: {
                                
                                // Handle list title button action
                                print("List title button tapped")
                            }) {
                                
                                Image(systemName: "chevron.backward")
                                Text("Lists")
                                
                                
                            }
                            
                            
                            
                        }
                        
                        
                        ToolbarItem(placement: .navigationBarTrailing){
                            Button(action: {
                                isAddingContact = true
                            }) {
                                Image(systemName: "plus")
                                
                            }
                            
                            
                        }
                        
                    }
                    
                    .sheet(isPresented: $isAddingContact) {
                        AddContactView(isPresented: $isAddingContact, contacts: $contacts)
                        
                    }
                    .padding(.bottom,100)
                    .onAppear {
                        UITableView.appearance().separatorStyle = .none
                    }
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                }
            }
        }
        
    }
    
    
}



func deleteContact(at offsets: IndexSet) {
    
}


struct IndexNavigationView: View {
    let contacts: [String]
    let onTap: (String) -> Void
    
    var body: some View {
        ScrollViewReader { scrollView in
            VStack {
                Spacer()
                VStack(alignment: .trailing) {
                    ForEach(Array(Set(contacts)), id: \.self) { index in
                        Text(index)
                            .padding(.vertical, -5)
                            .onTapGesture {
                                onTap(index)
                            }
                    }
                }
                .padding(.top, 750)
                .padding(.trailing, 7)
            }
        }
    }
}



struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            HStack {
                TextField("Search", text: $text)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    .onTapGesture {
                        hideKeyboard()
                    }
                
                Button(action: {
                    self.text = ""
                    hideKeyboard()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .padding(-10)
                }
                .opacity(text == "" ? 0 : 1)
            }
            
        }
        VStack {
            Text("a")
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}






#Preview {
    ContentView()
}
