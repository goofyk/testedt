#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступом.ЗаполнитьНаборыЗначенийДоступа.
Процедура ЗаполнитьНаборыЗначенийДоступа(Таблица) Экспорт
	
	// Логика ограничения:
	// Чтения:                Без ограничения.
	// Изменения:             Без ограничения.
	
	// Чтение, Добавление, Изменение: набор №0.
	Строка = Таблица.Добавить();
	Строка.ЗначениеДоступа = Перечисления.ДополнительныеЗначенияДоступа.ДоступРазрешен;
	
	а = 1;
	б = 30;
	в = 40;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	Если (ОбменДанными.Загрузка) Тогда
		Возврат;
	КонецЕсли;
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область ОбработчикиСобытий

// Для внутреннего использования.
// 
Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	// Проверка на наличие дублей по наименованию и виду номенклатуры.
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("Режим",  "КонтрольПоНаименованию");
	ДополнительныеПараметры.Вставить("Ссылка", Ссылка);
	
	Дубли = ПоискИУдалениеДублей.НайтиДублиЭлемента("Справочник._ДемоНоменклатура", ЭтотОбъект, ДополнительныеПараметры);
	Если Дубли.Количество() > 0 Тогда
		Ошибка = НСтр("ru = 'Номенклатура с таким наименованием и видом уже существует.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(Ошибка, , "Объект.Наименование", , Отказ);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
