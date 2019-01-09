#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.ОбменДанными

// Заполняет настройки, влияющие на использование плана обмена.
// 
// Параметры:
//  Настройки - Структура - настройки плана обмена по умолчанию, см. ОбменДаннымиСервер.НастройкиПланаОбменаПоУмолчанию,
//                          описание возвращаемого значения функции.
//
Процедура ПриПолученииНастроек(Настройки) Экспорт
	
	Настройки.Алгоритмы.ПриПолученииВариантовНастроекОбмена   = Истина;
	Настройки.Алгоритмы.ПриПолученииОписанияВариантаНастройки = Истина;
	Настройки.Алгоритмы.ОписаниеОграниченийПередачиДанных     = Истина;

КонецПроцедуры

// Заполняет коллекцию вариантов настроек, предусмотренных для плана обмена.
// 
// Параметры:
//  ВариантыНастроекОбмена - ТаблицаЗначений - коллекция вариантов настроек обмена, см. описание возвращаемого значения
//                                       функции НастройкиПланаОбменаПоУмолчанию общего модуля ОбменДаннымиСервер.
//  ПараметрыКонтекста     - Структура - см. ОбменДаннымиСервер.ПараметрыКонтекстаПолученияВариантовНастроек,
//                                       описание возвращаемого значения функции.
//
Процедура ПриПолученииВариантовНастроекОбмена(ВариантыНастроекОбмена, ПараметрыКонтекста) Экспорт
	
	ВариантНастройки = ВариантыНастроекОбмена.Добавить();
	ВариантНастройки.ИдентификаторНастройки = "";
	ВариантНастройки.КорреспондентВМоделиСервиса = Ложь;
	ВариантНастройки.КорреспондентВЛокальномРежиме = Истина;
	
КонецПроцедуры

// Заполняет набор параметров, определяющих вариант настройки обмена.
// 
// Параметры:
//  ОписаниеВарианта       - Структура - набор варианта настройки по умолчанию,
//                                       см. ОбменДаннымиСервер.ОписаниеВариантаНастройкиОбменаПоУмолчанию,
//                                       описание возвращаемого значения.
//  ИдентификаторНастройки - Строка    - идентификатор варианта настройки обмена.
//  ПараметрыКонтекста     - Структура - см. ОбменДаннымиСервер.ПараметрыКонтекстаПолученияОписанияВариантаНастройки,
//                                       описание возвращаемого значения функции.
//
Процедура ПриПолученииОписанияВариантаНастройки(ОписаниеВарианта, ИдентификаторНастройки, ПараметрыКонтекста) Экспорт
	
	КраткаяИнформацияПоОбмену = НСтр("ru = 'Позволяет синхронизировать данные между двумя программами 1С:Библиотека стандартных подсистем. 
	|Особенностью данного вида синхронизации данных является отсутствие правил конвертации данных и требование идентичности конфигураций у синхронизирующихся программ.'");
	
	ПодробнаяИнформацияПоОбмену = "http://its.1c.ru/db/bspdoc#content:120:1:IssOgl2_Обмен%2520с%2520БСП%2520(без%2520использования%2520правил%2520обмена)";
	
	ОписаниеВарианта.КраткаяИнформацияПоОбмену   = КраткаяИнформацияПоОбмену;
	ОписаниеВарианта.ПодробнаяИнформацияПоОбмену = ПодробнаяИнформацияПоОбмену;
	
	ОписаниеВарианта.НаименованиеКонфигурацииКорреспондента = НСтр("ru = '1С:Библиотека стандартных подсистем'");
	ОписаниеВарианта.ИмяФайлаНастроекДляПриемника           = НСтр("ru = 'Настройки синхронизации для БСП (без использования правил)'");
	
	ЗаголовокКоманды = НСтр("ru = '1С:Библиотека стандартных подсистем (без использования правил обмена)'");
	ОписаниеВарианта.ЗаголовокКомандыДляСозданияНовогоОбменаДанными = ЗаголовокКоманды;
	
	// Отборы
	СтруктураТабличнойЧастиОрганизации = Новый Структура;
	СтруктураТабличнойЧастиОрганизации.Вставить("Организация", Новый Массив);
	
	ОписаниеВарианта.Отборы.Вставить("ДатаНачалаВыгрузкиДокументов",    НачалоГода(ТекущаяДатаСеанса()));
	ОписаниеВарианта.Отборы.Вставить("Организации",                     СтруктураТабличнойЧастиОрганизации);
	ОписаниеВарианта.Отборы.Вставить("ИспользоватьОтборПоОрганизациям", Ложь);
	
КонецПроцедуры

// Возвращает строку описания ограничений миграции данных для пользователя.
// Прикладной разработчик на основе установленных отборов на узле должен сформировать 
// строку описания ограничений удобную для восприятия пользователем.
// 
// Параметры:
//  НастройкаОтборовНаУзле - Структура - структура отборов на узле плана обмена.
//  ВерсияКорреспондента   - Строка    - версия корреспондента.
//  ИдентификаторНастройки - Строка    - идентификатор варианта настройки обмена.
//
// Возвращаемое значение:
//  Строка - описание ограничений миграции данных для пользователя.
//
Функция ОписаниеОграниченийПередачиДанных(НастройкаОтборовНаУзле, ВерсияКорреспондента, ИдентификаторНастройки) Экспорт
	
	ОграничениеДатаНачалаВыгрузкиДокументов = "";
	ОграничениеОтборПоОрганизациям = "";
	
	// Выгружать документы, ...
	// Дата начала выгрузки документов.
	Если ЗначениеЗаполнено(НастройкаОтборовНаУзле.ДатаНачалаВыгрузкиДокументов) Тогда
		
		ОграничениеДатаНачалаВыгрузкиДокументов = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Начиная с %1'"),
			Формат(НастройкаОтборовНаУзле.ДатаНачалаВыгрузкиДокументов, "ДЛФ=DD"));
		
	Иначе
		
		ОграничениеДатаНачалаВыгрузкиДокументов = НСтр("ru = 'За весь период ведения учета в программе'");
		
	КонецЕсли;
	
	// отбор по организациям
	Если НастройкаОтборовНаУзле.ИспользоватьОтборПоОрганизациям Тогда
		
		СтрокаПредставленияОтбора = СтрСоединить(НастройкаОтборовНаУзле.Организации.Организация, "; ");
		
		ОграничениеОтборПоОрганизациям = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Только по организациям: %1'"), СтрокаПредставленияОтбора);
		
	Иначе
		
		ОграничениеОтборПоОрганизациям = НСтр("ru = 'По всем организациям'");
		
	КонецЕсли;
	
	Возврат (
		НСтр("ru = 'Выгружать документы и справочную информацию:'")
		+ Символы.ПС
		+ ОграничениеДатаНачалаВыгрузкиДокументов
		+ Символы.ПС
		+ ОграничениеОтборПоОрганизациям);
КонецФункции

// Конец СтандартныеПодсистемы.ОбменДанными

// СтандартныеПодсистемы.ГрупповоеИзменениеОбъектов

// Возвращает реквизиты объекта, которые не рекомендуется редактировать
// с помощью обработки группового изменения реквизитов.
//
// Возвращаемое значение:
//  Массив - список имен реквизитов объекта.
Функция РеквизитыНеРедактируемыеВГрупповойОбработке() Экспорт
	
	Результат = Новый Массив;
	Результат.Добавить("РегистрироватьИзменения");
	Возврат Результат;
	
КонецФункции

// Конец СтандартныеПодсистемы.ГрупповоеИзменениеОбъектов

#КонецОбласти

#КонецОбласти

#КонецЕсли
