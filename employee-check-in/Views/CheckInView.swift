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
        .task {
            viewModel.getCheckInDateTime()
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
        print(viewModel.checkInDateTime)
    }
}

#Preview {
    CheckInView()
}
