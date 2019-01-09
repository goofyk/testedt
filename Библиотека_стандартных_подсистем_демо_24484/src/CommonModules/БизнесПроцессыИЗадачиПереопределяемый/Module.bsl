#Область ПрограммныйИнтерфейс

// Вызывается для обновления данных бизнес-процесса в регистре сведений ДанныеБизнесПроцессов.
//
// Параметры:
//  Запись - РегистрСведенийЗапись.ДанныеБизнесПроцессов - Запись данных бизнес-процесса.
//
Процедура ПриЗаписиСпискаБизнесПроцессов(Запись) Экспорт
	
КонецПроцедуры

// Вызывается для проверки прав на остановку и продолжение бизнес-процесса
// у текущего пользователя.
//
// Параметры:
//  БизнесПроцесс        - БизнесПроцессСсылка - ссылка на бизнес-процесс.
//  ЕстьПрава            - Булево              - если установить Ложь, то прав нет.
//  СтандартнаяОбработка - Булево              - если установить Ложь, то стандартная проверка прав не будет выполнена.
//
Процедура ПриПроверкеПравНаОстановкуБизнесПроцесса(БизнесПроцесс, ЕстьПрава, СтандартнаяОбработка) Экспорт
	
КонецПроцедуры

// Вызывается для заполнения реквизита ГлавнаяЗадача из данных заполнения.
//
// Параметры:
//  БизнесПроцессОбъект  - БизнесПроцессОбъект - бизнес-процесс.
//  ДанныеЗаполнения     - Произвольный        - данные заполнения, которые передаются в обработчик заполнения.
//  СтандартнаяОбработка - Булево              - если установить Ложь, то стандартная обработка заполнения не будет
//                                               выполнена.
//
Процедура ПриЗаполненииГлавнойЗадачиБизнесПроцесса(БизнесПроцессОбъект, ДанныеЗаполнения, СтандартнаяОбработка) Экспорт
	
КонецПроцедуры

// Вызывается для заполнения параметров формы задачи.
//
// Параметры:
//  ИмяБизнесПроцесса           - Строка                         - название бизнес-процесса.
//  ЗадачаСсылка                - ЗадачаСсылка.ЗадачаИсполнителя - задача.
//  ТочкаМаршрутаБизнесПроцесса - ТочкаМаршрутаБизнесПроцессаСсылка.Задание - действие.
//  ПараметрыФормы              - Структура                      - описание выполнения задачи со свойствами:
//   * ИмяФормы       - имя формы, передаваемое в метод ОткрытьФорму. 
//   * ПараметрыФормы - содержит параметры открываемой формы.
//
// Пример:
//  Если ИмяБизнесПроцесса = "Задание" Тогда
//      ИмяФормы = "БизнесПроцесс.Задание.Форма.ВнешнееДействие" + ТочкаМаршрутаБизнесПроцесса.Имя;
//      ПараметрыФормы.Вставить("ИмяФормы", ИмяФормы);
//  КонецЕсли;
//
Процедура ПриПолученииФормыВыполненияЗадачи(ИмяБизнесПроцесса, ЗадачаСсылка,
	ТочкаМаршрутаБизнесПроцесса, ПараметрыФормы) Экспорт
	
КонецПроцедуры

// Заполняет список бизнес-процессов, которые подключены к подсистеме
// и модули менеджеров которых содержат следующие экспортные процедуры и функции:
//  - ПриПеренаправленииЗадачи.
//  - ФормаВыполненияЗадачи.
//  - ОбработкаВыполненияПоУмолчанию.
//
// Параметры:
//   ПодключенныеБизнесПроцессы - Соответствие - в качестве ключа указать полное имя объекта метаданных,
//                                               подключенного к подсистеме "Бизнес-процессы и задачи".
//                                               В качестве значения - пустую строку.
//
// Пример:
//   ПодключенныеБизнесПроцессы.Вставить(Метаданные.БизнесПроцессы.ЗаданиеСРолевойАдресацией.ПолноеИмя(), "");
//
Процедура ПриОпределенииБизнесПроцессов(ПодключенныеБизнесПроцессы) Экспорт
	
	// _Демо начало примера
	ПодключенныеБизнесПроцессы.Вставить(Метаданные.БизнесПроцессы._ДемоЗаданиеСРолевойАдресацией.ПолноеИмя(), "");
	// _Демо конец примера
	
КонецПроцедуры

// Вызывается из модулей объектов подсистемы БизнесПроцессыИЗадачи для
// возможности настройки логики ограничения в прикладном решении.
//
// Пример заполнения наборов значений доступа см. в комментарии
// к процедуре УправлениеДоступом.ЗаполнитьНаборыЗначенийДоступа.
//
// Параметры:
//  Объект - БизнесПроцессОбъект.Задание - объект, для которого нужно заполнить наборы.
//  
//  Таблица - ТаблицаЗначений - возвращаемая функцией УправлениеДоступом.ТаблицаНаборыЗначенийДоступа.
//
Процедура ПриЗаполненииНаборовЗначенийДоступа(Объект, Таблица) Экспорт
	
	// _Демо начало примера
	// Подсистема "Управление доступом".
	
	_ДемоСтандартныеПодсистемы.ПриЗаполненииНаборовЗначенийДоступаБизнесПроцессов(Объект, Таблица)
	
	// Подсистема "Управление доступом".
	// _Демо конец примера
	
КонецПроцедуры

#КонецОбласти
