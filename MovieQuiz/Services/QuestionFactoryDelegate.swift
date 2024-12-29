//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Nikita Khon on 29.12.2024.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
}
