//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by Nikita Khon on 29.12.2024.
//

import Foundation

final class QuestionFactory: QuestionFactoryProtocol {
    
    private let moviesLoader: MoviesLoading
    private weak var delegate: QuestionFactoryDelegate?
    private var movies: [MostPopularMovie] = []
    
    init(moviesLoader: MoviesLoading, delegate: QuestionFactoryDelegate?) {
        self.moviesLoader = moviesLoader
        self.delegate = delegate
    }
    
    func requestNextQuestion() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            let index = (0..<self.movies.count).randomElement() ?? 0
            
            guard let movie = self.movies[safe: index] else { return }
            
            var imageData = Data()
            
            do {
                imageData = try Data(contentsOf: movie.resizedImageURL)
            } catch {
                print("Failed to load image")
            }
            
            let rating = Float(movie.rating) ?? 0
            let randomInt = Int.random(in: 7...9)
            
            let text = "Рейтинг этого фильма больше чем \(randomInt)?"
            let correctAnswer = rating > Float(randomInt)
            
            let question = QuizQuestion(imageData: imageData,
                                        text: text,
                                        correctAnswer: correctAnswer)
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.delegate?.didReceiveNextQuestion(question: question)
            }
        }
    }
    
    func loadData() {
        moviesLoader.loadMovies { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let mostPopularMovies):
                    self.movies = mostPopularMovies.items
                    self.delegate?.didLoadDataFromServer()
                case .failure(let error):
                    self.delegate?.didFailToLoadData(with: error)
                }
            }
        }
    }
}

/*
 Mock-данные
 
 
 Картинка: The Godfather
 Настоящий рейтинг: 9,2
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Dark Knight
 Настоящий рейтинг: 9
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Kill Bill
 Настоящий рейтинг: 8,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Avengers
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Deadpool
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Green Knight
 Настоящий рейтинг: 6,6
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Old
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: The Ice Age Adventures of Buck Wild
 Настоящий рейтинг: 4,3
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: Tesla
 Настоящий рейтинг: 5,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: Vivarium
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 private let questions: [QuizQuestion] = [
     QuizQuestion(
         imageName: "The Godfather",
         text: "Рейтинг этого фильма больше чем 6?",
         correctAnswer: true),
     QuizQuestion(
         imageName: "The Dark Knight",
         text: "Рейтинг этого фильма больше чем 6?",
         correctAnswer: true),
     QuizQuestion(
         imageName: "Kill Bill",
         text: "Рейтинг этого фильма больше чем 6?",
         correctAnswer: true),
     QuizQuestion(
         imageName: "The Avengers",
         text: "Рейтинг этого фильма больше чем 6?",
         correctAnswer: true),
     QuizQuestion(
         imageName: "Deadpool",
         text: "Рейтинг этого фильма больше чем 6?",
         correctAnswer: true),
     QuizQuestion(
         imageName: "The Green Knight",
         text: "Рейтинг этого фильма больше чем 6?",
         correctAnswer: true),
     QuizQuestion(
         imageName: "Old",
         text: "Рейтинг этого фильма больше чем 6?",
         correctAnswer: false),
     QuizQuestion(
         imageName: "The Ice Age Adventures of Buck Wild",
         text: "Рейтинг этого фильма больше чем 6?",
         correctAnswer: false),
     QuizQuestion(
         imageName: "Tesla",
         text: "Рейтинг этого фильма больше чем 6?",
         correctAnswer: false),
     QuizQuestion(
         imageName: "Vivarium",
         text: "Рейтинг этого фильма больше чем 6?",
         correctAnswer: false)
 ]
 
*/
