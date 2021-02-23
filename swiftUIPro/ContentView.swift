//
//  ContentView.swift
//  swiftUIPro
//
//  Created by 7080 on 2021/2/22.
//

import SwiftUI

struct ContentView : View {
    @State var select: Int = 0

    var body: some View {
        NavigationView {
            TabView(selection:$select) {
                OneView()
                .tabItem {
                    Text("第一个")
                }
                .tag(0)
                
                TwoView()
                .tabItem {
                    Text("第二个")
                }
                .tag(1)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .navigationTitle(select == 0 ? "第一个" : "第二个")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct OneView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var push: Bool = false

    var body: some View {
        VStack {
            TextField("Enter username", text: $username)
                .padding([.leading], 15)
                .font(.system(size: 18, weight: .bold, design: .default))
                .textFieldStyle(PlainTextFieldStyle())
                .frame(width: UIScreen.main.bounds.width-50, height: 50, alignment: .center)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black.opacity(0.5)))
                .padding(EdgeInsets(top: 50, leading: 25, bottom: 30, trailing: 25))
            SecureField("Enter password", text: $password)
                .padding([.leading, .trailing], 25)
                .padding([.bottom], 30)
                .font(.system(size: 18, weight: .bold, design: .default))
            Button(action: {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                push = true
            }, label: {
                Text("Sign In")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .bold, design: .default))
                    .frame(width: 100, height: 100, alignment: .center)
            })
            .buttonStyle(MybuttonStyle())
            
            NavigationLink("", destination: DetailView(username: $username, password: $password), isActive: $push)
            Spacer()
        }
        .background(Color.yellow)
    }
}

struct TwoView: View {
    @ObservedObject var viewModel = MovieViewModel()

    var body: some View {
        List(viewModel.movies) { movie in // 2
            HStack {
                VStack(alignment: .leading) {
                    Text(movie.title) // 3a
                        .font(.headline)
                    Text(movie.originalTitle) // 3b
                        .font(.subheadline)
                }
            }
        }
        .background(Color.pink)
    }
}

struct DetailView: View {
    @Binding var username: String
    @Binding var password: String

    var body: some View {
        Text("This is the detail view\nusername:\(username)\npassword:\(password)")
    }
}

struct MybuttonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color.red : Color.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
