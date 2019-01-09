#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.ГрупповоеИзменениеОбъектов

// Возвращает реквизиты объекта, которые не рекомендуется редактировать
// с помощью обработки группового изменения реквизитов.
//
// Возвращаемое значение:
//  Массив - список имен реквизитов объекта.
Функция РеквизитыНеРедактируемыеВГрупповойОбработке() Экспорт
	
	Результат = Новый Массив;
	Результат.Добавить("*");
	Возврат Результат;
	
КонецФункции

// Конец СтандартныеПодсистемы.ГрупповоеИзменениеОбъектов

#КонецОбласти

#КонецОбласти

#КонецЕсли

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)
	
	Если Не СтандартнаяОбработка Тогда
		// Обрабатывается в другом месте.
		Возврат;
		
	ИначеЕсли Не Параметры.Свойство("РазрешитьДанныеКлассификатора") Тогда
		// Поведение по умолчанию, подбор только справочника.
		Возврат;
		
	ИначеЕсли Истина <> Параметры.РазрешитьДанныеКлассификатора Тогда
		// Подбор классификатора отключен, поведение по умолчанию.
		Возврат;
	КонецЕсли;
	
	ОбработкаПолученияДанныхВыбораЗаполнение(ДанныеВыбора, Параметры, СтандартнаяОбработка);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункцииКлиент

Процедура ОбработкаПолученияДанныхВыбораЗаполнение(ДанныеВыбора, Параметры, СтандартнаяОбработка)

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	ОбработкаПолученияДанныхВыбораЗаполнениеСервер(ДанныеВыбора, Параметры, СтандартнаяОбработка)
#КонецЕсли

КонецПроцедуры

#КонецОбласти

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Определяет данные страны по справочнику стран или классификатору ОКСМ.
// Рекомендуется использовать УправлениеКонтактнойИнформацией.ДанныеСтраныМира.
//
// Параметры:
//    КодСтраны    - Строка, Число - код ОКСМ страны. Если не указано, то поиск по коду не производится.
//    Наименование - Строка        - наименование страны. Если не указано, то поиск по наименованию не производится.
//
// Возвращаемое значение:
//    Структура - поля:
//          * Код                - Строка - реквизит найденной страны.
//          * Наименование       - Строка - реквизит найденной страны.
//          * НаименованиеПолное - Строка - реквизит найденной страны.
//          * КодАльфа2          - Строка - реквизит найденной страны.
//          * КодАльфа3          - Строка - реквизит найденной страны.
//          * Ссылка             - СправочникаСсылка.СтраныМира - реквизит найденной страны.
//    Неопределено - страна не найдена.
//
Функция ДанныеСтраныМира(Знач КодСтраны = Неопределено, Знач Наименование = Неопределено) Экспорт
	Возврат УправлениеКонтактнойИнформацией.ДанныеСтраныМира(КодСтраны, Наименование);
КонецФункции

// Определяет данные страны по классификатору ОКСМ.
// Рекомендуется использовать УправлениеКонтактнойИнформацией.ДанныеКлассификатораСтранМираПоКоду.
//
// Параметры:
//    Код - Строка, Число - код ОКСМ страны.
//    ТипКода - Строка - Варианты: КодСтраны (по умолчанию), Альфа2, Альфа3.
//
// Возвращаемое значение:
//    Структура - поля:
//          * Код                - Строка - реквизит найденной страны.
//          * Наименование       - Строка - реквизит найденной страны.
//          * НаименованиеПолное - Строка - реквизит найденной страны.
//          * КодАльфа2          - Строка - реквизит найденной страны.
//          * КодАльфа3          - Строка - реквизит найденной страны.
//    Неопределено - страна не найдена.
//
Функция ДанныеКлассификатораСтранМираПоКоду(Знач Код, ТипКода = "КодСтраны") Экспорт
	Возврат УправлениеКонтактнойИнформацией.ДанныеКлассификатораСтранМираПоКоду(Код, ТипКода);
КонецФункции

// Определяет данные страны по классификатору ОКСМ.
// Рекомендуется использовать УправлениеКонтактнойИнформацией.ДанныеКлассификатораСтранМираПоНаименованию.
//
// Параметры:
//    Наименование - Строка - наименование страны.
//
// Возвращаемое значение:
//    Структура - поля:
//          * Код                - Строка - реквизит найденной страны.
//          * Наименование       - Строка - реквизит найденной страны.
//          * НаименованиеПолное - Строка - реквизит найденной страны.
//          * КодАльфа2          - Строка - реквизит найденной страны.
//          * КодАльфа3          - Строка - реквизит найденной страны.
//    Неопределено - страна не найдена.
//
Функция ДанныеКлассификатораСтранМираПоНаименованию(Знач Наименование) Экспорт
	Возврат УправлениеКонтактнойИнформацией.ДанныеКлассификатораСтранМираПоНаименованию(Наименование);
КонецФункции

// Возвращает флаг возможности добавления и изменения элементов.
//
Функция ЕстьПравоДобавления() Экспорт
	Возврат ПравоДоступа("Добавление", Метаданные.Справочники.СтраныМира);
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Возвращает поля поиска в порядке предпочтения для справочника стран мира.
//
// Возвращаемое значение:
//    Массив - содержит структуры с полями:
//      * Имя                 - Строка - имя реквизита поиска.
//      * ШаблонПредставления - Строка - шаблон для формирования значения представления по именам реквизитов, 
//                                       например: "%1.Наименование (%1.Код)". Здесь "Наименование" и "Код" - имена
//                                       реквизитов,
//                                       "%1" - заполнитель для передачи псевдонима таблицы.
//
Функция ПоляПоиска()
	Результат = Новый Массив;
	СписокПолей = ПустаяСсылка().Метаданные().ВводПоСтроке;
	ГраницаПолей = СписокПолей.Количество() - 1;
	ВсеИменаСтрокой = "";
	
	ПредставлениеРазделителя = ", ";
	РазделительПредставлений = " + """ + ПредставлениеРазделителя + """ + ";
	
	Для Индекс=0 По ГраницаПолей Цикл
		ИмяПоля = СписокПолей[Индекс].Имя;
		ВсеИменаСтрокой = ВсеИменаСтрокой + "," + ИмяПоля;
		
		ШаблонПредставления = "%1." + ИмяПоля;
		
		ОстальныеПоля = "";
		Для Позиция=0 По ГраницаПолей Цикл
			Если Позиция<>Индекс Тогда
				ОстальныеПоля = ОстальныеПоля + РазделительПредставлений + СписокПолей[Позиция].Имя;
			КонецЕсли;
		КонецЦикла;
		Если Не ПустаяСтрока(ОстальныеПоля) Тогда
			ШаблонПредставления = ШаблонПредставления
				+ " + "" ("" + " 
				+ "%1." + Сред(ОстальныеПоля, СтрДлина(РазделительПредставлений) + 1) 
				+ " + "")""";
		КонецЕсли;
		
		Результат.Добавить(
			Новый Структура("Имя, ШаблонПредставления", ИмяПоля, ШаблонПредставления));
	КонецЦикла;
	
	Возврат Новый Структура("СписокПолей, ИменаПолейСтрокой", Результат, Сред(ВсеИменаСтрокой, 2));
КонецФункции

// Экранирует символы для использования в функции запроса ПОДОБНО.
//
Функция ЭкранироватьСимволыПодобия(Знач Текст, Знач СпецСимвол = "\")
	Результат = Текст;
	СимволыПодобия = "%_[]^" + СпецСимвол;
	
	Для Позиция=1 По СтрДлина(СимволыПодобия) Цикл
		ТекущийСимвол = Сред(СимволыПодобия, Позиция, 1);
		Результат = СтрЗаменить(Результат, ТекущийСимвол, СпецСимвол + ТекущийСимвол);
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

Процедура ОбработкаПолученияДанныхВыбораЗаполнениеСервер(ДанныеВыбора, Параметры, СтандартнаяОбработка)
	
	Если Не ЕстьПравоДобавления() Тогда
		// Нет прав на добавление страны мира, поведение по умолчанию.
		Возврат;
	КонецЕсли;
	
	// Будем имитировать поведение платформы - поиск по всем доступным полям поиска с формированием подобного списка.
	
	// Подразумеваем, что поля справочника и классификатора совпадают, за исключением отсутствующего в классификаторе поля
	// "Ссылка".
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	ПрефиксПараметраОтбора = "ПараметрыОтбора";
	
	// Общий отбор по параметрам
	ШаблонОтбора = "ИСТИНА";
	Для Каждого КлючЗначение Из Параметры.Отбор Цикл
		ЗначениеПоля = КлючЗначение.Значение;
		ИмяПоля      = КлючЗначение.Ключ;
		ИмяПараметра = ПрефиксПараметраОтбора + ИмяПоля;
		
		Если ТипЗнч(ЗначениеПоля)=Тип("Массив") Тогда
			ШаблонОтбора = ШаблонОтбора + " И %1." + ИмяПоля + " В (&" + ИмяПараметра + ")";
		Иначе
			ШаблонОтбора = ШаблонОтбора + " И %1." + ИмяПоля + " = &" + ИмяПараметра;
		КонецЕсли;
		
		Запрос.УстановитьПараметр(ИмяПараметра, КлючЗначение.Значение);
	КонецЦикла;
	
	// Дополнительные отборы
	Если Параметры.Свойство("ВыборГруппИЭлементов") Тогда
		Если Параметры.ВыборГруппИЭлементов = ИспользованиеГруппИЭлементов.Группы Тогда
			ШаблонОтбора = ШаблонОтбора + " И %1.ЭтоГруппа";
			
		ИначеЕсли Параметры.ВыборГруппИЭлементов = ИспользованиеГруппИЭлементов.Элементы Тогда
			ШаблонОтбора = ШаблонОтбора + " И (НЕ %1.ЭтоГруппа)";
			
		КонецЕсли;
	КонецЕсли;
	
	// Источники данных
	Если (Параметры.Свойство("ТолькоДанныеКлассификатора") И Параметры.ТолькоДанныеКлассификатора) Тогда
		// Запрос только по классификатору.
		ШаблонЗапроса = "
		|ВЫБРАТЬ ПЕРВЫЕ 50
		|	NULL                       КАК Ссылка,
		|	Классификатор.Код          КАК Код,
		|	Классификатор.Наименование КАК Наименование,
		|	ЛОЖЬ                       КАК ПометкаУдаления,
		|	%2                         КАК Представление
		|ИЗ
		|	Классификатор КАК Классификатор
		|ГДЕ
		|	Классификатор.%1 ПОДОБНО &СтрокаПоиска
		|	И (
		|		" + СтрЗаменить(ШаблонОтбора, "%1", "Классификатор") + "
		|	)
		|УПОРЯДОЧИТЬ ПО
		|	Классификатор.%1
		|";
	Иначе
		// Запрос и по справочнику и по классификатору.
		ШаблонЗапроса = "
		|ВЫБРАТЬ ПЕРВЫЕ 50 
		|	СтраныМира.Ссылка                                             КАК Ссылка,
		|	ЕСТЬNULL(СтраныМира.Код, Классификатор.Код)                   КАК Код,
		|	ЕСТЬNULL(СтраныМира.Наименование, Классификатор.Наименование) КАК Наименование,
		|	ЕСТЬNULL(СтраныМира.ПометкаУдаления, ЛОЖЬ)                    КАК ПометкаУдаления,
		|
		|	ВЫБОР КОГДА СтраныМира.Ссылка ЕСТЬ NULL ТОГДА 
		|		%2 
		|	ИНАЧЕ 
		|		%3
		|	КОНЕЦ КАК Представление
		|
		|ИЗ
		|	Справочник.СтраныМира КАК СтраныМира
		|ПОЛНОЕ СОЕДИНЕНИЕ
		|	Классификатор
		|ПО
		|	Классификатор.Код = СтраныМира.Код
		|	И Классификатор.Наименование = СтраныМира.Наименование
		|ГДЕ 
		|	(СтраныМира.%1 ПОДОБНО &СтрокаПоиска ИЛИ Классификатор.%1 ПОДОБНО &СтрокаПоиска)
		|	И (" + СтрЗаменить(ШаблонОтбора, "%1", "Классификатор") + ")
		|	И (" + СтрЗаменить(ШаблонОтбора, "%1", "СтраныМира") + ")
		|
		|УПОРЯДОЧИТЬ ПО
		|	ЕСТЬNULL(СтраныМира.%1, Классификатор.%1)
		|";
	КонецЕсли;
	
	ИменаПолей = ПоляПоиска();
	
	// Код + Наименование - ключевые поля соответствия справочника классификатору. Их обрабатываем всегда.
	ИменаПолейСтрокой = "," + СтрЗаменить(ИменаПолей.ИменаПолейСтрокой, " ", "");
	ИменаПолейСтрокой = СтрЗаменить(ИменаПолейСтрокой, ",Код", "");
	ИменаПолейСтрокой = СтрЗаменить(ИменаПолейСтрокой, ",Наименование", "");
	
	Запрос.Текст = "
	|ВЫБРАТЬ
	|	Код, Наименование " + ИменаПолейСтрокой + "
	|ПОМЕСТИТЬ
	|	Классификатор
	|ИЗ
	|	&Классификатор КАК Классификатор
	|ИНДЕКСИРОВАТЬ ПО
	|	Код, Наименование
	|	" + ИменаПолейСтрокой + "
	|";
	Запрос.УстановитьПараметр("Классификатор", УправлениеКонтактнойИнформацией.ТаблицаКлассификатора());
	Запрос.Выполнить();
	Запрос.УстановитьПараметр("СтрокаПоиска", ЭкранироватьСимволыПодобия(Параметры.СтрокаПоиска) + "%");
	
	Для Каждого ДанныеПоля Из ИменаПолей.СписокПолей Цикл
		ТекстЗапроса = СтрЗаменить(ШаблонЗапроса, "%1", ДанныеПоля.Имя);
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "%2", СтрЗаменить(ДанныеПоля.ШаблонПредставления, "%1", "Классификатор"));
		Запрос.Текст = СтрЗаменить(ТекстЗапроса, "%3", СтрЗаменить(ДанныеПоля.ШаблонПредставления, "%1", "СтраныМира"));
		
		Результат = Запрос.Выполнить();
		Если Не Результат.Пустой() Тогда
			ДанныеВыбора = Новый СписокЗначений;
			СтандартнаяОбработка = Ложь;
			
			Выборка = Результат.Выбрать();
			Пока Выборка.Следующий() Цикл
				Если ЗначениеЗаполнено(Выборка.Ссылка) Тогда
					// Данные справочника
					ЭлементВыбора = Выборка.Ссылка;
				Иначе
					// Данные классификатора
					РезультатВыбора = Новый Структура("Код, Наименование", 
					Выборка.Код, Выборка.Наименование);
					
					ЭлементВыбора = Новый Структура("Значение, ПометкаУдаления, Предупреждение",
					РезультатВыбора, Выборка.ПометкаУдаления, Неопределено);
				КонецЕсли;
				
				ДанныеВыбора.Добавить(ЭлементВыбора, Выборка.Представление);
			КонецЦикла;
			
			Прервать;
		КонецЕсли;
	КонецЦикла;

КонецПроцедуры

#Область ОбновлениеИнформационнойБазы

// Регистрирует к обработке страны мира.
//
Процедура ЗаполнитьСписокСтранКОбработке(Параметры) Экспорт
	
	ЗначенияОКСМ = УправлениеКонтактнойИнформацией.СтраныУчастникиЕАЭС();
	
	НоваяСтрока                    = ЗначенияОКСМ.Добавить();
	НоваяСтрока.Код                = "203";
	НоваяСтрока.Наименование       = НСтр("ru='ЧЕШСКАЯ РЕСПУБЛИКА'");
	НоваяСтрока.КодАльфа2          = "CZ";
	НоваяСтрока.КодАльфа3          = "CZE";
	
	НоваяСтрока                    = ЗначенияОКСМ.Добавить();
	НоваяСтрока.Код                = "270";
	НоваяСтрока.Наименование       = НСтр("ru='ГАМБИЯ'");
	НоваяСтрока.КодАльфа2          = "GM";
	НоваяСтрока.КодАльфа3          = "GMB";
	НоваяСтрока.НаименованиеПолное = НСтр("ru='Республика Гамбия'");
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
		|	СписокСтран.Код КАК Код,
		|	СписокСтран.Наименование КАК Наименование,
		|	СписокСтран.КодАльфа2 КАК КодАльфа2,
		|	СписокСтран.КодАльфа3 КАК КодАльфа3,
		|	СписокСтран.НаименованиеПолное КАК НаименованиеПолное
		|ПОМЕСТИТЬ СписокСтран
		|ИЗ
		|	&СписокСтран КАК СписокСтран
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	СтраныМира.Ссылка КАК Ссылка
		|ИЗ
		|	СписокСтран КАК СписокСтран
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.СтраныМира КАК СтраныМира
		|		ПО (СтраныМира.Код = СписокСтран.Код)
		|			И (СтраныМира.Наименование = СписокСтран.Наименование)
		|			И (СтраныМира.КодАльфа2 = СписокСтран.КодАльфа2)
		|			И (СтраныМира.КодАльфа3 = СписокСтран.КодАльфа3)
		|			И (СтраныМира.НаименованиеПолное = СписокСтран.НаименованиеПолное)";
	
	Запрос.УстановитьПараметр("СписокСтран", ЗначенияОКСМ);
	РезультатЗапроса = Запрос.Выполнить().Выгрузить();
	СтраныКОбработке = РезультатЗапроса.ВыгрузитьКолонку("Ссылка");
	
	ОбновлениеИнформационнойБазы.ОтметитьКОбработке(Параметры, СтраныКОбработке);
	
КонецПроцедуры

Процедура ОбновитьСтраныМираПоОКСМ(Параметры) Экспорт
	
	СтранаМираСсылка = ОбновлениеИнформационнойБазы.ВыбратьСсылкиДляОбработки(Параметры.Очередь, "Справочник.СтраныМира");
	
	ПроблемныхОбъектов = 0;
	ОбъектовОбработано = 0;
	
	Пока СтранаМираСсылка.Следующий() Цикл
		Попытка
			
			ДанныеОКСМ = УправлениеКонтактнойИнформацией.ДанныеКлассификатораСтранМираПоКоду(СтранаМираСсылка.Ссылка.Код);
			
			Если ДанныеОКСМ <> Неопределено Тогда
				СтранаМира = СтранаМираСсылка.Ссылка.ПолучитьОбъект();
				ЗаполнитьЗначенияСвойств(СтранаМира, ДанныеОКСМ);
				ОбновлениеИнформационнойБазы.ЗаписатьДанные(СтранаМира);
			КонецЕсли;
			
			ОбъектовОбработано = ОбъектовОбработано + 1;
			
		Исключение
			// Если не удалось обработать страну мира, повторяем попытку снова.
			ПроблемныхОбъектов = ПроблемныхОбъектов + 1;
			
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Не удалось обработать страну: %1 по причине: %2'"),
					СтранаМираСсылка.Ссылка, ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			ЗаписьЖурналаРегистрации(ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(), УровеньЖурналаРегистрации.Предупреждение,
				Метаданные.Справочники.СтраныМира, СтранаМираСсылка.Ссылка, ТекстСообщения);
		КонецПопытки;
	КонецЦикла;
	
	Параметры.ОбработкаЗавершена = ОбновлениеИнформационнойБазы.ОбработкаДанныхЗавершена(Параметры.Очередь, "Справочник.СтраныМира");
	
	Если ОбъектовОбработано = 0 И ПроблемныхОбъектов <> 0 Тогда
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Процедуре ОбновитьСтраныМираПоОКСМ не удалось обработать некоторые страны мира(пропущены): %1'"), 
				ПроблемныхОбъектов);
		ВызватьИсключение ТекстСообщения;
	Иначе
		ЗаписьЖурналаРегистрации(ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(), УровеньЖурналаРегистрации.Информация,
			Метаданные.Справочники.СтраныМира,,
				СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Процедура ОбновитьСтраныМираПоОКСМ обработала очередную порцию стран мира: %1'"),
					ОбъектовОбработано));
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли

