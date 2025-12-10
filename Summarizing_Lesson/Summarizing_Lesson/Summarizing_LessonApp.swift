//
//  Summarizing_LessonApp.swift
//  Summarizing_Lesson
//
//  Created by Evgeny Mastepan on 18.11.2025.
//

import SwiftUI

@main
struct Summarizing_LessonApp: App {
    @State var viewModel = AppViewModel()
    var body: some Scene {
        WindowGroup {
            switch viewModel.windowCase {
            case .DoctorList:
                DoctorList()
                    .environment(viewModel)
            case .DoctorReview:
                DoctorReview()
                    .environment(viewModel)
            case .DoctorSchedule:
                DoctorSchedule()
                    .environment(viewModel)
            }
        }
    }
}
