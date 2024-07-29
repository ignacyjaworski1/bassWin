//
//  GradeMakerView.swift
//  bassWinTrophy
//
//  Created by admin on 7/29/24.
//



import SwiftUI

struct GradeMakerView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = GradeMakerViewModel()
    @State private var tfName = ""
    
    @State private var imageToShare: UIImage?
    @State private var isSnapshotShown = false
    
    @State private var isEditorShown = false
    
    @State private var gradeTextToChange = "?"
    @State private var gradeIndexToChange = 0
    @State private var gradeColorToChange = Color.gray
    

    @State private var isTitleShown = true
    
    var realmGrade: FisherGradeList?
    var completion: () -> ()
    var hidingTab: () -> ()
    
    var body: some View {
        ZStack {
            BackgroundView()
            if !vm.grades.isEmpty && !vm.colors.isEmpty {
                VStack {
                    
                    if isTitleShown  {
                        //MARK: - Title
                        HStack(spacing: 10) {
                            Button {
                                dismiss()
                                completion()
                            } label: {
                                Image(systemName: "xmark")
                            }
                            
                            Spacer()
                            
                            if let _ = realmGrade {
                                Button {
                                   snap()
                                } label: {
                                    Image(systemName: "camera.shutter.button")
                                }
                                .padding(.trailing)
                            }
                            
                            Button {
                                realSave()
                            } label: {
                                Text("Save")
                            }
                        }
                        .foregroundColor(.white)
                        .padding(.top)
                        .padding(.horizontal, 20)
                        .overlay {
                            HStack {
                                Spacer()
                                
                                Text("Grade List")
                                    .font(.system(size: 28, weight: .black))
                                    .foregroundColor(.white)
                                    .padding(.top, 10)
                                Spacer()
                            }
                        }
                    }
                    
                    //MARK: - NAME
                    TextField("Enter a name for the list", text: $tfName)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .frame(width: screenSize().width - 30)
                        .foregroundStyle(.black)
                        .tint(.black)
                    
                    //MARK: - GRADES
                    ScrollView {
                        HStack {
                            VStack {
                                ForEach(0..<vm.grades.count, id: \.self) { index in
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 60, height: 100)
                                            .cornerRadius(12)
                                            .foregroundColor(vm.colors[index])
                                            .overlay {
                                                if vm.grades[index] == "?" {
                                                    Image(systemName: "hand.tap")
                                                        .font(.system(size: 32, weight: .bold, design: .monospaced))
                                                        .foregroundColor(.white)
                                                } else {
                                                    Text(vm.grades[index])
                                                        .font(.system(size: 32, weight: .bold, design: .monospaced))
                                                        .foregroundColor(.white)
                                                }
                                                
                                            }
                                    }
                                    .onTapGesture {
                                        gradeIndexToChange = index
                                        gradeTextToChange = vm.grades[index]
                                        gradeColorToChange = vm.colors[index]
                                        isEditorShown.toggle()
                                    }
                                }
                            }
                            
                            VStack {
                                ForEach(0..<vm.gradeCategory.count, id: \.self) { index in
                                    GradeCellView(gradeElement: $vm.gradeCategory[index])
                                    
                                }
                                
                            }
                        }
                        .padding(.top, 10)
                        
                        //MARK: - AddNewLine
                        if isTitleShown {
                            Button {
                                withAnimation {
                                    someFunc()
                                }
                                
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .frame(height: 80)
                                        .cornerRadius(12)
                                        .foregroundColor(.black)
                                    
                                    Text("Add new line")
                                        .foregroundStyle(.white)
                                }
                            }
                            .padding(.horizontal, 10)
                            .padding(.top)
                        }
                    }
                    
                    .padding(.horizontal)
                    .hideScrollIndicator()
                    
                    
                }
            }
        }
        .onAppear {
            hidingTab()
        }
        .sheet(isPresented: $isEditorShown) {
            ZStack {
                BackgroundView()
                    
                VStack {
                    Rectangle()
                        .frame(width: 60, height: 100)
                        .cornerRadius(12)
                        .foregroundColor(gradeColorToChange)
                        .overlay {
                            Text(gradeTextToChange)
                                .font(.system(size: 32, weight: .bold, design: .monospaced))
                                .foregroundColor(.white)
                        }
                        .padding(.top, 100)
                    
                    TextField("Enter a name for the list", text: $gradeTextToChange)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(12)
                        .frame(width: screenSize().width - 30)
                        .foregroundStyle(.white)
                        .padding(.top, 50)
                    
                    ColorPicker("Change grade color", selection: $gradeColorToChange, supportsOpacity: false)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(12)
                        .frame(width: screenSize().width - 30)
                        .foregroundStyle(.white)
                    
                    Button {
                        save()

                        
                        isEditorShown.toggle()
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 100, height: 60)
                                .cornerRadius(12)
                                .foregroundColor(.green)
                            
                            Text("Apply")
                                .foregroundColor(.white)
                        }
                        
                    }
                    .padding(.top, 50)
                    
                    Spacer()
                }
                
               
                
            }
            .overlay {
                VStack {
                    ZStack {
                        Text("Edit Grade")
                            .font(.title)
                            .bold()
                            .foregroundStyle(.white)
                            .padding(.top, 30)
                        
                        HStack {
                            Button {
                                isEditorShown.toggle()
                            } label: {
                                 Image(systemName: "xmark")
                            }
                            .padding(.top, 35)
                            .padding(.leading, 20)
                            .foregroundColor(.white)
                            
                            Spacer()
                        }
                    }
                    
                    Spacer()
                }
            }
            .ignoresSafeArea()
        }
        //MARK: - ChangeTier
        .fullScreenCover(isPresented: $isSnapshotShown) {
            if let image = imageToShare {
                SharingImage(image: image) {
                    isTitleShown = true
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationBarHidden(true)
        .onAppear {
            prepare()
        }
    }
    
    func realSave() {
        if let grade = realmGrade {
            StorageManager.shared.updateCustomGradeList(id: grade.id, name: tfName, list: vm.gradeCategory)
            dismiss()
            completion()
        } else {
            if !vm.gradeCategory.isEmpty {
                StorageManager.shared.createNewCustomGradeList(name: tfName, list: vm.gradeCategory)
                dismiss()
                completion()
            }
        }
    }
    
    func snap() {
        isTitleShown = false
        imageToShare = createSnapshot()
        isSnapshotShown.toggle()
    }
    
    func prepare() {
        if let list = realmGrade {
            vm.grades = []
            vm.colors = []
            vm.gradeCategory = []
                          
            for element in Array(list.gradeList) {
                let newElement = FisherGradeElement()
                newElement.note = element.note
                newElement.image = element.image
                newElement.color = element.color
                newElement.grade = element.grade
                vm.gradeCategory.append(newElement)
            }
            
            tfName = list.name

            for element in vm.gradeCategory {
                vm.grades.append(element.grade)
                vm.colors.append(vm.colorObjectToColor(colorObject: element.color ?? ColorObject()))
            }
        } else {
            vm.createGradeList()
           
            vm.grades = []
            vm.colors = []
            if let grade = vm.gradeCategory.first?.grade, let color = vm.gradeCategory.first?.color {
                vm.grades.append(grade)
                vm.colors.append(vm.colorObjectToColor(colorObject: color))
            }
        }
    }
    
    func someFunc() {
        let newLine = FisherGradeElement()
        let newColor = ColorObject()
        newColor.red = 0.5
        newColor.green = 0.5
        newColor.blue = 0.5
        newColor.alpha = 1
        
        newLine.color = newColor
        newLine.grade = "?"
        
        
        vm.grades.append(newLine.grade)
        vm.colors.append(vm.colorObjectToColor(colorObject: newColor))
        vm.gradeCategory.append(newLine)
    }
    
    func save() {
        vm.grades[gradeIndexToChange] = gradeTextToChange
        vm.colors[gradeIndexToChange] = gradeColorToChange
        
        vm.gradeCategory[gradeIndexToChange].grade = gradeTextToChange
        vm.gradeCategory[gradeIndexToChange].color = vm.colorToColorObject(color: gradeColorToChange)
    }
}

#Preview {
    GradeMakerView(){
        
    } hidingTab: {
        
    }
}
