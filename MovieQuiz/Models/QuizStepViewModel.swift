//
//  QuizStepViewModel.swift
//  MovieQuiz
//
//  Created by Nikita Khon on 29.12.2024.
//

import UIKit

struct QuizStepViewModel {
    /// картинка с афишей фильма с типом UIImage
    let image: UIImage
    /// строка с вопросом о рейтинге фильма
    let question: String
    /// строка с порядковым номером этого вопроса (ex. "1/10")
    let questionNumber: String
}
