//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Nikita Khon on 29.12.2024.
//

import Foundation

final class StatisticService {
    private let storage: UserDefaults = .standard
    
    private enum Keys: String {
        case bestGameCorrect
        case bestGameTotal
        case bestGameDate
        case gamesCount
        case cumulativeCorrect
    }
    
    private var correctAnswers: Int {
        get {
            storage.integer(forKey: Keys.cumulativeCorrect.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.cumulativeCorrect.rawValue)
        }
    }
}

extension StatisticService: StatisticServiceProtocol {
    var gamesCount: Int {
        get {
            storage.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameResult {
        get {
            GameResult(
                correct: storage.integer(forKey: Keys.bestGameCorrect.rawValue),
                total: storage.integer(forKey: Keys.bestGameTotal.rawValue),
                date: storage.object(forKey: Keys.bestGameDate.rawValue) as? Date ?? Date()
            )
        }
        set {
            storage.set(newValue.correct, forKey: Keys.bestGameCorrect.rawValue)
            storage.set(newValue.total, forKey: Keys.bestGameTotal.rawValue)
            storage.set(newValue.date, forKey: Keys.bestGameDate.rawValue)
        }
    }
    
    var totalAccuracy: Double {
        get {
            guard correctAnswers != 0 else { return Double(0) }
            
            return Double((correctAnswers * 100)/(gamesCount * 10))
        }
    }
    
    func store(correct count: Int, total amount: Int) {
        gamesCount += 1
        correctAnswers += count
        
        let newChallenger = GameResult(correct: count, total: amount, date: Date())
        if newChallenger.isBetterThan(bestGame) {
            bestGame = newChallenger
        }
    }
}
