//
//  DownloadData.swift
//  Summarizing_Lesson
//
//  Created by Evgeny Mastepan on 18.11.2025.
//

import Foundation

class Network: NetworkProtocol {
    func loadUsers() async throws -> [Doctor] {
        // Имя файла.
        guard let url = Bundle.main.url(forResource: "test", withExtension: "json") else {
            throw NetworkError.fileNotFound
        }

        // Читаем
        let jsonData = try Data(contentsOf: url)
        
        do {
            // Декодируем
            let response = try JSONDecoder().decode(DoctorsResponse.self, from: jsonData)
            // Возвращаем только врачей
            return response.data.users
        } catch let DecodingError.keyNotFound(key, context) {
            // Теперь тут расширенная обработка ошибок, потому что я задрался парсить этот кривой json.
            throw NetworkError.decodingFailed(
                NSError(domain: "DecodingError", code: 0,
                        userInfo: [NSLocalizedDescriptionKey:
                                   "Не найден ключ '\(key.stringValue)' при декодировании. Path: \(context.codingPath.map { $0.stringValue }.joined(separator: "."))"])
            )
        } catch let DecodingError.valueNotFound(expectedType, context) {
            // Ошибка: значение не найдено
            throw NetworkError.decodingFailed(
                NSError(domain: "DecodingError", code: 0,
                        userInfo: [NSLocalizedDescriptionKey:
                                   "Ожидалось значение типа \(expectedType) при декодировании, но оно отсутствует или null. Path: \(context.codingPath.map { $0.stringValue }.joined(separator: "."))"])
            )
        } catch let DecodingError.typeMismatch(type, context) {
            // Ошибка несоответствие типа
            throw NetworkError.decodingFailed(
                NSError(domain: "DecodingError", code: 0,
                        userInfo: [NSLocalizedDescriptionKey:
                                   "Несоответствие типа данных для \(type). Path: \(context.codingPath.map { $0.stringValue }.joined(separator: "."))"])
            )
        } catch {
            // Любая другая ошибка декодирования
            throw NetworkError.decodingFailed(error)
        }
    }
}
