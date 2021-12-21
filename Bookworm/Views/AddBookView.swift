//
//  AddBookView.swift
//  Bookworm
//
//  Created by Dayton Bobbitt on 12/17/21.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) private var managedObjectContext
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = ""
    @State private var rating = 3
    @State private var review = ""
    @State private var saveError = false
    
    private let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section("Details") {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Review") {
                    TextEditor(text: $review)
                    Rating(rating: $rating)
                }
            }
            .onSubmit(self.saveBook)
            .navigationTitle("Add book")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button(action: self.saveBook) {
                        Text("Save")
                    }
                    .disabled(!isValidBook)
                }
            }
            .alert("Something went wrong", isPresented: $saveError) {
                Button("Ok", role: .cancel) { }
            }
        }
    }
    
    private var isValidBook: Bool {
        !(self.title.isEmpty || self.author.isEmpty || self.genre.isEmpty)
    }
    
    private func saveBook() {
        guard isValidBook else {
            fatalError("Attempted to save an invalid book")
        }
        
        let book = Book(context: managedObjectContext)
        
        book.id = UUID()
        book.title = self.title
        book.author = self.author
        book.genre = self.genre
        book.rating = Int16(self.rating)
        book.review = self.review
        
        do {
            try managedObjectContext.save()
            self.presentationMode.wrappedValue.dismiss()
        } catch {
            print("Failed to save book to CoreData: \(error.localizedDescription)")
            self.saveError.toggle()
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
