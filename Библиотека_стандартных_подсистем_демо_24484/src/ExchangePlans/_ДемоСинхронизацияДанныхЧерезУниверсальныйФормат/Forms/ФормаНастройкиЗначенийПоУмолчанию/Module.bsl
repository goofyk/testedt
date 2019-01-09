
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ОбменДаннымиСервер.ФормаНастройкиЗначенийПоУмолчаниюПриСозданииНаСервере(ЭтотОбъект, Метаданные.ПланыОбмена._ДемоСинхронизацияДанныхЧерезУниверсальныйФормат.Имя);
	ИспользоватьУчетНДС = ПолучитьФункциональнуюОпцию("_ДемоУчитыватьНДС");
	
	Элементы.СтавкаНДСПоУмолчанию.Видимость = ИспользоватьУчетНДС;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	ОбменДаннымиКлиент.ФормаНастройкиПередЗакрытием(Отказ, ЭтотОбъект, ЗавершениеРаботы);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	
	ОчиститьСообщения();
	Отказ = Ложь;
	Если Не ЗначениеЗаполнено(НоменклатураПоУмолчанию) Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Необходимо выбрать номенклатуру.'"),,, "НоменклатураПоУмолчанию", Отказ);
	КонецЕсли;
	Если ИспользоватьУчетНДС И Не ЗначениеЗаполнено(СтавкаНДСПоУмолчанию) Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Необходимо задать значение ставки НДС.'"),,, "СтавкаНДСПоУмолчанию", Отказ);
	КонецЕсли;
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	ОбменДаннымиКлиент.ФормаНастройкиЗначенийПоУмолчаниюКомандаЗакрытьФорму(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти
