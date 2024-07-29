//
//  SettingsView.swift
//  bassWinTrophy
//
//  Created by admin on 7/29/24.
//



import SwiftUI
import MessageUI


struct SettingsView: View {
    
    @State private var showingMailWithError = false
    @State private var showingMailWithSuggestion = false
    @State private var isAnimationShown = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                
                VStack {
                    HStack {
                        Text("Settings")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .bold()
                            .padding(.top)
                            .padding(.leading)
                        
                        Spacer()
                    }
                    .padding(.bottom, -20)
                    
                    Form {
                        Section {
                            Button {
                                showingMailWithError.toggle()
                            } label: {
                                Text("Report a bug")
                            }
                            .sheet(isPresented: $showingMailWithError) {
                                MailComposeView(isShowing: $showingMailWithError, subject: "Error message", recipientEmail: "ignacyjawo.rski@outlook.de", textBody: "")
                            }
                            
                            Button {
                                showingMailWithSuggestion.toggle()
                            } label: {
                                Text("Suggest improvement")
                            }
                            .sheet(isPresented: $showingMailWithSuggestion) {
                                MailComposeView(isShowing: $showingMailWithSuggestion, subject: "Improvement suggestion", recipientEmail: "ignacyjawo.rski@outlook.de", textBody: "")
                            }
                        } header: {
                            Text("Support")
                                .foregroundColor(Color.gray)
                        }
                        .listRowBackground(Color.black.opacity(0.5))
                        
                        Section {
                            Button {
                                openPrivacyPolicy()
                            } label: {
                                Text("Privacy Policy")
                            }
                        } header: {
                            Text("Usage")
                                .foregroundColor(Color.gray)
                        }
                        .listRowBackground(Color.black.opacity(0.5))
             
                        Section {
                            Text("Delete all data")
                                .contextMenu {
                                    Button {
                                        StorageManager.shared.deleteAllData()
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            fatalError("closed when deleted")
                                        }
                                    } label: {
                                        VStack {
                                            Text("Yes, I want to delete all data. The App will restart")
                                            Text("You will need to resrart the app")
                                        }
                                        
                                            
                                    }
                                    
                                    Button {
                                        
                                    } label: {
                                        Text("No, I changed my mind")
                                    }
                                }
                                .foregroundColor(Color.red)
                        } header: {
                            Text("Danger zone")
                                .foregroundColor(Color.red)
                        } footer: {
                            Text("Long press for action")
                                .foregroundColor(Color.gray)
                        }
                        .listRowBackground(Color.black.opacity(0.5))
                        
                    }
                    .tint(.white)
                .modifier(FormBackgroundModifier())
                }
            }
        }
    }
    
    func openPrivacyPolicy() {
        if let url = URL(string: "https://blazesportclub.shop/com.BlazeSportsClubs/Helena_Paulsen/privacy") {
            UIApplication.shared.open(url)
        }
    }
}
#Preview {
    SettingsView()
}


struct FormBackgroundModifier: ViewModifier {
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .scrollContentBackground(.hidden)
        } else {
            content
        }
    }
}

struct MailComposeView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    let subject: String
    let recipientEmail: String
    let textBody: String
    var onComplete: ((MFMailComposeResult, Error?) -> Void)?
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposer = MFMailComposeViewController()
        mailComposer.setSubject(subject)
        mailComposer.setToRecipients([recipientEmail])
        mailComposer.setMessageBody(textBody, isHTML: false)
        mailComposer.mailComposeDelegate = context.coordinator
        return mailComposer
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        let parent: MailComposeView
        
        init(_ parent: MailComposeView) {
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.isShowing = false
            parent.onComplete?(result, error)
        }
    }
}
