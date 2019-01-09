
#Область ОбработчикиСобытий

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Текст = Параметры.ТекстЗапроса;
	ТекстЗапроса.УстановитьТекст(СформироватьТекстЗапросаДляКонфигуратора(Текст));
КонецПроцедуры

///////////////////////////////////////////////////////////////////////////
// ВСПОМОГАТЕЛЬНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

&НаСервере
Функция СформироватьТекстЗапросаДляКонфигуратора(Текст)
	Результат = """";
	Текст = Параметры.ТекстЗапроса;
	ПереводСтроки = Символы.ВК+Символы.ПС;
	Для Счетчик = 1 По СтрЧислоСтрок(Текст) Цикл
		ТекСтрока = СтрПолучитьСтроку(Текст, Счетчик);
		Если Счетчик > 1 Тогда 
			ТекСтрока = СтрЗаменить(ТекСтрока,"""","""""");
			Результат = Результат + ПереводСтроки + "|"+ ТекСтрока;
		Иначе	
			ТекСтрока = СтрЗаменить(ТекСтрока,"""","""""");
			Результат = Результат + ТекСтрока;
		КонецЕсли;	
	КонецЦикла;
	Результат = Результат + """";
	Возврат Результат;
КонецФункции

#КонецОбласти
