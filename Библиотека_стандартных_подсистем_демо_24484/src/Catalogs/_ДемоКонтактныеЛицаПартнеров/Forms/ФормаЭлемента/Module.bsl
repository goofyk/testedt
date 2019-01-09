#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	УправлениеКонтактнойИнформацией.ПриСозданииНаСервере(ЭтотОбъект, Объект.Ссылка,, ПоложениеЗаголовкаЭлементаФормы.Лево);
	УправлениеКонтактнойИнформацией.ПриСозданииНаСервере(ЭтотОбъект, ФизическоеЛицо, "ГруппаКонтактнаяИнформацияФизическогоЛица", ПоложениеЗаголовкаЭлементаФормы.Верх);
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация
	
	// Учесть возможность создания из взаимодействия.
	Взаимодействия.ПодготовитьОповещения(ЭтотОбъект,Параметры,Ложь);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	Если ЗначениеЗаполнено(ТекущийОбъект.ФизическоеЛицо) Тогда
		ЗначениеВРеквизитФормы(ТекущийОбъект.ФизическоеЛицо.ПолучитьОбъект(), "ФизическоеЛицо");
	КонецЕсли;

	УправлениеКонтактнойИнформацией.ПриЧтенииНаСервере(ЭтотОбъект, ФизическоеЛицо, "ГруппаКонтактнаяИнформацияФизическогоЛица");
	УправлениеКонтактнойИнформацией.ПриЧтенииНаСервере(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	ФизическоеЛицоОбъект = РеквизитФормыВЗначение("ФизическоеЛицо");
	УправлениеКонтактнойИнформацией.ПередЗаписьюНаСервере(ЭтотОбъект, ФизическоеЛицоОбъект, Отказ);
	Если НЕ Отказ Тогда
		УправлениеКонтактнойИнформацией.ОбработкаПроверкиЗаполненияНаСервере(ЭтотОбъект, Объект, Отказ);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация

КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.КонтактнаяИнформация
	УправлениеКонтактнойИнформацией.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	УправлениеКонтактнойИнформацией.ПередЗаписьюНаСервере(ЭтотОбъект, ЭтотОбъект.ФизическоеЛицо);
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация
	
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ФизическоеЛицоОбъект = РеквизитФормыВЗначение("ФизическоеЛицо");
	ФизическоеЛицоОбъект.Записать();
	ЗначениеВРеквизитФормы(ФизическоеЛицоОбъект, "ФизическоеЛицо");
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	ВзаимодействияКлиент.КонтактПослеЗаписи(ЭтотОбъект,Объект,ПараметрыЗаписи,"_ДемоКонтактныеЛицаПартнеров");
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ПодключитьОбработчикОжидания("ПроверитьНеобходимостьБлокировкиФизическогоЛица", 1, Ложь);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если ИмяСобытия = "Запись__ДемоФизическиеЛица" И Источник = Объект.ФизическоеЛицо Тогда
		ПрочитатьКонтактнуюИнформациюФизическогоЛица();
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ФизическоеЛицоПриИзменении(Элемент)
	Если ПустаяСтрока(Объект.Наименование) Тогда
		Объект.Наименование = ФизическоеЛицо.Наименование;
	КонецЕсли;
	ИзменитьДанныеФизическогоЛица();
	
КонецПроцедуры

// СтандартныеПодсистемы.КонтактнаяИнформация

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияПриИзменении(Элемент)
	УправлениеКонтактнойИнформациейКлиент.ПриИзменении(ЭтотОбъект, Элемент);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	УправлениеКонтактнойИнформациейКлиент.НачалоВыбора(ЭтотОбъект, Элемент, , СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияПриНажатии(Элемент, СтандартнаяОбработка)
	УправлениеКонтактнойИнформациейКлиент.НачалоВыбора(ЭтотОбъект, Элемент, , СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияОчистка(Элемент, СтандартнаяОбработка)
	УправлениеКонтактнойИнформациейКлиент.Очистка(ЭтотОбъект, Элемент.Имя);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияВыполнитьКоманду(Команда)
	УправлениеКонтактнойИнформациейКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда.Имя);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ОбновитьКонтактнуюИнформацию(Результат)
	УправлениеКонтактнойИнформацией.ОбновитьКонтактнуюИнформацию(ЭтотОбъект, Объект, Результат);
КонецПроцедуры

// Конец СтандартныеПодсистемы.КонтактнаяИнформация

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат)
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Объект, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПроверитьНеобходимостьБлокировкиФизическогоЛица()
	Если Модифицированность И НЕ ФизическоеЛицо.Ссылка.Пустая() Тогда
		Если ЗаблокироватьФизическоеЛицоПриРедактированииНаСервере(ФизическоеЛицо.Ссылка, ЭтотОбъект.УникальныйИдентификатор) Тогда
			ОтключитьОбработчикОжидания("ПроверитьНеобходимостьБлокировкиФизическогоЛица");
		Иначе
			Прочитать();
			ВызватьИсключение НСтр("ru = 'Данные контактного лица не могут быть записаны, т.к. личные данные физического лица не доступны для изменения.
				|Возможно, эти данные физического лица редактируются другим пользователем.'");
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ИзменитьДанныеФизическогоЛица()
	
	Если ФизическоеЛицо.Ссылка.Пустая() Тогда
		ПрочитатьКонтактнуюИнформациюФизическогоЛица();
		Возврат;
	КонецЕсли;
	
	Если ЗаблокироватьФизическоеЛицоПриРедактированииНаСервере(Объект.ФизическоеЛицо, ЭтотОбъект.УникальныйИдентификатор) Тогда
		РазблокироватьФизическоеЛицоПриРедактированииНаСервере(ФизическоеЛицо.Ссылка, ЭтотОбъект.УникальныйИдентификатор);
		ПрочитатьКонтактнуюИнформациюФизическогоЛица();
	Иначе
		Объект.ФизическоеЛицо = ФизическоеЛицо.Ссылка;
		ВызватьИсключение НСтр("ru = 'Данные контактного лица не могут быть записаны, т.к. личные данные физического лица не доступны для изменения.
			|Возможно, эти данные физического лица редактируются другим пользователем.'");
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ЗаблокироватьФизическоеЛицоПриРедактированииНаСервере(ФизическоеЛицо, ФормаУникальныйИдентификатор)
	
	Попытка
		ЗаблокироватьДанныеДляРедактирования(ФизическоеЛицо, ФизическоеЛицо.ВерсияДанных, ФормаУникальныйИдентификатор);
	Исключение
		Возврат Ложь;
	КонецПопытки;
	
	Возврат Истина;
	
КонецФункции

&НаСервереБезКонтекста
Функция РазблокироватьФизическоеЛицоПриРедактированииНаСервере(ФизическоеЛицоСсылка, ФормаУникальныйИдентификатор)
	Попытка
		РазблокироватьДанныеДляРедактирования(ФизическоеЛицоСсылка, ФормаУникальныйИдентификатор);
	Исключение
		Возврат Ложь;
	КонецПопытки;
	
	Возврат Истина;
	
КонецФункции

&НаСервере
Процедура ПрочитатьКонтактнуюИнформациюФизическогоЛица()
	
	ЗначениеВРеквизитФормы(Объект.ФизическоеЛицо.ПолучитьОбъект(), "ФизическоеЛицо");
	// СтандартныеПодсистемы.КонтактнаяИнформация
	УправлениеКонтактнойИнформацией.ПриЧтенииНаСервере(ЭтотОбъект, ФизическоеЛицо.Ссылка, "ГруппаКонтактнаяИнформацияФизическогоЛица");
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация
	
КонецПроцедуры
	
#КонецОбласти
