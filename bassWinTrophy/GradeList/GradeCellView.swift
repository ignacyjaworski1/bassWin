//
//  GradeCellView.swift
//  bassWinTrophy
//
//  Created by admin on 7/29/24.
//



import SwiftUI


struct GradeCellView: View {
    
    @State private var isImagePickerShown: Bool = false
    @State private var image: UIImage?
    @Binding var gradeElement: FisherGradeElement
    
    
    var body: some View {
        ZStack {
            HStack {
                
                Button {
                    isImagePickerShown.toggle()
                } label: {
                    if let imageData = gradeElement.image, let imageui = UIImage(data: imageData) {
                        Image(uiImage: imageui)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .cornerRadius(12)
                            .foregroundColor(.black)
                    } else {
                        Rectangle()
                            .foregroundColor(Color.black.opacity(0.5))
                            .frame(width: 100, height: 100)
                            .cornerRadius(12)
                            .overlay {
                                Image(systemName: "plus")
                                .foregroundStyle(.white)
                            }
                    }
                }
                
                ZStack {
                    Rectangle()
                        .frame(height: 100)
                        .cornerRadius(12)
                        .foregroundColor(Color.black.opacity(0.5))
                        .overlay {
                            TextEditor(text: $gradeElement.note)
                                .scrollContentBackground(.hidden)
                                .frame(height: 100)
                                .padding(.horizontal)
                                .foregroundColor(.white)
                                .foregroundColor(Color.black.opacity(0.5))
                                .cornerRadius(12)
                        }
                }
            }
        }
        .sheet(isPresented: $isImagePickerShown) {
            BottomSheetView(selectedImage: $image) {
                withAnimation {
                    isImagePickerShown = false
                    
                    if let image = image {
                        gradeElement.image = image.pngData()
                    }
                }
            } closing: {
                isImagePickerShown = false
            }
             .presentationDetents([.height(120)])
        }
    }
}

#Preview {
    GradeCellView(gradeElement: .constant(FisherGradeElement()))
}

#Preview {
    GradeMakerView(){
        
    } hidingTab: {
        
    }
}
