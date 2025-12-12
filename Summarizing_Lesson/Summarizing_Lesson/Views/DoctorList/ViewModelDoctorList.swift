//
//  ViewModelDoctorList.swift
//  Summarizing_Lesson
//
//  Created by Evgeny Mastepan on 12.12.2025.
//

import Foundation
import Observation

@Observable
class DoctorListViewModel {
    enum LoadingState {
        case idle
        case loading
        case loaded([Doctor])
        case failed(Error)
    }
    
    private let networkService: NetworkProtocol
    var state: LoadingState = .idle
    
    init(networkService: NetworkProtocol = Network()) {
        self.networkService = networkService
    }
    
    func loadDoctors() {
        Task {
            await MainActor.run {
                self.state = .loading
            }
            
            do {
                let doctors = try await networkService.loadUsers()
                await MainActor.run {
                    self.state = .loaded(doctors)
                }
            } catch {
                await MainActor.run {
                    self.state = .failed(error)
                }
            }
        }
    }
    
    // Получение списка врачей из состояния
    var doctors: [Doctor]? {
        if case .loaded(let doctors) = state {
            return doctors
        }
        return nil
    }
    
    // Проверка загрузки списка
    var isLoading: Bool {
        if case .loading = state {
            return true
        }
        return false
    }
    
    // Получение ошибок
    var error: Error? {
        if case .failed(let error) = state {
            return error
        }
        return nil
    }
}
