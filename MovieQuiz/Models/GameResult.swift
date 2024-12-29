//
//  GameResult.swift
//  MovieQuiz
//
//  Created by Nikita Khon on 29.12.2024.
//

import Foundation

struct GameResult {
    let correct: Int
    let total: Int
    let date: Date
    
    // метод сравнения по количеству верных ответов
    func isBetterThan(_ another: GameResult) -> Bool {
        correct > another.correct
    }
    
    // метод для вывода форматированной строки
    func toString() -> String {
        return "\(correct)/\(total) (\(date.dateTimeString))"
    }
}
