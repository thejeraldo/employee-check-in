//
//  CheckInView.swift
//  employee-check-in
//
//  Created by Jerald Allen Abille on 10/30/24.
//

import SwiftUI

struct CheckInDateTime: Codable {
    var dateTime: String
}

struct CheckInView: View {
    
    @State var viewModel = CheckInViewModel()
    
    var hostingController: CheckInViewController?
    
    var body: some View {
        Form {
            Section {
                makeDatePicker()
                makeTimePicker()
                makeSubmitButton()
            } header: {
                Text("Please select a date and time to check-in.")
            }
            .selectionDisabled()
        }
        .alert(viewModel.successAlertMessage, isPresented: $viewModel.showSuccessAlert) {
            Button(action: { goBack() }, label: { Text("OK") })
        }
        .alert(isPresented: $viewModel.showErrorAlert, error: viewModel.checkInError, actions: {
            Button(action: {}, label: { Text("OK") })
        })
        .task {
            viewModel.setInitialCheckInDateTime()
        }
    }
}

// MARK: - Views

extension CheckInView {
    
    @ViewBuilder
    func makeDatePicker() -> some View {
        DatePicker(selection: $viewModel.checkInDateTime,
                   in: ...Date.now,
                   displayedComponents: .date, label: {
            Label("Date", systemImage: "calendar")
        })
        .datePickerStyle(.graphical)
        .foregroundStyle(Color(uiColor: .label))
        .padding(.top, 4)
    }
    
    @ViewBuilder
    func makeTimePicker() -> some View {
        DatePicker(selection: $viewModel.checkInDateTime,
                   in: ...Date.now,
                   displayedComponents: .hourAndMinute, label: {
            Label("Time", systemImage: "clock")
        })
        .foregroundStyle(Color(uiColor: .label))
        .padding(.top, 4)
    }
    
    @ViewBuilder
    func makeSubmitButton() -> some View {
        Button(action: didTapSubmitButton, label: {
            Text("Submit")
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .foregroundStyle(Color(uiColor: .label))
                .background(Color(uiColor: .systemFill))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.bottom, 4)
        })
    }

}

// MARK: - Actions

extension CheckInView {
    private func didTapSubmitButton() {
        guard viewModel.validateCheckInDateTime() else {
            return
        }
        viewModel.addCheckInTime()
    }
    
    private func goBack() {
        hostingController?.goBack()
    }
}

#Preview {
    CheckInView()
}
