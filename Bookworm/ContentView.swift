//
//  ContentView.swift
//  Bookworm
//
//  Created by Dayton Bobbitt on 12/16/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var managedObjectContext
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title)
    ]) private var books: FetchedResults<Book>
    
    @State private var addBookIsPresented = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        BookDetailView(for: book)
                    } label: {
                        BookListItem(for: book)
                    }
                }
                .onDelete(perform: deleteBook(at:))
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        self.addBookIsPresented = true
                    } label: {
                        Label("Add book", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: self.$addBookIsPresented) {
                AddBookView()
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private func deleteBook(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            managedObjectContext.delete(book)
        }
        
        try? managedObjectContext.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
