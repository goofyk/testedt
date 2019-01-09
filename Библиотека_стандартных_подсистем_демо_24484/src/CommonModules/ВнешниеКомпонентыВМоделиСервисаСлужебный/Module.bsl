

#Область СлужебныйПрограммныйИнтерфейс

// Параметры:
//  Параметры - Структура - .
//      * Идентификатор - Строка               - идентификатор объекта внешнего компонента.
//      * Версия        - Строка, Неопределено - версия компоненты. 
//
// Возвращаемое значение:
//  Структура - информация о компоненте.
//
Функция ПолучениеСлужебнойИнформацииОКомпоненте(Идентификатор, Версия = Неопределено) Экспорт 
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Идентификатор", Идентификатор);
	Если Версия = Неопределено Тогда 
		Запрос.Текст = 
			"ВЫБРАТЬ
			|	МАКСИМУМ(ОбщиеВнешниеКомпоненты.ДатаВерсии) КАК ДатаВерсии,
			|	ОбщиеВнешниеКомпоненты.Идентификатор КАК Идентификатор
			|ПОМЕСТИТЬ ВТ_МаксимальнаяВерсияКомпоненты
			|ИЗ
			|	Справочник.ОбщиеВнешниеКомпоненты КАК ОбщиеВнешниеКомпоненты
			|ГДЕ
			|	ОбщиеВнешниеКомпоненты.Идентификатор = &Идентификатор
			|
			|СГРУППИРОВАТЬ ПО
			|	ОбщиеВнешниеКомпоненты.Идентификатор
			|;
			|
			|////////////////////////////////////////////////////////////////////////////////
			|ВЫБРАТЬ
			|	ОбщиеВнешниеКомпоненты.Ссылка КАК Ссылка
			|ИЗ
			|	ВТ_МаксимальнаяВерсияКомпоненты КАК ВТ_МаксимальнаяВерсияКомпоненты
			|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ОбщиеВнешниеКомпоненты КАК ОбщиеВнешниеКомпоненты
			|		ПО (ОбщиеВнешниеКомпоненты.ДатаВерсии = ВТ_МаксимальнаяВерсияКомпоненты.ДатаВерсии)
			|			И (ОбщиеВнешниеКомпоненты.Идентификатор = ВТ_МаксимальнаяВерсияКомпоненты.Идентификатор)";
	Иначе 
		Запрос.УстановитьПараметр("Версия", Версия);
		Запрос.Текст = 
			"ВЫБРАТЬ
			|	ОбщиеВнешниеКомпоненты.Ссылка КАК Ссылка,
			|	ОбщиеВнешниеКомпоненты.Версия КАК Версия
			|ИЗ
			|	Справочник.ОбщиеВнешниеКомпоненты КАК ОбщиеВнешниеКомпоненты
			|ГДЕ
			|	ОбщиеВнешниеКомпоненты.Идентификатор = &Идентификатор
			|	И ОбщиеВнешниеКомпоненты.Версия = &Версия";
		
	КонецЕсли;
	
	Результат = Запрос.Выполнить();
	
	Если Результат.Пустой() Тогда
		ВызватьИсключение НСтр("ru = 'Внешняя компонента не найдена.'");
	КонецЕсли;
	
	Ссылка = Результат.Выгрузить()[0].Ссылка;
	
	Результат = Новый Структура;
	Результат.Вставить("Windows_x86");
	Результат.Вставить("Windows_x86_64");
	Результат.Вставить("Linux_x86");
	Результат.Вставить("Linux_x86_64");
	Результат.Вставить("Windows_x86_Firefox");
	Результат.Вставить("Linux_x86_Firefox");
	Результат.Вставить("Linux_x86_64_Firefox");
	Результат.Вставить("Windows_x86_MSIE");
	Результат.Вставить("Windows_x86_64_MSIE");
	Результат.Вставить("Windows_x86_Chrome");
	Результат.Вставить("Linux_x86_Chrome");
	Результат.Вставить("Linux_x86_64_Chrome");
	Результат.Вставить("MacOS_x86_64_Safari");
	
	Реквизиты = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Ссылка, Результат);
	
	ЗаполнитьЗначенияСвойств(Результат, Реквизиты);
	
	Местоположение = ПолучитьНавигационнуюСсылку(Ссылка, "ХранилищеКомпоненты");
	Результат.Вставить("Местоположение", Местоположение);
	
	Возврат Результат;
	
КонецФункции

#Область ОбработчикиСобытийПодсистемКонфигурации

#Область СтандартныеПодсистемы

// См. ПоставляемыеДанныеПереопределяемый.ПолучитьОбработчикиПоставляемыхДанных.
Процедура ПриОпределенииОбработчиковПоставляемыхДанных(Обработчики) Экспорт
	
	ЗарегистрироватьОбработчикиПоставляемыхДанных(Обработчики);
	
КонецПроцедуры

#КонецОбласти

#Область ПоставляемыеДанные

// Регистрирует обработчики поставляемых данных за день и за все время
//
Процедура ЗарегистрироватьОбработчикиПоставляемыхДанных(Знач Обработчики) Экспорт
	
	Обработчик = Обработчики.Добавить();
	Обработчик.ВидДанных = ИдентификаторВидаПоставляемыхДанных();
	Обработчик.КодОбработчика = ИдентификаторВидаПоставляемыхДанных();
	Обработчик.Обработчик = ВнешниеКомпонентыВМоделиСервисаСлужебный;
	
КонецПроцедуры

// Вызывается при получении уведомления о новых данных.
// В теле следует проверить, необходимы ли эти данные приложению, 
// и если да - установить флажок Загружать.
// 
// Параметры:
//   Дескриптор   - ОбъектXDTO Descriptor.
//   Загружать    - булево, возвращаемое.
//
Процедура ДоступныНовыеДанные(Знач Дескриптор, Загружать) Экспорт
	
	Если Дескриптор.DataType = ИдентификаторВидаПоставляемыхДанных() Тогда
		Загружать = Истина;
	КонецЕсли;
	
КонецПроцедуры

// Вызывается после вызова ДоступныНовыеДанные, позволяет разобрать данные.
//
// Параметры:
//   Дескриптор   - ОбъектXDTO Дескриптор.
//   ПутьКФайлу   - Строка или Неопределено. Полное имя извлеченного файла. Файл будет автоматически удален 
//                  после завершения процедуры. Если в менеджере сервиса не был
//                  указан файл - значение аргумента равно Неопределено.
//
Процедура ОбработатьНовыеДанные(Знач Дескриптор, Знач ПутьКФайлу) Экспорт
	
	Если Дескриптор.DataType = ИдентификаторВидаПоставляемыхДанных() Тогда
		ОбработатьПоставляемыеДополнительныеОтчетыИОбработки(Дескриптор, ПутьКФайлу);
	КонецЕсли;
	
КонецПроцедуры

// Вызывается при отмене обработки данных в случае сбоя
//
Процедура ОбработкаДанныхОтменена(Знач Дескриптор) Экспорт 
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ПоставляемыеДанные

// Возвращает идентификатор вида поставляемых данных для дополнительных отчетов
// и обработок.
//
// Возвращаемое значение: Строка.
Функция ИдентификаторВидаПоставляемыхДанных()
	
	Возврат "ВнешниеКомпоненты"; // Не локализуется
	
КонецФункции

Функция ОписаниеПоставляемойОбработки()
	
	Возврат Новый Структура("Идентификатор, Версия, ДатаВерсии, Наименование");
	
КонецФункции

Функция РазобратьДескрипторПоставляемыхДанных(Дескриптор)
	
	ОписаниеПоставляемойОбработки = ОписаниеПоставляемойОбработки();
	
	Для Каждого ХарактеристикаПоставляемыхДанных Из Дескриптор.Properties.Property Цикл
		
		ОписаниеПоставляемойОбработки[ХарактеристикаПоставляемыхДанных.Code] = ХарактеристикаПоставляемыхДанных.Value;
		
	КонецЦикла;
	
	Возврат ОписаниеПоставляемойОбработки;
	
КонецФункции

Процедура ОбработатьПоставляемыеДополнительныеОтчетыИОбработки(Дескриптор, ПутьКФайлу)
	
	УстановитьПривилегированныйРежим(Истина);
	
	// Прочитаем характеристики экземпляра поставляемых данных
	ОписаниеПоставляемойКомпоеннты = РазобратьДескрипторПоставляемыхДанных(Дескриптор);
	
	ЗаписьЖурналаРегистрации(НСтр("ru = 'Поставляемые внешние компоненты.Загрузка поставляемой компоненты'", 
		ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
		УровеньЖурналаРегистрации.Информация,
		,
		,
		НСтр("ru = 'Инициирована загрузка поставляемой обработки'") + Символы.ПС + Символы.ВК
			+ ОписаниеПоставляемойКомпоеннты.Наименование + " " + ОписаниеПоставляемойКомпоеннты.Версия);
		
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Идентификатор", ОписаниеПоставляемойКомпоеннты.Идентификатор);
	Запрос.УстановитьПараметр("Версия", ОписаниеПоставляемойКомпоеннты.Версия);
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ОбщиеВнешниеКомпоненты.Ссылка КАК Ссылка,
		|	ОбщиеВнешниеКомпоненты.Версия КАК Версия
		|ИЗ
		|	Справочник.ОбщиеВнешниеКомпоненты КАК ОбщиеВнешниеКомпоненты
		|ГДЕ
		|	ОбщиеВнешниеКомпоненты.Идентификатор = &Идентификатор
		|	И ОбщиеВнешниеКомпоненты.Версия = &Версия";
	
	Результат = Запрос.Выполнить();
	
	Если Результат.Пустой() Тогда
		ОбщаяКомпонента = Справочники.ОбщиеВнешниеКомпоненты.СоздатьЭлемент();
	Иначе 
		СсылкаОбщейКомпоненты = Результат.Выгрузить()[0].Ссылка;
		ОбщаяКомпонента = СсылкаОбщейКомпоненты.ПолучитьОбъект();
	КонецЕсли;
	
	ОбщаяКомпонента.Заполнить(Неопределено); // Конструктор по умолчанию.
	
	ДвоичныеДанныеКомпоненты = Новый ДвоичныеДанные(ПутьКФайлу);
	АдресХранилищаФайла = ПоместитьВоВременноеХранилище(ДвоичныеДанныеКомпоненты);
	Информация = ВнешниеКомпонентыСлужебный.ИнформацияОКомпоненте(АдресХранилищаФайла, Ложь);
	
	Если Не Информация.Разобрано Тогда 
		ЗаписьЖурналаРегистрации(НСтр("ru = 'Поставляемые внешние компоненты.Загрузка поставляемой компоненты'",
			ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
		УровеньЖурналаРегистрации.Ошибка, , , Информация.ОписаниеОшибки);
		Возврат;
	КонецЕсли;
	
	ЗаполнитьЗначенияСвойств(ОбщаяКомпонента, Информация.Реквизиты);           // По данным манифеста.
	ЗаполнитьЗначенияСвойств(ОбщаяКомпонента, ОписаниеПоставляемойКомпоеннты); // По данным с сайта.
	
	ОбщаяКомпонента.ХранилищеКомпоненты = Новый ХранилищеЗначения(ДвоичныеДанныеКомпоненты);
	
	Попытка
		ОбщаяКомпонента.Записать();
	Исключение
		ЗаписьЖурналаРегистрации(НСтр("ru = 'Поставляемые внешние компоненты.Загрузка поставляемой компоненты'",
				ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
			УровеньЖурналаРегистрации.Ошибка,,, ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
	КонецПопытки;
	
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
