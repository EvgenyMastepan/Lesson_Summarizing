//
//  AppViewModel.swift
//  Summarizing_Lesson
//
//  Created by Evgeny Mastepan on 20.11.2025.
//

import SwiftUI

enum WindowCase {
    case DoctorList
    case DoctorReview
    case DoctorSchedule
}

@Observable
class AppViewModel {
    var windowCase: WindowCase = .DoctorList
}
