#Область СлужебныйПрограммныйИнтерфейс

// Курсорные запросы для независимых наборов записей

Функция ПолучитьПорциюДанныхНезависимогоНабораЗаписей(Знач МетаданныеОбъекта, Знач Отбор,
		Знач РазмерПорции, МожноПродолжать, Состояние, Знач ДополнениеКИмениТаблицы = "") Экспорт
	
	Если Состояние = Неопределено Тогда
		Состояние = ИнициализироватьСостояниеДляВыборкиПорцийНезависимогоНабораЗаписей(МетаданныеОбъекта, Отбор, ДополнениеКИмениТаблицы);
		МожноПродолжать = Истина;
	КонецЕсли;
	
	Результат = Новый Массив;
	
	ОсталосьПолучить = РазмерПорции; // Осталось получить в этой порции
	
	ПерваяВыборка = Ложь;
	
	ТекущийЗапрос = 0; // Индекс текущего запроса
	
	Пока Истина Цикл // Получение фрагментов порций
		ФрагментПорции = Неопределено; // Последний полученный фрагмент порции
		
		Если НЕ Состояние.БылаВыборка Тогда // Первый запрос
			Состояние.БылаВыборка = Истина;
			ПерваяВыборка = Истина;
			
			Запрос = Новый Запрос;
			Запрос.Текст = СтрЗаменить(Состояние.Запросы.Первый, "[РазмерПорции]", Формат(ОсталосьПолучить, "ЧГ="));
		Иначе
			Запрос = Новый Запрос;
			Если Состояние.Запросы.Последующие.Количество() <> 0 Тогда 
				ОписаниеЗапроса = Состояние.Запросы.Последующие[ТекущийЗапрос];
				ТекущийЗапрос = ТекущийЗапрос + 1;
				Запрос.Текст = СтрЗаменить(ОписаниеЗапроса.Текст, "[РазмерПорции]", Формат(ОсталосьПолучить, "ЧГ="));
				Если ОписаниеЗапроса.ПоляУсловия <> Неопределено Тогда 
					Для каждого ПолеУсловия Из ОписаниеЗапроса.ПоляУсловия Цикл
						Запрос.УстановитьПараметр(ПолеУсловия, Состояние.Ключ[ПолеУсловия]);
					КонецЦикла;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
		
		Для каждого ПараметрОтбора Из Состояние.Запросы.Параметры Цикл
			Запрос.УстановитьПараметр(ПараметрОтбора.Ключ, ПараметрОтбора.Значение);
		КонецЦикла;
		
		Если Не ПустаяСтрока(Запрос.Текст) Тогда 
			ФрагментПорции = Запрос.Выполнить().Выгрузить();
			
			РазмерФрагмента = ФрагментПорции.Количество();
		Иначе
			РазмерФрагмента = 0;
		КонецЕсли;
		
		Если РазмерФрагмента > 0 Тогда
			Результат.Добавить(ФрагментПорции);
			
			ЗаполнитьЗначенияСвойств(Состояние.Ключ, ФрагментПорции[РазмерФрагмента - 1]);
		КонецЕсли;
		
		Если РазмерФрагмента < ОсталосьПолучить Тогда
			
			Если НЕ ПерваяВыборка // Если это был первый запрос - нет смысла продолжать
				И ТекущийЗапрос < Состояние.Запросы.Последующие.Количество() Тогда
				
				ОсталосьПолучить = ОсталосьПолучить - РазмерФрагмента;
				
				Продолжить; // Переход к следующему запросу
			Иначе
				МожноПродолжать = Ложь;
			КонецЕсли;
		КонецЕсли;
		
		Прервать;
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Курсорные запросы для независимых наборов записей

Функция ИнициализироватьСостояниеДляВыборкиПорцийНезависимогоНабораЗаписей(Знач МетаданныеОбъекта, Знач Отбор, Знач ДополнениеКИмениТаблицы = "")
	
	ЭтоРегистрСведений    = Метаданные.РегистрыСведений.Содержит(МетаданныеОбъекта);
	
	ЭтоПоследовательность = Метаданные.Последовательности.Содержит(МетаданныеОбъекта);
	
	ПоляКлюча = Новый Массив; // Поля образующие ключ записи
	
	Если ЭтоРегистрСведений И МетаданныеОбъекта.ПериодичностьРегистраСведений 
		<> Метаданные.СвойстваОбъектов.ПериодичностьРегистраСведений.Непериодический Тогда
		
		ПоляКлюча.Добавить("Период");
	КонецЕсли;
	
	Если ЭтоПоследовательность Тогда 
		
		ПоляКлюча.Добавить("Регистратор");
		ПоляКлюча.Добавить("Период");
		
	КонецЕсли;
	
	ДобавитьРазделителиВКлюч(МетаданныеОбъекта, ПоляКлюча);
	
	Для каждого МетаданныеИзмерения Из МетаданныеОбъекта.Измерения Цикл
		ПоляКлюча.Добавить(МетаданныеИзмерения.Имя);
	КонецЦикла;
	
	ПоляВыборки = Новый Массив; // Все поля
	
	Если ЭтоРегистрСведений Тогда 
		
		Для Каждого МетаданныеРесурса Из МетаданныеОбъекта.Ресурсы Цикл
			ПоляВыборки.Добавить(МетаданныеРесурса.Имя);
		КонецЦикла;
		
		Для Каждого МетаданныеРеквизита Из МетаданныеОбъекта.Реквизиты Цикл
			ПоляВыборки.Добавить(МетаданныеРеквизита.Имя);
		КонецЦикла;
		
	КонецЕсли;
	
	Для каждого ПолеКлюча Из ПоляКлюча Цикл
		ПоляВыборки.Добавить(ПолеКлюча);
	КонецЦикла;
	
	ПсевдонимТаблицы = "_ТаблицаНабораЗаписей"; // Псевдоним таблицы в тексте запроса
	
	СтрокаПолейВыборки = ""; // Часть текста запроса с полями выборки
	Для каждого ПолеВыборки Из ПоляВыборки Цикл
		Если НЕ ПустаяСтрока(СтрокаПолейВыборки) Тогда
			СтрокаПолейВыборки = СтрокаПолейВыборки + "," + Символы.ПС;
		КонецЕсли;
		
		СтрокаПолейВыборки = СтрокаПолейВыборки + Символы.Таб + ПсевдонимТаблицы + "." + ПолеВыборки + " КАК " + ПолеВыборки;
	КонецЦикла;
	
	СтрокаПолейУпорядочивания = ""; //Часть текста запроса с полями упорядочивания
	Для каждого ПолеКлюча Из ПоляКлюча Цикл
		Если НЕ ПустаяСтрока(СтрокаПолейУпорядочивания) Тогда
			СтрокаПолейУпорядочивания = СтрокаПолейУпорядочивания + ", ";
		КонецЕсли;
		СтрокаПолейУпорядочивания = СтрокаПолейУпорядочивания + ПолеКлюча;
	КонецЦикла;
	
	Если ТипЗнч(Отбор) = Тип("Массив") Тогда
		Отбор = СформироватьУсловиеОтбора(ПсевдонимТаблицы, Отбор);
	КонецЕсли;
	
	// Подготовка запросов для получения порций
	Если ПоляКлюча.Количество() = 0 Тогда 
		ШаблонЗапроса = // Общая часть запроса
		"ВЫБРАТЬ
		|" + СтрокаПолейВыборки + "
		|ИЗ
		|	" + МетаданныеОбъекта.ПолноеИмя() + ДополнениеКИмениТаблицы + " КАК " + ПсевдонимТаблицы + "
		|[Условие]";
	Иначе
		ШаблонЗапроса = // Общая часть запроса
		"ВЫБРАТЬ ПЕРВЫЕ [РазмерПорции]
		|" + СтрокаПолейВыборки + "
		|ИЗ
		|	" + МетаданныеОбъекта.ПолноеИмя() + ДополнениеКИмениТаблицы + " КАК " + ПсевдонимТаблицы + "
		|[Условие]
		|УПОРЯДОЧИТЬ ПО
		|	" + СтрокаПолейУпорядочивания;
	КонецЕсли;
	
	// Запрос для получения первой порции
	Если НЕ ПустаяСтрока(Отбор.УсловиеОтбора) Тогда
		ТекстЗапросаПолученияПервойПорции = СтрЗаменить(ШаблонЗапроса, 
			"[Условие]", 
			"ГДЕ
			|	" + Отбор.УсловиеОтбора);
	Иначе
		ТекстЗапросаПолученияПервойПорции = СтрЗаменить(ШаблонЗапроса, "[Условие]", ""); // Запрос для получения первой порции
	КонецЕсли;
	
	Запросы = Новый Массив; // Запросы для получения последующих порций
	Для СчетчикЗапросов = 0 По ПоляКлюча.ВГраница() Цикл
		
		СтрокаПолейУсловия = ""; // Часть текста запроса с полями условия
		ПоляУсловия = Новый Массив; // Поля участвующие в условии
		
		КоличествоПолейУсловий = ПоляКлюча.Количество() - СчетчикЗапросов;
		Для ИндексПоля = 0 По КоличествоПолейУсловий - 1 Цикл
			Если НЕ ПустаяСтрока(СтрокаПолейУсловия) Тогда
				СтрокаПолейУсловия = СтрокаПолейУсловия + " И ";
			КонецЕсли;
			
			ПолеКлюча = ПоляКлюча[ИндексПоля];
			
			Если ИндексПоля = КоличествоПолейУсловий - 1 Тогда
				ЛогическийОператор = ">";
			Иначе
				ЛогическийОператор = "=";
			КонецЕсли;
			
			СтрокаПолейУсловия = СтрокаПолейУсловия + ПсевдонимТаблицы + "." + ПолеКлюча + " " 
				+ ЛогическийОператор + " &" + ПолеКлюча;
				
			ПоляУсловия.Добавить(ПолеКлюча);
		КонецЦикла;
		
		Если НЕ ПустаяСтрока(Отбор.УсловиеОтбора) Тогда
			СтрокаПолейУсловия = Отбор.УсловиеОтбора + " И " + СтрокаПолейУсловия;
		КонецЕсли;
		
		ОписаниеЗапроса = Новый Структура("Текст, ПоляУсловия");
		ОписаниеЗапроса.Текст = СтрЗаменить(ШаблонЗапроса, "[Условие]", 
			"ГДЕ
			|	" + СтрокаПолейУсловия);
		ОписаниеЗапроса.ПоляУсловия = Новый ФиксированныйМассив(ПоляУсловия);
		
		Запросы.Добавить(Новый ФиксированнаяСтруктура(ОписаниеЗапроса));
		
	КонецЦикла;
	
	ОписанияЗапросов = Новый Структура;
	ОписанияЗапросов.Вставить("Первый", ТекстЗапросаПолученияПервойПорции);
	ОписанияЗапросов.Вставить("Последующие", Новый ФиксированныйМассив(Запросы));
	ОписанияЗапросов.Вставить("Параметры", Отбор.ПараметрыОтбора);
	
	СтруктураКлюча = Новый Структура; // Структура для хранения значения последнего ключа
	Для каждого ПолеКлюча Из ПоляКлюча Цикл
		СтруктураКлюча.Вставить(ПолеКлюча);
	КонецЦикла;
	
	Состояние = Новый Структура;
	Состояние.Вставить("Запросы", Новый ФиксированнаяСтруктура(ОписанияЗапросов));
	Состояние.Вставить("Ключ", СтруктураКлюча);
	Состояние.Вставить("БылаВыборка", Ложь);
	
	Возврат Состояние;
	
КонецФункции

Процедура ДобавитьРазделителиВКлюч(МетаданныеОбъекта, ПоляКлюча)
	
	Для Каждого ОбщийРеквизит Из Метаданные.ОбщиеРеквизиты Цикл 

		Если Не ОбщийРеквизит.ИспользованиеРазделяемыхДанных = Метаданные.СвойстваОбъектов.ИспользованиеРазделяемыхДанныхОбщегоРеквизита.НезависимоИСовместно Тогда 
			Продолжить;
		КонецЕсли;
		
		ЭлементОбщегоРеквизита = ОбщийРеквизит.Состав.Найти(МетаданныеОбъекта);
		Если ЭлементОбщегоРеквизита <> Неопределено Тогда
			
			Если ЭлементИспользуетсяВРазделителе(ОбщийРеквизит, ЭлементОбщегоРеквизита) Тогда  
				ПоляКлюча.Добавить(ОбщийРеквизит.Имя);
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Функция ЭлементИспользуетсяВРазделителе(ОбщийРеквизит, ЭлементОбщегоРеквизита)
	
	АвтоИспользованиеОбщегоРеквизита = Метаданные.СвойстваОбъектов.АвтоИспользованиеОбщегоРеквизита;
	ИспользованиеОбщегоРеквизита     = Метаданные.СвойстваОбъектов.ИспользованиеОбщегоРеквизита;
	
	Если ОбщийРеквизит.АвтоИспользование = АвтоИспользованиеОбщегоРеквизита.Использовать Тогда 
		Если ЭлементОбщегоРеквизита.Использование = ИспользованиеОбщегоРеквизита.Авто
			Или ЭлементОбщегоРеквизита.Использование = ИспользованиеОбщегоРеквизита.Использовать Тогда 
				Возврат Истина;
		Иначе
				Возврат Ложь;
		КонецЕсли;
	Иначе
		Если ЭлементОбщегоРеквизита.Использование = ИспользованиеОбщегоРеквизита.Авто
			Или ЭлементОбщегоРеквизита.Использование = ИспользованиеОбщегоРеквизита.НеИспользовать Тогда 
				Возврат Ложь;
		Иначе
				Возврат Истина;
		КонецЕсли;
	КонецЕсли;
	
КонецФункции

Функция СформироватьУсловиеОтбора(Знач ПсевдонимТаблицы, Знач Отбор)
	
	СтрокаОтбора = ""; // Часть текста запроса с условием образованным отбором
	ПараметрыОтбора = Новый Структура;
	Если Отбор.Количество() > 0 Тогда
		Для каждого ОписаниеОтбора Из Отбор Цикл
			Если НЕ ПустаяСтрока(СтрокаОтбора) Тогда
				СтрокаОтбора = СтрокаОтбора + " И ";
			КонецЕсли;
			
			ИмяПараметра = "П" + Формат(ПараметрыОтбора.Количество(), "ЧН=0; ЧГ=");
			ПараметрыОтбора.Вставить(ИмяПараметра, ОписаниеОтбора.Значение);
			
			Операнд = "&" + ИмяПараметра;
			
			Если ОписаниеОтбора.ВидСравнения = ВидСравнения.Равно Тогда
				ЛогическийОператор = "=";
			ИначеЕсли ОписаниеОтбора.ВидСравнения = ВидСравнения.НеРавно Тогда
				ЛогическийОператор = "<>";
			ИначеЕсли ОписаниеОтбора.ВидСравнения = ВидСравнения.ВСписке Тогда
				ЛогическийОператор = "В";
				Операнд = "(" + Операнд + ")";
			ИначеЕсли ОписаниеОтбора.ВидСравнения = ВидСравнения.НеВСписке Тогда
				ЛогическийОператор = "НЕ В";
				Операнд = "(" + Операнд + ")";
			ИначеЕсли ОписаниеОтбора.ВидСравнения = ВидСравнения.Больше Тогда
				ЛогическийОператор = ">";
			ИначеЕсли ОписаниеОтбора.ВидСравнения = ВидСравнения.БольшеИлиРавно Тогда
				ЛогическийОператор = ">=";
			ИначеЕсли ОписаниеОтбора.ВидСравнения = ВидСравнения.Меньше Тогда
				ЛогическийОператор = "<";
			ИначеЕсли ОписаниеОтбора.ВидСравнения = ВидСравнения.МеньшеИлиРавно Тогда
				ЛогическийОператор = "<=";
			Иначе
				ШаблонСообщения = НСтр("ru = 'Вид сравнения %1 не поддерживается.'");
				ТекстСообщения = СтрШаблон(ШаблонСообщения, ОписаниеОтбора.ВидСравнения);
			КонецЕсли;
			
			СтрокаОтбора = СтрокаОтбора + ПсевдонимТаблицы + "." + ОписаниеОтбора.Поле + " " + ЛогическийОператор + " " + Операнд;
		КонецЦикла;
	КонецЕсли;
	
	Возврат Новый Структура("УсловиеОтбора, ПараметрыОтбора", СтрокаОтбора, ПараметрыОтбора);
	
КонецФункции

#КонецОбласти

