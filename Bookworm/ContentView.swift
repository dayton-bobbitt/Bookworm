//
//  ContentView.swift
//  Bookworm
//
//  Created by Dayton Bobbitt on 12/16/21.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(sortDescriptors: []) private var books: FetchedResults<Book>
    
    @State private var addBookIsPresented = false
    
    var body: some View {
        NavigationView {
            List(books) { book in
                NavigationLink {
                    BookDetailView(for: book)
                } label: {
                    BookListItem(
                        title: book.title!,
                        author: book.author!,
                        rating: book.rating
                    )
                }
            }
            .navigationTitle("Bookworm")
            .toolbar {
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
