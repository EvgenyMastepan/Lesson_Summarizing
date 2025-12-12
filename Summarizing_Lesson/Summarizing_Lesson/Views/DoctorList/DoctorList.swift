//
//  DoctorList.swift
//  Summarizing_Lesson
//
//  Created by Evgeny Mastepan on 20.11.2025.
//

import SwiftUI

struct DoctorList: View {
    @Environment(AppViewModel.self) var appViewModel
    @State private var viewModel = DoctorListViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Загрузка...")
            }
            else if let error = viewModel.error {
                VStack {
                    Text("Ошибка загрузки:")
                        .font(.headline)
                    Text(error.localizedDescription)
                        .foregroundStyle(.red)
                    Button("Повторить") {
                        viewModel.loadDoctors()
                    }
                }
            }
            else if let doctors = viewModel.doctors {
                List(doctors) { doctor in
                    VStack(alignment: .leading) {
                        Text(doctor.fullname)
                            .font(.headline)
                        Text("Специализации: \(doctor.specialization.map {$0.name }.joined(separator: ", "))")
                            .font(.caption)
                        Text("Рейтинг: \(doctor.ratingsRating, specifier: "%.1f")")
                            .font(.subheadline)
                        Button("Забронировать время") {
                            appViewModel.windowCase = .DoctorSchedule
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(!doctor.hasFreeAppointment)
                    }
                    .padding()
                }
            }
            else {
                Text("Нажмите для загрузки списка докторов")
                Button("Загрузить") {
                    viewModel.loadDoctors()
                }
            }
        }
        .task {
            viewModel.loadDoctors()
        }
        .padding()
    }
}

#Preview {
    DoctorList()
}
