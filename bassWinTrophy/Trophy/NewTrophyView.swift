//
//  NewTrophyView.swift
//  bassWinTrophy
//
//  Created by admin on 7/29/24.
//




import SwiftUI

class NewTrophyViewModel: ObservableObject {
    
    @Published var fishWeight = ""
    @Published var notion = ""
}



struct NewTrophyView: View {
    
    @StateObject private var vm = NewTrophyViewModel()
    @State var isBottomView = false
    @State var image: UIImage?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                
                Text("Add new Trophy")
                    .bold()
                    .font(.largeTitle)
                    .padding(.top, 10)
                    .foregroundColor(.white)
                
                if let photo = image {
                    Image(uiImage: photo)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)

                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(.horizontal)
                } else {
                    Button {
                        isBottomView.toggle()
                    } label: {
                        ZStack {
                            
                            Image(systemName: "camera")
                                .foregroundColor(.white)
                                .font(.system(size: 32))
                            
                            Rectangle()
                                .fill(Color.black.opacity(0.5))
                                .frame(width: screenSize().width - 30, height: 100)
                                .cornerRadius(12)
                        }
                    }
                    .padding(.bottom, -15)
                }
                
                VStack {
                    TextField("", text: $vm.fishWeight)
                        .textFieldStyle(.plain)
                        .foregroundColor(.white)
                        .tint(Color.white)
                        .padding(10)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(5)
                        .background {
                            VStack {
                                HStack {
                                    Text(vm.fishWeight.isEmpty ? "Theme / Fish Weight" : "")
                                        .foregroundStyle(.white.opacity(0.5))
                                    Spacer()
                                }
                                Spacer()
                            }
                            .padding(.top, 10)
                            .padding(.leading, 10)
                        }
                    
                    ZStack {
                        Rectangle()
                            .frame(height: 100)
                            .cornerRadius(12)
                            .foregroundColor(Color.black.opacity(0.5))
                            .overlay {
                                TextEditor(text: $vm.notion)
                                    .scrollContentBackground(.hidden)
                                    .frame(height: 100)
                                    .padding(.horizontal, 5)
                                    .foregroundColor(.white)
                                    .foregroundColor(Color.black.opacity(0.5))
                                    .cornerRadius(12)
                                    .background {
                                        VStack {
                                            HStack {
                                                Text(vm.notion.isEmpty ? "Notation" : "")
                                                    .foregroundStyle(.white.opacity(0.23))
                                                Spacer()
                                            }
                                            Spacer()
                                        }
                                        .padding(10)
                                    }
                            }
                    }
                }
                .padding()
                
                Button {
                    StorageManager.shared.saveTrophy(
                        photo: image,
                        weight: vm.fishWeight,
                        notion: vm.notion,
                        lon: 0,
                        lat: 0)
                    dismiss()
                } label: {
                    Text("Save")
                }
                .buttonStyle(.bordered)
                
                Button(role: .destructive) {
                   dismiss()
                } label: {
                    Text("Cancel")
                }
                .padding(.top, 10)
                Spacer()
            }
        }
        .sheet(isPresented: $isBottomView) {
            BottomSheetView(selectedImage: $image) {
                withAnimation {
                    isBottomView = false
                }
            } closing: {
                isBottomView = false
            }
             .presentationDetents([.height(120)])
        }
    }
}

struct AddTrophyView_Previews: PreviewProvider {
    static var previews: some View {
        NewTrophyView()
    }
}


