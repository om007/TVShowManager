//
//  AddNewView.swift
//  TVShowManager
//
//  Created by Om Prakash Shah on 7/25/21.
//

import SwiftUI
import Parse

// SCENE #2
struct AddNewView: View {
    @State private var title: String = ""
    @State private var yearOfRelease: String = ""
    @State private var numberOfSeasons: String = ""
    
    @State private var showConfirmDialog = false
    @State private var currentDialogObj: CombyneDialog?
    @State private var isLoading = false
    
    @Environment(\.presentationMode) var presentation
    
    let font_TF = Font.system(size: DimenConstants.fontSize_TF, weight: .light, design: .default)

    var body: some View {
        
        ScrollView {
            VStack(alignment: .center, spacing: DimenConstants.interItemSpacing) {
                Group {
                    TextField(StringConstants.title, text: $title)
                    TextField(StringConstants.yearOfRelease, text: $yearOfRelease).keyboardType(.numberPad)
                    TextField(StringConstants.numberOfSeasons, text: $numberOfSeasons).keyboardType(.numberPad)
                }
                .lineLimit(1)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(font_TF)
                .alert(item: $currentDialogObj) { dialogObj in
                    //Presenting RESULT STATUS dialog
                    Alert(title: Text(dialogObj.title),
                          message: Text(dialogObj.messege),
                          dismissButton: .default(Text(dialogObj.buttonTitle), action: {
                            //Pop this view from navigation stack, if the saving was SUCCESS.
                            if dialogObj.title == ResultStatus.success {
                                self.presentation.wrappedValue.dismiss()
                            }
                          }))
                }
                
                Divider()
                
                Button(action: {
                    hideKeyboard()

                    let isDateInValid = Int(yearOfRelease) ?? 0 < 1800
                    if title.isEmpty || yearOfRelease.isEmpty || isDateInValid { //No need seasons check needed since the default value will be set "1"
                        let title = "Validation Error!"
                        var messege = ""
                        if (title.isEmpty || yearOfRelease.isEmpty) {
                            messege = "Sorry, the Title and Year Of Release should not be empty."
                        } else {
                            messege = "Oops, please input valid show's Year Of Release date."
                        }
                        let buttonTitle = "OK"
                        currentDialogObj = CombyneDialog(title: title, messege: messege, buttonTitle: buttonTitle)
                        return
                    }
                    
                    //Show SAVE CONFIRMATION dialog if input seems alright
                    showConfirmDialog = true
                }, label: {})
                .buttonStyle(CombyneBlueButton(title: StringConstants.save))
                .disabled(isLoading) //Disable the button when saving TVShow info is in the process
                .alert(isPresented: $showConfirmDialog) {
                    //Presenting confirmation dialog
                    Alert(title: Text("Confirm"),
                          message: Text("Are you sure you want to save this show info?"),
                          primaryButton: .default(Text("Confirm"), action: {
                            saveTVInfo()
                          }),
                          secondaryButton: .cancel())
                }
                
                if isLoading {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
                
                Spacer()
            }
            .navigationTitle(StringConstants.navTitle_addNewTVShow)
        }
        .padding()
        .background(Color.blue.opacity(0.05))
        .onDisappear(perform: {
            hideKeyboard()
        })
    }
    
    //Methods
    func saveTVInfo() {
        isLoading = true
        
        //Saving TV Show info
        let tvShowData = PFObject(className: TVShowConstants.className)
        tvShowData[TVShowConstants.title] = title
        tvShowData[TVShowConstants.year] = yearOfRelease
        tvShowData[TVShowConstants.seasons] = numberOfSeasons.isEmpty ? "1" : numberOfSeasons

        tvShowData.saveInBackground(block: { (success, error) in
            if success {
                let title = "Success!"
                let messege = "Voila! Saved your show info successfully."
                let buttonTitle = "Great"
                currentDialogObj = CombyneDialog(title: title, messege: messege, buttonTitle: buttonTitle)
            } else {
                let title = "Error!"
                let messege = "Oops! Somwthing went wrong, try again later."
                let buttonTitle = "Ok"
                currentDialogObj = CombyneDialog(title: title, messege: messege, buttonTitle: buttonTitle)
            }
            isLoading = false
        })
    }
    
}


struct AddNewView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewView()
    }
}
