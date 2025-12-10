//
//  DoctorList.swift
//  Summarizing_Lesson
//
//  Created by Evgeny Mastepan on 20.11.2025.
//

import SwiftUI

struct DoctorList: View {
    @Environment(AppViewModel.self) var viewModel

    var body: some View {
        Text("Список докторов")
            .padding()
        
        Button {
            viewModel.windowCase = .DoctorReview
        } label: {
            Text ("На доктора!")
                .padding()
                .frame(maxWidth: .infinity)
                .background(.red)
                .foregroundStyle(.white)
        }
        
        
        
    }
}

#Preview {
    DoctorList()
}
