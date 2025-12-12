//
//  UserModel.swift
//  Summarizing_Lesson
//
//  Created by Evgeny Mastepan on 18.11.2025.
//
import Foundation

struct DoctorsResponse: Codable {
    let count: Int // Общее количество врачей
    let previous: String? // Предуыдущая страница результатов
    let message: String // Сообщение сервера об операции
    let errors: String? // Поле для ошибок
    let data: DoctorsData // Собственно данные туть
}

struct DoctorsData: Codable {
    let users: [Doctor] // Массив объектов типа Доктор (Doctor)
}

struct Doctor: Codable, Identifiable {
    let id: String // Уникальный id врача
    let slug: String // Я не понял, что это. Тоже какой-то уникальный идентификатор. Возможно url странички доктора
    let firstName: String // Имя врача
    let patronymic: String? // Отчество (Может отсутствовать)
    let lastName: String // Фамилия врача
    let gender: String // Пол врача (0-муж. 1-жен.)
    let genderLabel: String // Текстовая метка для пола врача ("Мужчина")
    let specialization: [Specialization] // Массив специализаций врача (Может быть пустым)
    let ratings: [Rating] // Массив оценок
    let ratingsRating: Double // Общий средний рейтинг врача по всем параметрам
    let seniority: Int // Стаж работы врача в годах
    let textChatPrice: Int // Стоимость письменной консультации
    let videoChatPrice: Int // Стоимость консультации по видео
    let homePrice: Int // Стоимость консультации на дому
    let hospitalPrice: Int // Стоимость консультации в поликлинике
    let avatar: String? // URL аватарки врача
    let nearestReceptionTime: TimeInterval? // Время ближайшего приёма в формате Unix Timestamp
    let freeReceptionTime: [FreeTimeSlot] // Массив свободного времени для приёма
    let educationTypeLabel: EducationTypeLabel? // Объект информации об образовании
    let higherEducation: [Education] // Массив записей об образовании
    let workExperience: [WorkExperience] // Массив записей о рабочем стаже
    let advancedTraining: [AdvancedTraining] // Массив записей повышения квалификации
    let rank: Int // Код звания
    let rankLabel: String // Текстовая метка звания ("Доцент")
    let scientificDegree: Int // Код учёной степени
    let scientificDegreeLabel: String // Текстовая метка учёной степени ("Доктор медицинских наук)
    let category: Int // Код категории (0-3)
    let categoryLabel: String //Текстовая метка категории ("высшая")
    let isFavorite: Bool // Флаг добавления в избранное
    
    
    // Ключи для декодировки из JSON
    enum CodingKeys: String, CodingKey {
        case id, slug
        case firstName = "first_name"
        case patronymic
        case lastName = "last_name"
        case gender
        case genderLabel = "gender_label"
        case specialization
        case ratings
        case ratingsRating = "ratings_rating"
        case seniority
        case textChatPrice = "text_chat_price"
        case videoChatPrice = "video_chat_price"
        case homePrice = "home_price"
        case hospitalPrice = "hospital_price"
        case avatar
        case nearestReceptionTime = "nearest_reception_time"
        case freeReceptionTime = "free_reception_time"
        case educationTypeLabel = "education_type_label"
        case higherEducation = "higher_education"
        case workExperience = "work_expirience"             // Опечатка в JSON ("work_expirience")
        case advancedTraining = "advanced_training"
        case rank
        case rankLabel = "rank_label"
        case scientificDegree = "scientific_degree"
        case scientificDegreeLabel = "scientific_degree_label"
        case category
        case categoryLabel = "category_label"
        case isFavorite = "is_favorite"
        
    }
    
    //MARK: -- Вычисляемые свойства для удобства
    
    // Полное имя врача
    var fullname: String {
        let middleName = patronymic?.isEmpty == false ? " \(patronymic!)" : ""
        return "\(firstName) \(middleName) \(lastName)"
    }
    
    // Наличие у врача свободной брони
    var hasFreeAppointment: Bool {
        return !freeReceptionTime.isEmpty
    }
    
    // Возвращает Timestamp ближайшего времени приёма в Date
    var nearestAppointmentDate: Date? {
        guard let timeInterval = nearestReceptionTime else { return nil }
        return Date(timeIntervalSince1970: TimeInterval(timeInterval))
    }
    
}
    
    // MARK: -- Прочие и вспомогательные

// Специализация
struct Specialization: Codable, Identifiable {
    let id: Int // Уникальный id специализации
    let name: String // Название
    let isModerated: Bool // Флаг подтверждения модератором
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case isModerated = "is_moderated"
    }
}

// Рейтинг
struct Rating: Codable {
    let id: Int // Уникальный id рейтинга
    let name: String // Название
    let value: Double // Значение
}

// Свободный приём
struct FreeTimeSlot: Codable {
    let time: TimeInterval // Время приема
    var date: Date { // В формате даты
        return Date(timeIntervalSince1970: TimeInterval(time))
    }
}

// Тип образования
struct EducationTypeLabel: Codable {
    let id: Int // Уникальный id
    let name: String // Название
}

// Образование
struct Education: Codable {
    let id: Int // Уникальный id
    let university: String // Название ВУЗа
    let specialization: String // Специализация обучения
    let qualification: String // Полученная квалификация
    let startDate: TimeInterval // Дата начала обучения
    let endDate: TimeInterval // Дата окончания обучнеия
    let untilNow: Bool // Флаг длящегося обучения
    let isModerated: Bool // Флаг подтверждения модератором
    
    enum CodingKeys: String, CodingKey {
        case id, university, specialization, qualification
        case startDate = "start_date"
        case endDate = "end_date"
        case untilNow = "until_now"
        case isModerated = "is_moderated"
    }
}

// Трудовой опыт
struct WorkExperience: Codable {
    let id: Int // Уникальный id
    let organization: String // Организация
    let position: String // Должность
    let startDate: TimeInterval // Дата начала работы
    let endDate: TimeInterval? // Дата окончания работы
    let untilNow: Bool // Флаг длящегося обучения
    let isModerated: Bool // Подтверждено ли модератором
    
    enum CodingKeys: String, CodingKey {
        case id, organization, position
        case startDate = "start_date"
        case endDate = "end_date"
        case untilNow = "until_now"
        case isModerated = "is_moderated"
    }
}

// Курсы повышения квалификации
struct AdvancedTraining: Codable {
    let id: Int // Уникальный id
        let organization: String // Организация, проводившая обучение
        let position: String // Название курса или специализации
        let endDate: TimeInterval // Дата окончания курса
        let file: String // Путь к файлу сертификата
        let isModerated: Bool // Подтверждено ли модератором
        
    enum CodingKeys: String, CodingKey {
        case id, organization, position
        case endDate = "end_date"
        case file
        case isModerated = "is_moderated"
    }
}
