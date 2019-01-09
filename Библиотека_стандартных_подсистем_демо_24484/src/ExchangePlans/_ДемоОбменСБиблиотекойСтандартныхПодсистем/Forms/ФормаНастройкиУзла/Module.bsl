
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ОбменДаннымиСервер.ФормаНастройкиУзлаПриСозданииНаСервере(ЭтотОбъект, Метаданные.ПланыОбмена._ДемоОбменСБиблиотекойСтандартныхПодсистем.Имя);
	
	ВспомогательныйРеквизитРежимСинхронизацииОрганизаций =
		?(ИспользоватьОтборПоОрганизациям, "СинхронизироватьДанныеТолькоПоВыбраннымОрганизациям", "СинхронизироватьДанныеПоВсемОрганизациям");
	
	ВспомогательныйРеквизитРежимСинхронизацииПодразделений =
		?(ИспользоватьОтборПоПодразделениям, "СинхронизироватьДанныеТолькоПоВыбраннымПодразделениям", "СинхронизироватьДанныеПоВсемПодразделениям");
	
	ВспомогательныйРеквизитРежимСинхронизацииСкладов =
		?(ИспользоватьОтборПоСкладам, "СинхронизироватьДанныеТолькоПоВыбраннымСкладам", "СинхронизироватьДанныеПоВсемСкладам");
	
	ВспомогательныйРеквизитОрганизации.Загрузить(ВсеОрганизацииПриложения());
	ВспомогательныйРеквизитПодразделения.Загрузить(ВсеПодразделенияПриложения());
	ВспомогательныйРеквизитСклады.Загрузить(ВсеСкладыПриложения());
	
	ОтметитьВыбранныеЭлементыТаблицы("Организации", "ВспомогательныйРеквизитОрганизации", "Организация");
	ОтметитьВыбранныеЭлементыТаблицы("Подразделения", "ВспомогательныйРеквизитПодразделения", "Подразделение");
	ОтметитьВыбранныеЭлементыТаблицы("Склады", "ВспомогательныйРеквизитСклады", "Склад");
	
	ПланыОбмена._ДемоОбменСБиблиотекойСтандартныхПодсистем.ОпределитьВариантСинхронизацииДокументов(ВариантСинхронизацииДокументов, ЭтотОбъект);
	ПланыОбмена._ДемоОбменСБиблиотекойСтандартныхПодсистем.ОпределитьВариантСинхронизацииСправочников(ВариантСинхронизацииСправочников, ЭтотОбъект);
	УстановитьВидимостьНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	РежимСинхронизацииОрганизацийПриИзмененииЗначения();
	РежимСинхронизацииПодразделенийПриИзмененииЗначения();
	РежимСинхронизацииСкладовПриИзмененииЗначения();
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	ОбменДаннымиКлиент.ФормаНастройкиПередЗакрытием(Отказ, ЭтотОбъект, ЗавершениеРаботы);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ВспомогательныйРеквизитРежимСинхронизацииОрганизацийПриИзменении(Элемент)
	
	РежимСинхронизацииОрганизацийПриИзмененииЗначения();
	
КонецПроцедуры

&НаКлиенте
Процедура ВспомогательныйРеквизитРежимСинхронизацииСкладовПриИзменении(Элемент)
	
	РежимСинхронизацииСкладовПриИзмененииЗначения();
	
КонецПроцедуры

&НаКлиенте
Процедура ВспомогательныйРеквизитРежимСинхронизацииПодразделенийПриИзменении(Элемент)
	
	РежимСинхронизацииПодразделенийПриИзмененииЗначения();
	
КонецПроцедуры

&НаКлиенте
Процедура ВспомогательныйРеквизитОрганизацииИспользоватьПриИзменении(Элемент)
	
	СформироватьЗаголовокТаблицыОрганизации();
	
КонецПроцедуры

&НаКлиенте
Процедура ВспомогательныйРеквизитСкладыИспользоватьПриИзменении(Элемент)
	
	СформироватьЗаголовокТаблицыСклады();
	
КонецПроцедуры

&НаКлиенте
Процедура ВспомогательныйРеквизитПодразделенияИспользоватьПриИзменении(Элемент)
	
	СформироватьЗаголовокТаблицыПодразделения();
	
КонецПроцедуры


&НаКлиенте
Процедура ВариантСинхронизацииДокументовОтправлятьПолучатьАвтоматическиПриИзменении(Элемент)
	УстановитьВидимостьНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ВариантСинхронизацииДокументовОтправлятьАвтоматическиПриИзменении(Элемент)
	УстановитьВидимостьНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ВариантСинхронизацииДокументовПолучатьАвтоматическиПриИзменении(Элемент)
	УстановитьВидимостьНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ВариантСинхронизацииДокументовВручнуюПриИзменении(Элемент)
	УстановитьВидимостьНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ВариантСинхронизацииСправочниковВручнуюПриИзменении(Элемент)
	УстановитьВидимостьНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ВариантСинхронизацииСправочниковТолькоИспользуемуюВДокументахПриИзменении(Элемент)
	УстановитьВидимостьНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ВариантСинхронизацииСправочниковАвтоматическиПриИзменении(Элемент)
	УстановитьВидимостьНаСервере();
КонецПроцедуры
#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	
	ЗаписатьИЗакрытьНаСервере();
	
	ОбменДаннымиКлиент.ФормаНастройкиУзлаКомандаЗакрытьФорму(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ВключитьВсеОрганизации(Команда)
	
	ВключитьОтключитьВсеЭлементыВТаблице(Истина, "ВспомогательныйРеквизитОрганизации");
	
КонецПроцедуры

&НаКлиенте
Процедура ВключитьВсеПодразделения(Команда)
	
	ВключитьОтключитьВсеЭлементыВТаблице(Истина, "ВспомогательныйРеквизитПодразделения");
	
КонецПроцедуры

&НаКлиенте
Процедура ВключитьВсеСклады(Команда)
	
	ВключитьОтключитьВсеЭлементыВТаблице(Истина, "ВспомогательныйРеквизитСклады");
	
КонецПроцедуры

&НаКлиенте
Процедура ОтключитьВсеОрганизации(Команда)
	
	ВключитьОтключитьВсеЭлементыВТаблице(Ложь, "ВспомогательныйРеквизитОрганизации");
	
КонецПроцедуры

&НаКлиенте
Процедура ОтключитьВсеПодразделения(Команда)
	
	ВключитьОтключитьВсеЭлементыВТаблице(Ложь, "ВспомогательныйРеквизитПодразделения");
	
КонецПроцедуры

&НаКлиенте
Процедура ОтключитьВсеСклады(Команда)
	
	ВключитьОтключитьВсеЭлементыВТаблице(Ложь, "ВспомогательныйРеквизитСклады");
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаписатьИЗакрытьНаСервере()
	
	ИспользоватьОтборПоОрганизациям =
		(ВспомогательныйРеквизитРежимСинхронизацииОрганизаций = "СинхронизироватьДанныеТолькоПоВыбраннымОрганизациям");
	
	ИспользоватьОтборПоПодразделениям =
		(ВспомогательныйРеквизитРежимСинхронизацииПодразделений = "СинхронизироватьДанныеТолькоПоВыбраннымПодразделениям");
	
	ИспользоватьОтборПоСкладам =
		(ВспомогательныйРеквизитРежимСинхронизацииСкладов = "СинхронизироватьДанныеТолькоПоВыбраннымСкладам");
	
	Если ИспользоватьОтборПоОрганизациям Тогда
		
		Организации.Загрузить(ВспомогательныйРеквизитОрганизации.Выгрузить(Новый Структура("Использовать", Истина), "Организация"));
		
	Иначе
		
		Организации.Очистить();
		
	КонецЕсли;
	
	Если ИспользоватьОтборПоПодразделениям Тогда
		
		Подразделения.Загрузить(ВспомогательныйРеквизитПодразделения.Выгрузить(Новый Структура("Использовать", Истина), "Подразделение"));
		
	Иначе
		
		Подразделения.Очистить();
		
	КонецЕсли;
	
	Если ИспользоватьОтборПоСкладам Тогда
		
		Склады.Загрузить(ВспомогательныйРеквизитСклады.Выгрузить(Новый Структура("Использовать", Истина), "Склад"));
		
	Иначе
		
		Склады.Очистить();
		
	КонецЕсли;
	
	ПланыОбмена._ДемоОбменСБиблиотекойСтандартныхПодсистем.ОпределитьРежимыВыгрузкиДокументов(ВариантСинхронизацииДокументов, ЭтотОбъект);
	ПланыОбмена._ДемоОбменСБиблиотекойСтандартныхПодсистем.ОпределитьРежимыВыгрузкиСправочников(ВариантСинхронизацииСправочников, ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ВключитьОтключитьВсеЭлементыВТаблице(Включить, ИмяТаблицы)
	
	Для Каждого ЭлементКоллекции Из ЭтотОбъект[ИмяТаблицы] Цикл
		
		ЭлементКоллекции.Использовать = Включить;
		
	КонецЦикла;
	
	СформироватьЗаголовокТаблицыОрганизации();
	СформироватьЗаголовокТаблицыПодразделения();
	СформироватьЗаголовокТаблицыСклады();
	
КонецПроцедуры

&НаКлиенте
Процедура РежимСинхронизацииОрганизацийПриИзмененииЗначения()
	
	Элементы.ВспомогательныйРеквизитОрганизации.Доступность =
		(ВспомогательныйРеквизитРежимСинхронизацииОрганизаций = "СинхронизироватьДанныеТолькоПоВыбраннымОрганизациям");
	
	СформироватьЗаголовокТаблицыОрганизации();
	
КонецПроцедуры

&НаКлиенте
Процедура РежимСинхронизацииПодразделенийПриИзмененииЗначения()
	
	Элементы.ВспомогательныйРеквизитПодразделения.Доступность =
		(ВспомогательныйРеквизитРежимСинхронизацииПодразделений = "СинхронизироватьДанныеТолькоПоВыбраннымПодразделениям");
	
	СформироватьЗаголовокТаблицыПодразделения();
	
КонецПроцедуры

&НаКлиенте
Процедура РежимСинхронизацииСкладовПриИзмененииЗначения()
	
	Элементы.ВспомогательныйРеквизитСклады.Доступность =
		(ВспомогательныйРеквизитРежимСинхронизацииСкладов = "СинхронизироватьДанныеТолькоПоВыбраннымСкладам");
	
	СформироватьЗаголовокТаблицыСклады();
	
КонецПроцедуры

&НаСервере
Функция ВсеОрганизацииПриложения()
	
	УстановитьПривилегированныйРежим(Истина);
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	ЛОЖЬ КАК Использовать,
	|	Организации.Ссылка КАК Организация
	|ИЗ
	|	Справочник._ДемоОрганизации КАК Организации
	|ГДЕ
	|	НЕ Организации.ПометкаУдаления
	|
	|УПОРЯДОЧИТЬ ПО
	|	Организации.Наименование";
	
	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапроса;
	
	Возврат Запрос.Выполнить().Выгрузить();
КонецФункции

&НаСервере
Функция ВсеПодразделенияПриложения()
	
	УстановитьПривилегированныйРежим(Истина);
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	ЛОЖЬ КАК Использовать,
	|	_ДемоПодразделения.Ссылка КАК Подразделение
	|ИЗ
	|	Справочник._ДемоПодразделения КАК _ДемоПодразделения
	|ГДЕ
	|	НЕ _ДемоПодразделения.ПометкаУдаления
	|
	|УПОРЯДОЧИТЬ ПО
	|	_ДемоПодразделения.Наименование";
	
	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапроса;
	
	Возврат Запрос.Выполнить().Выгрузить();
КонецФункции

&НаСервере
Функция ВсеСкладыПриложения()
	
	УстановитьПривилегированныйРежим(Истина);
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	ЛОЖЬ КАК Использовать,
	|	_ДемоМестаХранения.Ссылка КАК Склад
	|ИЗ
	|	Справочник._ДемоМестаХранения КАК _ДемоМестаХранения
	|ГДЕ
	|	НЕ _ДемоМестаХранения.ПометкаУдаления
	|	И НЕ _ДемоМестаХранения.ЭтоГруппа
	|
	|УПОРЯДОЧИТЬ ПО
	|	_ДемоМестаХранения.Наименование";
	
	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапроса;
	
	Возврат Запрос.Выполнить().Выгрузить();
КонецФункции

&НаСервере
Процедура ОтметитьВыбранныеЭлементыТаблицы(ИмяТаблицы, ИмяВспомогательнойТаблицы, ИмяРеквизита)
	
	Для Каждого СтрокаТаблицы Из ЭтотОбъект[ИмяТаблицы] Цикл
		
		Строки = ЭтотОбъект[ИмяВспомогательнойТаблицы].НайтиСтроки(Новый Структура(ИмяРеквизита, СтрокаТаблицы[ИмяРеквизита]));
		
		Если Строки.Количество() > 0 Тогда
			
			Строки[0].Использовать = Истина;
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура СформироватьЗаголовокТаблицыОрганизации()
	
	Если ВспомогательныйРеквизитРежимСинхронизацииОрганизаций = "СинхронизироватьДанныеТолькоПоВыбраннымОрганизациям" Тогда
		
		ЗаголовокСтраницы = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'По организациям (%1)'"),
			КоличествоВыбранныхСтрок("ВспомогательныйРеквизитОрганизации"));
	Иначе
		
		ЗаголовокСтраницы = НСтр("ru = 'По всем организациям'");
	КонецЕсли;
	
	Элементы.СтраницаОрганизации.Заголовок = ЗаголовокСтраницы;
	
КонецПроцедуры

&НаКлиенте
Процедура СформироватьЗаголовокТаблицыПодразделения()
	
	Если ВспомогательныйРеквизитРежимСинхронизацииПодразделений = "СинхронизироватьДанныеТолькоПоВыбраннымПодразделениям" Тогда
		
		ЗаголовокСтраницы = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'По подразделениям (%1)'"),
			КоличествоВыбранныхСтрок("ВспомогательныйРеквизитПодразделения"));
	Иначе
		
		ЗаголовокСтраницы = НСтр("ru = 'По всем подразделениям'");
	КонецЕсли;
	
	Элементы.СтраницаПодразделения.Заголовок = ЗаголовокСтраницы;
	
КонецПроцедуры

&НаКлиенте
Процедура СформироватьЗаголовокТаблицыСклады()
	
	Если ВспомогательныйРеквизитРежимСинхронизацииСкладов = "СинхронизироватьДанныеТолькоПоВыбраннымСкладам" Тогда
		
		ЗаголовокСтраницы = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'По складам (%1)'"),
			КоличествоВыбранныхСтрок("ВспомогательныйРеквизитСклады"));
	Иначе
		
		ЗаголовокСтраницы = НСтр("ru = 'По всем складам'");
	КонецЕсли;
	
	Элементы.СтраницаСклады.Заголовок = ЗаголовокСтраницы;
	
КонецПроцедуры

&НаКлиенте
Функция КоличествоВыбранныхСтрок(ИмяТаблицы)
	
	Результат = 0;
	
	Для Каждого ЭлементКоллекции Из ЭтотОбъект[ИмяТаблицы] Цикл
		
		Если ЭлементКоллекции.Использовать Тогда
			
			Результат = Результат + 1;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

&НаСервере
Процедура УстановитьВидимостьНаСервере()
	Элементы.ДатаНачалаВыгрузкиДокументов.Доступность = 
			(ВариантСинхронизацииДокументов = "ОтправлятьИПолучатьАвтоматически" 
			ИЛИ ВариантСинхронизацииДокументов = "ОтправлятьАвтоматически");
	Элементы.ВариантСинхронизацииДокументовПолучатьАвтоматически.Доступность = 
			(ВариантСинхронизацииСправочников <> "ОтправлятьИПолучатьПриНеобходимости");
	Элементы.ВариантСинхронизацииСправочниковТолькоИспользуемуюВДокументах.Доступность = 
			(ВариантСинхронизацииДокументов <> "ПолучатьАвтоматически");
КонецПроцедуры

#КонецОбласти
