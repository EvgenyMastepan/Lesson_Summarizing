//
//  NetworkErrors.swift
//  Summarizing_Lesson
//
//  Created by Evgeny Mastepan on 12.12.2025.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case fileNotFound
    case decodingFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "Файл с данными не найден."
        case .decodingFailed(let underlyingError):
            return "Ошибка декодирования: \(underlyingError.localizedDescription)"
        }
    }
}
