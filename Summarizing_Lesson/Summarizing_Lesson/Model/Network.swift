//
//  DownloadData.swift
//  Summarizing_Lesson
//
//  Created by Evgeny Mastepan on 18.11.2025.
//

import SwiftUI

class Network: NetworkProtocol {
    func loadUsers() {
        guard let url = Bundle.main.url(forResource: "test", withExtension: "json") else {
            print("Файл не найден")
            return
        }
        guard let jsonData = try? Data(contentsOf: url) else {
            return
        }
        let users = try? JSONDecoder().decode(User.self, from: jsonData)
        
    }
}
