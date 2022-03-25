//
//  SongRequestView.swift
//  yes
//
//  Created by MacBook on 2022-01-24.
//

import SwiftUI
import Metal

struct SongRequestView: View {
    @State private var songTitle = ""
    @State private var artistName = ""
    @State private var dedicatedTo = ""
    @State private var comment = ""
    var body: some View {
        
        VStack  {
            Text("Song Request")
                .font(.title)
                .foregroundColor(.white)
                .padding(20)
            
            VStack(alignment: .leading) {
                Text("Song Title")
                    .font(.headline)
                    .foregroundColor(.white)
                TextField("Manike mage hithe.....", text: $songTitle)
                    .font(.caption)
                    .padding(3)
                    .textFieldStyle(.roundedBorder)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
            }
            .padding(.horizontal, 20)
            VStack(alignment: .leading) {
                Text("Artist Name")
                    .font(.headline)
                    .foregroundColor(.white)
                TextField("Yohani and Satheeshan", text: $artistName)
                    .font(.caption)
                    .padding(3)
                    .textFieldStyle(.roundedBorder)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
            }
            .padding(.horizontal, 20)
            
            VStack(alignment: .leading) {
                Text("Dedicated to")
                    .font(.headline)
                    .foregroundColor(.white)
                TextField("to my mother,father,and wife", text: $dedicatedTo)
                    .font(.caption)
                    .padding(3)
                    .textFieldStyle(.roundedBorder)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
            }
            .padding(.horizontal, 20)
            
            VStack(alignment: .leading) {
                Text("Comment")
                    .font(.headline)
                    .foregroundColor(.white)
                TextView(
                    text: $comment
                )
                    .frame(height: 200)
                    .font(.caption)
                    .textFieldStyle(.roundedBorder)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                
            }
            .padding(.horizontal, 20)
            
            RoundedButton(songTitleText: songTitle, artistNameText: artistName, dedicatedToText: dedicatedTo, commentText: comment).padding(.top, 20)
            
        }
        .frame(width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height)
        // .padding(.top,UIScreen.main.bounds.height/30)
        .background(Color.black)
        .edgesIgnoringSafeArea(.top)
        
    }
}



struct RoundedButton : View {
    
    @State private var showingAlert = false
    @State private var messageText = "Plase enter the Song Requst Details"
    var songTitleText : String
    var artistNameText : String
    var dedicatedToText : String
    var commentText : String
    
    var body: some View {
        Button(action: {
            
            if  songTitleText.isEmpty  {
                self.showingAlert = true
                self.messageText = "Plase enter the Song Title"
            } else if artistNameText.isEmpty {
                self.showingAlert = true
                self.messageText = "Plase enter the Artist Name"
            } else if dedicatedToText .isEmpty {
                self.showingAlert = true
                self.messageText = "Plase enter the Dedicated Info"
            } else {
                let sms: String = "sms:+94755000101&body=" + "Request Song Details\n" + "Song Title : " + songTitleText + "\n" + "Artist Name : " + artistNameText + "\n" + "Dedicated To : " + dedicatedToText + "\n" + "Comment : " + commentText
                let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
            }
            
        }) {
            HStack {
                Spacer()
                Text("Request")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
            }
        }
        .padding(.vertical, 10.0)
        .background(Color.redMain)
        .padding(.horizontal,20)
        .alert(isPresented: $showingAlert, content: {
            Alert(title: Text("Error"), message: Text( messageText), dismissButton: .default(Text("OK")))
        })
    }
}

struct TextView: UIViewRepresentable {
    @Binding var text: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        
        let myTextView = UITextView()
        myTextView.delegate = context.coordinator
        
        myTextView.font = UIFont(name: "HelveticaNeue", size: 15)
        myTextView.isScrollEnabled = true
        myTextView.isEditable = true
        myTextView.isUserInteractionEnabled = true
        myTextView.backgroundColor = UIColor(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        myTextView.textColor = UIColor.black
        
        return myTextView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    class Coordinator : NSObject, UITextViewDelegate {
        
        var parent: TextView
        
        init(_ uiTextView: TextView) {
            self.parent = uiTextView
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }
        
        func textViewDidChange(_ textView: UITextView) {
            //            print("text now: \(String(describing: textView.text!))")
            self.parent.text = textView.text
        }
    }
}

struct SongRequestView_Previews: PreviewProvider {
    static var previews: some View {
        SongRequestView()
    }
}
