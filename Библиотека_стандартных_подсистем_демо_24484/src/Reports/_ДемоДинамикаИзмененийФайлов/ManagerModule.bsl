#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.ВариантыОтчетов

// Для подсистемы "Варианты отчетов" при работе в модели сервиса.
//
// Возвращаемое значение:
//  Массив - массив структур (варианты отчета).
Функция ВариантыНастроек() Экспорт
	Результат = Новый Массив;
	Результат.Добавить(Новый Структура("Имя, Представление", "Основной", НСтр("ru = 'Демо: Динамика изменений файлов'")));
	Результат.Добавить(Новый Структура("Имя, Представление", "Дополнительный1", НСтр("ru = 'Демо: Дополнительный 1'")));
	Результат.Добавить(Новый Структура("Имя, Представление", "Дополнительный2", НСтр("ru = 'Демо: Дополнительный 2'")));
	Результат.Добавить(Новый Структура("Имя, Представление", "Дополнительный3", НСтр("ru = 'Демо: Дополнительный 3'")));
	Результат.Добавить(Новый Структура("Имя, Представление", "Дополнительный4", НСтр("ru = 'Демо: Дополнительный 4'")));
	Результат.Добавить(Новый Структура("Имя, Представление", "Дополнительный5", НСтр("ru = 'Демо: Дополнительный 5'")));
	Возврат Результат;
КонецФункции

// См. ВариантыОтчетовПереопределяемый.НастроитьВариантыОтчетов.
//
Процедура НастроитьВариантыОтчета(Настройки, НастройкиОтчета) Экспорт
	ВариантыОтчетов.УстановитьРежимВыводаВПанеляхОтчетов(Настройки, НастройкиОтчета, Ложь);
	НастройкиОтчета.ОпределитьНастройкиФормы = Истина;
	НастройкиОтчета.Размещение.Удалить(Метаданные.Подсистемы._ДемоОрганайзер.Подсистемы._ДемоРаботаСФайлами);
	
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "Основной");
	НастройкиВарианта.Описание = НСтр("ru = 'Динамика прироста количества и размера файлов в виде наглядного графика по дням или месяцам.'");
	НастройкиВарианта.ФункциональныеОпции.Добавить("ИспользоватьЗаметки");
	НастройкиВарианта.Размещение.Вставить(Метаданные.Подсистемы._ДемоОрганайзер.Подсистемы._ДемоВариантыОтчетов, "Важный");
	
	// Скрытие варианта отчета настройкой разработчика.
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "Дополнительный1");
	НастройкиВарианта.Описание = НСтр("ru = 'Дополнительный 1.'");
	НастройкиВарианта.ВидимостьПоУмолчанию = Ложь;
	
	// Скрытие варианта отчета настройкой администратора.
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "Дополнительный2");
	НастройкиВарианта.Описание = НСтр("ru = 'Дополнительный 2.'");
	НастройкиВарианта.ВидимостьПоУмолчанию = Истина;
	
	// Скрытие варианта отчета настройкой пользователя.
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "Дополнительный3");
	НастройкиВарианта.Описание = НСтр("ru = 'Дополнительный 3.'");
	НастройкиВарианта.ВидимостьПоУмолчанию = Истина;
	
	// Отключение варианта отчета (безусловное).
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "Дополнительный4");
	НастройкиВарианта.Описание = НСтр("ru = 'Дополнительный 4.'");
	НастройкиВарианта.Включен = Ложь;
	
	// Отключение варианта отчета (по ФО).
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "Дополнительный5");
	НастройкиВарианта.Описание = НСтр("ru = 'Дополнительный 5.'");
	НастройкиВарианта.ФункциональныеОпции.Добавить("ИспользоватьВнешнихПользователей");
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.ВариантыОтчетов

#КонецОбласти

#КонецОбласти

#КонецЕсли