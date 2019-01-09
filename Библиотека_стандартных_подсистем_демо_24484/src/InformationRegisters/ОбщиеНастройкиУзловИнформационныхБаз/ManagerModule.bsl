#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

////////////////////////////////////////////////////////////////////////////////
// Работа с этим регистром сведений допускается только через менеджер записи.
// Так обеспечивается режим обновления существующих записей.
// Добавлять записи в этот регистр наборами записей запрещено,
// т.к. при этом будут утеряны настройки, не попавшие в набор записей.

#Область СлужебныеПроцедурыИФункции

Процедура УстановитьПризнакНачальнойВыгрузкиДанных(Знач УзелИнформационнойБазы) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	СтруктураЗаписи = Новый Структура;
	СтруктураЗаписи.Вставить("УзелИнформационнойБазы", УзелИнформационнойБазы);
	СтруктураЗаписи.Вставить("НачальнаяВыгрузкаДанных", Истина);
	СтруктураЗаписи.Вставить("НомерОтправленногоНачальнаяВыгрузкаДанных",
		ОбщегоНазначения.ЗначениеРеквизитаОбъекта(УзелИнформационнойБазы, "НомерОтправленного") + 1);
	
	ОбновитьЗапись(СтруктураЗаписи);
	
КонецПроцедуры

Процедура СнятьПризнакНачальнойВыгрузкиДанных(Знач УзелИнформационнойБазы, Знач НомерПринятого) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	НачатьТранзакцию();
	Попытка
		Блокировка = Новый БлокировкаДанных;
		ЭлементБлокировки = Блокировка.Добавить("РегистрСведений.ОбщиеНастройкиУзловИнформационныхБаз");
		ЭлементБлокировки.УстановитьЗначение("УзелИнформационнойБазы", УзелИнформационнойБазы);
		Блокировка.Заблокировать();
		
		ТекстЗапроса = "
		|ВЫБРАТЬ 1
		|ИЗ
		|	РегистрСведений.ОбщиеНастройкиУзловИнформационныхБаз КАК ОбщиеНастройкиУзловИнформационныхБаз
		|ГДЕ
		|	ОбщиеНастройкиУзловИнформационныхБаз.УзелИнформационнойБазы = &УзелИнформационнойБазы
		|	И ОбщиеНастройкиУзловИнформационныхБаз.НачальнаяВыгрузкаДанных
		|	И ОбщиеНастройкиУзловИнформационныхБаз.НомерОтправленногоНачальнаяВыгрузкаДанных <= &НомерПринятого
		|	И ОбщиеНастройкиУзловИнформационныхБаз.НомерОтправленногоНачальнаяВыгрузкаДанных <> 0
		|";
		
		Запрос = Новый Запрос;
		Запрос.УстановитьПараметр("УзелИнформационнойБазы", УзелИнформационнойБазы);
		Запрос.УстановитьПараметр("НомерПринятого", НомерПринятого);
		Запрос.Текст = ТекстЗапроса;
		
		Если Не Запрос.Выполнить().Пустой() Тогда
			
			СтруктураЗаписи = Новый Структура;
			СтруктураЗаписи.Вставить("УзелИнформационнойБазы", УзелИнформационнойБазы);
			СтруктураЗаписи.Вставить("НачальнаяВыгрузкаДанных", Ложь);
			СтруктураЗаписи.Вставить("НомерОтправленногоНачальнаяВыгрузкаДанных", 0);
			
			ОбновитьЗапись(СтруктураЗаписи);
			
		КонецЕсли;
		
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		ВызватьИсключение;
	КонецПопытки;
	
КонецПроцедуры

Функция УстановленПризнакНачальнойВыгрузкиДанных(Знач УзелИнформационнойБазы) Экспорт
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	1 КАК Поле1
	|ИЗ
	|	РегистрСведений.ОбщиеНастройкиУзловИнформационныхБаз КАК ОбщиеНастройкиУзловИнформационныхБаз
	|ГДЕ
	|	ОбщиеНастройкиУзловИнформационныхБаз.УзелИнформационнойБазы = &УзелИнформационнойБазы
	|	И ОбщиеНастройкиУзловИнформационныхБаз.НачальнаяВыгрузкаДанных";
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("УзелИнформационнойБазы", УзелИнформационнойБазы);
	Запрос.Текст = ТекстЗапроса;
	
	Возврат Не Запрос.Выполнить().Пустой();
КонецФункции

//

Процедура ЗафиксироватьВыполнениеКорректировкиИнформацииСопоставленияБезусловно(УзелИнформационнойБазы) Экспорт
	
	СтруктураЗаписи = Новый Структура;
	СтруктураЗаписи.Вставить("УзелИнформационнойБазы", УзелИнформационнойБазы);
	СтруктураЗаписи.Вставить("ВыполнитьКорректировкуИнформацииСопоставления", Ложь);
	
	ОбновитьЗапись(СтруктураЗаписи);
	
КонецПроцедуры

Процедура ЗафиксироватьВыполнениеКорректировкиИнформацииСопоставления(УзелИнформационнойБазы, НомерОтправленного) Экспорт
	
	ТекстЗапроса = "
	|ВЫБРАТЬ 1
	|ИЗ
	|	РегистрСведений.ОбщиеНастройкиУзловИнформационныхБаз КАК ОбщиеНастройкиУзловИнформационныхБаз
	|ГДЕ
	|	ОбщиеНастройкиУзловИнформационныхБаз.УзелИнформационнойБазы = &УзелИнформационнойБазы
	|	И ОбщиеНастройкиУзловИнформационныхБаз.ВыполнитьКорректировкуИнформацииСопоставления
	|	И ОбщиеНастройкиУзловИнформационныхБаз.НомерОтправленного <= &НомерОтправленного
	|	И ОбщиеНастройкиУзловИнформационныхБаз.НомерОтправленного <> 0
	|";
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("УзелИнформационнойБазы", УзелИнформационнойБазы);
	Запрос.УстановитьПараметр("НомерОтправленного", НомерОтправленного);
	Запрос.Текст = ТекстЗапроса;
	
	Если Не Запрос.Выполнить().Пустой() Тогда
		
		СтруктураЗаписи = Новый Структура;
		СтруктураЗаписи.Вставить("УзелИнформационнойБазы", УзелИнформационнойБазы);
		СтруктураЗаписи.Вставить("ВыполнитьКорректировкуИнформацииСопоставления", Ложь);
		
		ОбновитьЗапись(СтруктураЗаписи);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура УстановитьНеобходимостьВыполненияКорректировкиИнформацииСопоставленияДляВсехУзловИнформационнойБазы() Экспорт
	
	СписокПлановОбмена = ОбменДаннымиПовтИсп.СписокПлановОбменаБСП();
	
	Для Каждого Элемент Из СписокПлановОбмена Цикл
		
		ИмяПланаОбмена = Элемент.Значение;
		
		Если Метаданные.ПланыОбмена[ИмяПланаОбмена].РаспределеннаяИнформационнаяБаза Тогда
			Продолжить;
		КонецЕсли;
		
		МассивУзлов = ОбменДаннымиПовтИсп.УзлыПланаОбмена(ИмяПланаОбмена);
		
		Для Каждого Узел Из МассивУзлов Цикл
			
			СтруктураЗаписи = Новый Структура;
			СтруктураЗаписи.Вставить("УзелИнформационнойБазы", Узел);
			СтруктураЗаписи.Вставить("ВыполнитьКорректировкуИнформацииСопоставления", Истина);
			
			ОбновитьЗапись(СтруктураЗаписи);
			
		КонецЦикла;
		
	КонецЦикла;
	
КонецПроцедуры

Функция НеобходимоВыполнитьКорректировкуИнформацииСопоставления(УзелИнформационнойБазы, НомерОтправленного) Экспорт
	
	ТекстЗапроса = "
	|ВЫБРАТЬ 1
	|ИЗ
	|	РегистрСведений.ОбщиеНастройкиУзловИнформационныхБаз КАК ОбщиеНастройкиУзловИнформационныхБаз
	|ГДЕ
	|	  ОбщиеНастройкиУзловИнформационныхБаз.УзелИнформационнойБазы = &УзелИнформационнойБазы
	|	И ОбщиеНастройкиУзловИнформационныхБаз.ВыполнитьКорректировкуИнформацииСопоставления
	|";
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("УзелИнформационнойБазы", УзелИнформационнойБазы);
	Запрос.Текст = ТекстЗапроса;
	
	Результат = Не Запрос.Выполнить().Пустой();
	
	Если Результат Тогда
		
		СтруктураЗаписи = Новый Структура;
		СтруктураЗаписи.Вставить("УзелИнформационнойБазы", УзелИнформационнойБазы);
		СтруктураЗаписи.Вставить("ВыполнитьКорректировкуИнформацииСопоставления", Истина);
		СтруктураЗаписи.Вставить("НомерОтправленного", НомерОтправленного);
		
		ОбновитьЗапись(СтруктураЗаписи);
		
	КонецЕсли;
	
	Возврат Результат;
КонецФункции

//

Процедура УстановитьПризнакОтправкиДанных(Знач Получатель) Экспорт
	
	Если Не ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных() Тогда
		Возврат;
	КонецЕсли;
	
	СтруктураЗаписи = Новый Структура;
	СтруктураЗаписи.Вставить("УзелИнформационнойБазы", Получатель);
	СтруктураЗаписи.Вставить("ВыполнитьОтправкуДанных", Истина);
	
	ОбновитьЗапись(СтруктураЗаписи);
	
КонецПроцедуры

Процедура СнятьПризнакОтправкиДанных(Знач Получатель) Экспорт
	
	Если Не ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных() Тогда
		Возврат;
	КонецЕсли;
	
	Если ВыполнитьОтправкуДанных(Получатель) Тогда
		
		СтруктураЗаписи = Новый Структура;
		СтруктураЗаписи.Вставить("УзелИнформационнойБазы", Получатель);
		СтруктураЗаписи.Вставить("ВыполнитьОтправкуДанных", Ложь);
		
		ОбновитьЗапись(СтруктураЗаписи);
		
	КонецЕсли;
	
КонецПроцедуры

Функция ВыполнитьОтправкуДанных(Знач Получатель) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Если Не ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных() Тогда
		Возврат Ложь;
	КонецЕсли;
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	ОбщиеНастройкиУзловИнформационныхБаз.ВыполнитьОтправкуДанных КАК ВыполнитьОтправкуДанных
	|ИЗ
	|	РегистрСведений.ОбщиеНастройкиУзловИнформационныхБаз КАК ОбщиеНастройкиУзловИнформационныхБаз
	|ГДЕ
	|	ОбщиеНастройкиУзловИнформационныхБаз.УзелИнформационнойБазы = &Получатель";
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Получатель", Получатель);
	Запрос.Текст = ТекстЗапроса;
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();
	
	Возврат Выборка.ВыполнитьОтправкуДанных = Истина;
	
КонецФункции

//

Процедура УстановитьВерсиюКорреспондента(Знач Корреспондент, Знач Версия) Экспорт
	
	Если Не ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных() Тогда
		Возврат;
	КонецЕсли;
	
	Если ПустаяСтрока(Версия) Тогда
		Версия = "0.0.0.0";
	КонецЕсли;
	
	Если ВерсияКорреспондента(Корреспондент) <> СокрЛП(Версия) Тогда
		
		СтруктураЗаписи = Новый Структура;
		СтруктураЗаписи.Вставить("УзелИнформационнойБазы", Корреспондент);
		СтруктураЗаписи.Вставить("ВерсияКорреспондента", СокрЛП(Версия));
		
		ОбновитьЗапись(СтруктураЗаписи);
		
	КонецЕсли;
	
КонецПроцедуры

Функция ВерсияКорреспондента(Знач Корреспондент) Экспорт
	
	Если Не ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных() Тогда
		Возврат "0.0.0.0";
	КонецЕсли;
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	ОбщиеНастройкиУзловИнформационныхБаз.ВерсияКорреспондента КАК ВерсияКорреспондента
	|ИЗ
	|	РегистрСведений.ОбщиеНастройкиУзловИнформационныхБаз КАК ОбщиеНастройкиУзловИнформационныхБаз
	|ГДЕ
	|	ОбщиеНастройкиУзловИнформационныхБаз.УзелИнформационнойБазы = &Корреспондент";
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Корреспондент", Корреспондент);
	Запрос.Текст = ТекстЗапроса;
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		Возврат "0.0.0.0";
	КонецЕсли;
	
	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();
	
	Результат = СокрЛП(Выборка.ВерсияКорреспондента);
	
	Если ПустаяСтрока(Результат) Тогда
		Результат = "0.0.0.0";
	КонецЕсли;
	
	Возврат Результат;
КонецФункции

//

// Процедура обновляет запись в регистре по переданным значениям структуры.
Процедура ОбновитьЗапись(СтруктураЗаписи)
	
	ОбменДаннымиСервер.ОбновитьЗаписьВРегистрСведений(СтруктураЗаписи, "ОбщиеНастройкиУзловИнформационныхБаз");
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
