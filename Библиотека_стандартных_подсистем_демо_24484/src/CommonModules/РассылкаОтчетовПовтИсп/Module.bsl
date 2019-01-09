#Область СлужебныеПроцедурыИФункции

// Таблица типов получателей в разрезах хранения и пользовательского представления этих типов.
//
// Возвращаемое значение: 
//   ТаблицаТипов - ТаблицаЗначений - Таблица типов получателей.
//       * ИОМД            - СправочникСсылка.ИдентификаторыОбъектовМетаданных - Ссылка, которая хранится в базе данных.
//       * ТипПолучателей  - ОписаниеТипов - Тип, которым ограничиваются значения списков получателей и исключенных.
//       * Представление   - Строка - Представление типа для пользователей.
//       * ОсновнойВидКИ   - СправочникСсылка.ВидыКонтактнойИнформации - Вид контактной информации: e-mail, по
//                                                                       умолчанию.
//       * ГруппаКИ        - СправочникСсылка.ВидыКонтактнойИнформации - Группа вида контактной информации.
//       * ПутьФормыВыбора - Строка - Путь к форме выбора.
//
Функция ТаблицаТиповПолучателей() Экспорт
	
	ТаблицаТипов = Новый ТаблицаЗначений;
	ТаблицаТипов.Колонки.Добавить("ИОМД", Новый ОписаниеТипов("СправочникСсылка.ИдентификаторыОбъектовМетаданных"));
	ТаблицаТипов.Колонки.Добавить("ТипПолучателей", Новый ОписаниеТипов("ОписаниеТипов"));
	ТаблицаТипов.Колонки.Добавить("Представление", Новый ОписаниеТипов("Строка"));
	ТаблицаТипов.Колонки.Добавить("ОсновнойВидКИ", Новый ОписаниеТипов("СправочникСсылка.ВидыКонтактнойИнформации"));
	ТаблицаТипов.Колонки.Добавить("ГруппаКИ", Новый ОписаниеТипов("СправочникСсылка.ВидыКонтактнойИнформации"));
	ТаблицаТипов.Колонки.Добавить("ПутьФормыВыбора", Новый ОписаниеТипов("Строка"));
	ТаблицаТипов.Колонки.Добавить("ОсновнойТип", Новый ОписаниеТипов("ОписаниеТипов"));
	
	ТаблицаТипов.Индексы.Добавить("ИОМД");
	ТаблицаТипов.Индексы.Добавить("ТипПолучателей");
	
	ДоступныеТипы = Метаданные.Справочники.РассылкиОтчетов.ТабличныеЧасти.Получатели.Реквизиты.Получатель.Тип.Типы();
	
	// Параметры справочников "Пользователи" + "Группы пользователей".
	НастройкиТипа = Новый Структура;
	НастройкиТипа.Вставить("ОсновнойТип",       Тип("СправочникСсылка.Пользователи"));
	НастройкиТипа.Вставить("ДополнительныйТип", Тип("СправочникСсылка.ГруппыПользователей"));
	РассылкаОтчетов.ДобавитьЭлементВТаблицуТиповПолучателей(ТаблицаТипов, ДоступныеТипы, НастройкиТипа);
	
	// Механизм расширения
	РассылкаОтчетовПереопределяемый.ПереопределитьТаблицуТиповПолучателей(ТаблицаТипов, ДоступныеТипы);
	
	// Параметры остальных справочников.
	ПустойМассив = Новый Массив;
	Для Каждого НеиспользованныйТип Из ДоступныеТипы Цикл
		РассылкаОтчетов.ДобавитьЭлементВТаблицуТиповПолучателей(ТаблицаТипов, ПустойМассив, Новый Структура("ОсновнойТип", НеиспользованныйТип));
	КонецЦикла;
	
	Возврат ТаблицаТипов;
КонецФункции

// Получает пустое значение для поиска по таблице "Отчеты" или "ФорматыОтчетов" справочника "РассылкиОтчетов".
Функция ПустоеЗначениеОтчета() Экспорт
	УстановитьПривилегированныйРежим(Истина);
	Возврат Метаданные.Справочники.РассылкиОтчетов.ТабличныеЧасти.ФорматыОтчетов.Реквизиты.Отчет.Тип.ПривестиЗначение();
КонецФункции

// Получает заголовок системы, а если он не задан - синоним метаданных конфигурации.
Функция ИмяЭтойИнформационнойБазы() Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Результат = Константы.ЗаголовокСистемы.Получить();
	
	Если ПустаяСтрока(Результат) Тогда
		
		Результат = Метаданные.Синоним;
		
	КонецЕсли;
	
	Возврат Результат;
КонецФункции

// Исключаемые отчеты используются в качестве исключающего фильтра при выборе отчетов.
Функция ИсключаемыеОтчеты() Экспорт
	МассивМетаданных = Новый Массив;
	РассылкаОтчетовПереопределяемый.ОпределитьИсключаемыеОтчеты(МассивМетаданных);
	
	Результат = Новый Массив;
	Для Каждого ОтчетМетаданные Из МассивМетаданных Цикл
		Результат.Добавить(ОбщегоНазначения.ИдентификаторОбъектаМетаданных(ОтчетМетаданные));
	КонецЦикла;
	
	ИсключаемыеОтчеты = Новый ФиксированныйМассив(Результат);
	
	Возврат ИсключаемыеОтчеты;
КонецФункции

#КонецОбласти
