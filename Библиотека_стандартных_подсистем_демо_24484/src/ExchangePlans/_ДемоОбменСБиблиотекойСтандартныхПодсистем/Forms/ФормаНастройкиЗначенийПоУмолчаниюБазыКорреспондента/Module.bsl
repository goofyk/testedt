
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ДополнительныеДанные = Неопределено;
	
	ОбменДаннымиСервер.ФормаНастройкиЗначенийПоУмолчаниюБазыКорреспондентаПриСозданииНаСервере(
		ЭтотОбъект,
		Метаданные.ПланыОбмена._ДемоОбменСБиблиотекойСтандартныхПодсистем.Имя,
		ДополнительныеДанные);
	
	ИспользоватьУчетНДС = Истина;
	
	Элементы.СтавкаНДСПоУмолчанию.Видимость = ИспользоватьУчетНДС;
	Элементы.СтавкаНДС.Видимость = ИспользоватьУчетНДС;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	ОбменДаннымиКлиент.ФормаНастройкиПередЗакрытием(Отказ, ЭтотОбъект, ЗавершениеРаботы);
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	ОбменДаннымиСервер.ОпределитьПроверяемыеРеквизитыСУчетомНастроекВидимостиПолейФормы(ПроверяемыеРеквизиты, Элементы);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	ОбменДаннымиКлиент.ОбработчикВыбораЭлементовБазыКорреспондентаОбработкаВыбора(ЭтотОбъект, ВыбранноеЗначение);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийКоманд
&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	
	ОчиститьСообщения();
	Отказ = Ложь;
	Если Не ЗначениеЗаполнено(НоменклатураПоУмолчанию) Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Необходимо выбрать номенклатуру.'"),,, 
			"НоменклатураПоУмолчанию", Отказ);
	КонецЕсли;
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	ОбменДаннымиКлиент.ФормаНастройкиЗначенийПоУмолчаниюКомандаЗакрытьФорму(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура НоменклатураНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ПараметрыВыбора = Новый Структура("ВыборГруппИЭлементов", Элемент.ВыборГруппИЭлементов);
	
	ОбменДаннымиКлиент.ОбработчикВыбораЭлементовБазыКорреспондентаНачалоВыбора("НоменклатураПоУмолчанию", "Справочник._ДемоНоменклатура", 
		ЭтотОбъект, СтандартнаяОбработка, ПараметрыВнешнегоСоединения, ПараметрыВыбора);
	
КонецПроцедуры

&НаКлиенте
Процедура СтавкаНДСНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ПараметрыВыбора = Новый Структура("ВыборГруппИЭлементов", Элемент.ВыборГруппИЭлементов);
	
	ОбменДаннымиКлиент.ОбработчикВыбораЭлементовБазыКорреспондентаНачалоВыбора("СтавкаНДСПоУмолчанию", "Справочник._ДемоСтавкиНДС", 
		ЭтотОбъект, СтандартнаяОбработка, ПараметрыВнешнегоСоединения, ПараметрыВыбора);
	
КонецПроцедуры

#КонецОбласти

