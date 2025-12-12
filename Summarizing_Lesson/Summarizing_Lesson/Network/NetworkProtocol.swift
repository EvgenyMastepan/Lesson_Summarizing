//
//  NetworkProtocol.swift
//  Summarizing_Lesson
//
//  Created by Evgeny Mastepan on 18.11.2025.
//

protocol NetworkProtocol {
    func loadUsers() async throws -> [Doctor]
}
