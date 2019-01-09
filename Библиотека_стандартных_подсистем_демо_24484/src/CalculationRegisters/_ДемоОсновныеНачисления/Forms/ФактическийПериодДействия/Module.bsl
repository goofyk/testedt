
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Отбор.Свойство("ФизическоеЛицо", ОтборФизическоеЛицо);
	УстановитьЭлементОтбораДинамическогоСписка(Список, "ФизическоеЛицо", ОтборФизическоеЛицо);
	
	Параметры.Отбор.Свойство("Организация", ОтборОрганизация);
	УстановитьЭлементОтбораДинамическогоСписка(Список, "Организация", ОтборОрганизация);
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ФОРМЫ

&НаКлиенте
Процедура ОтборФизическоеЛицоПриИзменении(Элемент)
	
	УстановитьЭлементОтбораДинамическогоСписка(Список, "ФизическоеЛицо", ОтборФизическоеЛицо);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборОрганизацияПриИзменении(Элемент)
	
	УстановитьЭлементОтбораДинамическогоСписка(Список, "Организация", ОтборОрганизация);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьЭлементОтбораДинамическогоСписка(Знач ДинамическийСписок, Знач ИмяПоля, Знач ПравоеЗначение, Знач ВидСравнения = Неопределено)
	
	Если ВидСравнения = Неопределено Тогда
		ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(ДинамическийСписок.Отбор, ИмяПоля, ПравоеЗначение, ВидСравнения, ,
		ЗначениеЗаполнено(ПравоеЗначение), РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);
	
КонецПроцедуры

#КонецОбласти