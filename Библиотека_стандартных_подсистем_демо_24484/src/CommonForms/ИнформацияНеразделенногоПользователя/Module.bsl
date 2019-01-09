#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ШаблонСообщения = НСтр("ru = 'Просмотр сведений о пользователе %1 не доступен, т.к. это 
		|служебная учетная запись, предусмотренная для администраторов сервиса.'");
	Элементы.НеразделенныйПользователь.Заголовок = СтрШаблон(ШаблонСообщения, Параметры.Ключ.Наименование);
	
КонецПроцедуры

#КонецОбласти