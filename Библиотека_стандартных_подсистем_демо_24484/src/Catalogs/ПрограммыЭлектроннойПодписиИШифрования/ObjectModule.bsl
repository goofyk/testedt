
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Если ЭтоПрограммаОблачногоСервиса Тогда
		ПроверяемыеРеквизиты.Очистить();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
