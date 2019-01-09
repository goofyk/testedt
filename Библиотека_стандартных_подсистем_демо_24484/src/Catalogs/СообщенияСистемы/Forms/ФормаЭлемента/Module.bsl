
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ТелоСообщения = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.Ссылка, "ТелоСообщения").Получить();
	
	Если ТипЗнч(ТелоСообщения) = Тип("Строка") Тогда
		
		ТелоСообщенияПредставление = ТелоСообщения;
		
	Иначе
		
		Попытка
			ТелоСообщенияПредставление = ОбщегоНазначения.ЗначениеВСтрокуXML(ТелоСообщения);
		Исключение
			ТелоСообщенияПредставление = НСтр("ru = 'Тело сообщения не может быть представлено строкой.'");
		КонецПопытки;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
