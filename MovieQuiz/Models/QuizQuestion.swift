//
//  QuizQuestion.swift
//  MovieQuiz
//
//  Created by Nikita Khon on 29.12.2024.
//

import Foundation

struct QuizQuestion {
    /// дата для составления постера
    let imageData: Data
    /// строка с вопросом о рейтинге фильма
    let text: String
    /// булевое значение (true, false), правильный ответ на вопрос
    let correctAnswer: Bool
}
