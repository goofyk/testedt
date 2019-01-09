#Область ОписаниеПеременных

&НаКлиенте
Перем ВнешниеРесурсыРазрешены;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	УстановитьВидимостьЭлементовФормы();
	
	Если ЗначениеЗаполнено(Запись.ВидТранспортаСообщенийОбменаПоУмолчанию) Тогда
		
		ИмяСтраницы = "НастройкиТранспорта[ВидТранспорта]";
		ИмяСтраницы = СтрЗаменить(ИмяСтраницы, "[ВидТранспорта]"
		, ОбщегоНазначения.ИмяЗначенияПеречисления(Запись.ВидТранспортаСообщенийОбменаПоУмолчанию));
		
		Если Элементы[ИмяСтраницы].Видимость Тогда
			
			Элементы.СтраницыВидовТранспорта.ТекущаяСтраница = Элементы[ИмяСтраницы];
			
		КонецЕсли;
		
	КонецЕсли;
	
	СобытиеЖурналаРегистрацииУстановкаПодключенияКWebСервису 
		= ОбменДаннымиСервер.СобытиеЖурналаРегистрацииУстановкаПодключенияКWebСервису();
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ПолучениеФайловИзИнтернета") Тогда
		Элементы.ПараметрыДоступаВИнтернет.Видимость = Истина;
		Элементы.ПараметрыДоступаВИнтернет1.Видимость = Истина;
	Иначе
		Элементы.ПараметрыДоступаВИнтернет.Видимость = Ложь;
		Элементы.ПараметрыДоступаВИнтернет1.Видимость = Ложь;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Запись.Узел) Тогда
		УстановитьПривилегированныйРежим(Истина);
		Пароли = ОбщегоНазначения.ПрочитатьДанныеИзБезопасногоХранилища(Запись.Узел, "COMПарольПользователя, FTPСоединениеПароль, WSПароль, ПарольАрхиваСообщенияОбмена", Истина);
		УстановитьПривилегированныйРежим(Ложь);
		COMПарольПользователя = ?(ЗначениеЗаполнено(Пароли.COMПарольПользователя), ЭтотОбъект.УникальныйИдентификатор, "");
		FTPСоединениеПароль = ?(ЗначениеЗаполнено(Пароли.FTPСоединениеПароль), ЭтотОбъект.УникальныйИдентификатор, "");
		WSПароль = ?(ЗначениеЗаполнено(Пароли.WSПароль), ЭтотОбъект.УникальныйИдентификатор, "");
		ПарольАрхиваСообщенияОбмена = ?(ЗначениеЗаполнено(Пароли.ПарольАрхиваСообщенияОбмена), ЭтотОбъект.УникальныйИдентификатор, "");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ВариантРаботыИнформационнойБазыПриИзменении();
	
	АутентификацияОперационнойСистемыПриИзменении();
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	Если ВнешниеРесурсыРазрешены <> Истина Тогда
		
		ОповещениеОЗакрытии = Новый ОписаниеОповещения("РазрешитьВнешнийРесурсЗавершение", ЭтотОбъект, ПараметрыЗаписи);
		Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПрофилиБезопасности") Тогда
			Запросы = СоздатьЗапросНаИспользованиеВнешнихРесурсов(Запись, Истина, Истина, Истина, Истина);
			МодульРаботаВБезопасномРежимеКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("РаботаВБезопасномРежимеКлиент");
			МодульРаботаВБезопасномРежимеКлиент.ПрименитьЗапросыНаИспользованиеВнешнихРесурсов(Запросы, ЭтотОбъект, ОповещениеОЗакрытии);
		Иначе
			ВыполнитьОбработкуОповещения(ОповещениеОЗакрытии, КодВозвратаДиалога.ОК);
		КонецЕсли;
		Отказ = Истина;
		
	КонецЕсли;
	ВнешниеРесурсыРазрешены = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Если ПараметрыЗаписи.Свойство("ЗаписатьИЗакрыть") Тогда
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	УстановитьПривилегированныйРежим(Истина);
	Если COMПарольПользователяИзменен Тогда
		ОбщегоНазначения.ЗаписатьДанныеВБезопасноеХранилище(ТекущийОбъект.Узел, COMПарольПользователя, "COMПарольПользователя")
	КонецЕсли;
	Если FTPСоединениеПарольИзменен Тогда
		ОбщегоНазначения.ЗаписатьДанныеВБезопасноеХранилище(ТекущийОбъект.Узел, FTPСоединениеПароль, "FTPСоединениеПароль")
	КонецЕсли;
	Если WSПарольИзменен Тогда
		ОбщегоНазначения.ЗаписатьДанныеВБезопасноеХранилище(ТекущийОбъект.Узел, WSПароль, "WSПароль")
	КонецЕсли;
	Если ПарольАрхиваСообщенияОбменаИзменен Тогда
		ОбщегоНазначения.ЗаписатьДанныеВБезопасноеХранилище(ТекущийОбъект.Узел, ПарольАрхиваСообщенияОбмена, "ПарольАрхиваСообщенияОбмена")
	КонецЕсли;
	УстановитьПривилегированныйРежим(Ложь);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура FILEКаталогОбменаИнформациейНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ОбменДаннымиКлиент.ОбработчикВыбораФайловогоКаталога(Запись, "FILEКаталогОбменаИнформацией", СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура FILEКаталогОбменаИнформациейОткрытие(Элемент, СтандартнаяОбработка)
	
	ОбменДаннымиКлиент.ОбработчикОткрытияФайлаИлиКаталога(Запись, "FILEКаталогОбменаИнформацией", СтандартнаяОбработка)
	
КонецПроцедуры

&НаКлиенте
Процедура COMКаталогИнформационнойБазыНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ОбменДаннымиКлиент.ОбработчикВыбораФайловогоКаталога(Запись, "COMКаталогИнформационнойБазы", СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура COMКаталогИнформационнойБазыОткрытие(Элемент, СтандартнаяОбработка)

ОбменДаннымиКлиент.ОбработчикОткрытияФайлаИлиКаталога(Запись, "COMКаталогИнформационнойБазы", СтандартнаяОбработка)

КонецПроцедуры

&НаКлиенте
Процедура COMВариантРаботыИнформационнойБазыПриИзменении(Элемент)
	
	ВариантРаботыИнформационнойБазыПриИзменении();
	
КонецПроцедуры

&НаКлиенте
Процедура COMАутентификацияОперационнойСистемыПриИзменении(Элемент)
	
	АутентификацияОперационнойСистемыПриИзменении();
	
КонецПроцедуры

&НаКлиенте
Процедура WSПарольПриИзменении(Элемент)
	WSПарольИзменен = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ПарольАрхиваСообщенияОбмена1ПриИзменении(Элемент)
	ПарольАрхиваСообщенияОбменаИзменен = Истина;
КонецПроцедуры

&НаКлиенте
Процедура FTPСоединениеПарольПриИзменении(Элемент)
	FTPСоединениеПарольИзменен = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ПарольАрхиваСообщенияОбменаПриИзменении(Элемент)
	ПарольАрхиваСообщенияОбменаИзменен = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ПарольАрхиваСообщенияОбмена2ПриИзменении(Элемент)
	ПарольАрхиваСообщенияОбменаИзменен = Истина;
КонецПроцедуры

&НаКлиенте
Процедура COMПарольПользователяПриИзменении(Элемент)
	COMПарольПользователяИзменен = Истина;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПроверитьПодключениеCOM(Команда)
	
	ОповещениеОЗакрытии = Новый ОписаниеОповещения("ПроверитьПодключениеCOMЗавершение", ЭтотОбъект);
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПрофилиБезопасности") Тогда
		Запросы = СоздатьЗапросНаИспользованиеВнешнихРесурсов(Запись, Истина, Ложь, Ложь, Ложь);
		МодульРаботаВБезопасномРежимеКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("РаботаВБезопасномРежимеКлиент");
		МодульРаботаВБезопасномРежимеКлиент.ПрименитьЗапросыНаИспользованиеВнешнихРесурсов(Запросы, ЭтотОбъект, ОповещениеОЗакрытии);
	Иначе
		ВыполнитьОбработкуОповещения(ОповещениеОЗакрытии, КодВозвратаДиалога.ОК);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьПодключениеWS(Команда)
	
	ОповещениеОЗакрытии = Новый ОписаниеОповещения("ПроверитьПодключениеWSЗавершение", ЭтотОбъект);
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПрофилиБезопасности") Тогда
		Запросы = СоздатьЗапросНаИспользованиеВнешнихРесурсов(Запись, Ложь, Ложь, Истина, Ложь);
		МодульРаботаВБезопасномРежимеКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("РаботаВБезопасномРежимеКлиент");
		МодульРаботаВБезопасномРежимеКлиент.ПрименитьЗапросыНаИспользованиеВнешнихРесурсов(Запросы, ЭтотОбъект, ОповещениеОЗакрытии);
	Иначе
		ВыполнитьОбработкуОповещения(ОповещениеОЗакрытии, КодВозвратаДиалога.ОК);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьПодключениеFILE(Команда)
	
	ОповещениеОЗакрытии = Новый ОписаниеОповещения("ПроверитьПодключениеFILEЗавершение", ЭтотОбъект);
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПрофилиБезопасности") Тогда
		Запросы = СоздатьЗапросНаИспользованиеВнешнихРесурсов(Запись, Ложь, Истина, Ложь, Ложь);
		МодульРаботаВБезопасномРежимеКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("РаботаВБезопасномРежимеКлиент");
		МодульРаботаВБезопасномРежимеКлиент.ПрименитьЗапросыНаИспользованиеВнешнихРесурсов(Запросы, ЭтотОбъект, ОповещениеОЗакрытии);
	Иначе
		ВыполнитьОбработкуОповещения(ОповещениеОЗакрытии, КодВозвратаДиалога.ОК);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьПодключениеFTP(Команда)
	
	ОповещениеОЗакрытии = Новый ОписаниеОповещения("ПроверитьПодключениеFTPЗавершение", ЭтотОбъект);
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПрофилиБезопасности") Тогда
		Запросы = СоздатьЗапросНаИспользованиеВнешнихРесурсов(Запись, Ложь, Ложь, Ложь, Истина);
		МодульРаботаВБезопасномРежимеКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("РаботаВБезопасномРежимеКлиент");
		МодульРаботаВБезопасномРежимеКлиент.ПрименитьЗапросыНаИспользованиеВнешнихРесурсов(Запросы, ЭтотОбъект, ОповещениеОЗакрытии);
	Иначе
		ВыполнитьОбработкуОповещения(ОповещениеОЗакрытии, КодВозвратаДиалога.ОК);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьПодключениеEMAIL(Команда)
	
	ПроверитьПодключение("EMAIL");
	
КонецПроцедуры

&НаКлиенте
Процедура ПараметрыДоступаВИнтернет(Команда)
	
	ОбменДаннымиКлиент.ОткрытьФормуПараметровПроксиСервера();
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	
	ПараметрыЗаписи = Новый Структура;
	ПараметрыЗаписи.Вставить("ЗаписатьИЗакрыть");
	Записать(ПараметрыЗаписи);

КонецПроцедуры


#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПроверитьПодключение(ВидТранспортаСтрокой, НовыйПароль = Неопределено)
	
	Отказ = Ложь;
	
	ОчиститьСообщения();
	
	ПроверитьПодключениеНаСервере(Отказ, ВидТранспортаСтрокой, НовыйПароль);
	
	ОповеститьПользователяОРезультатахПодключения(Отказ);
	
КонецПроцедуры

&НаСервере
Процедура ПроверитьПодключениеНаСервере(Отказ, ВидТранспортаСтрокой, НовыйПароль)
	
	ОбменДаннымиСервер.ПроверитьПодключениеОбработкиТранспортаСообщенийОбмена(Отказ, Запись, Перечисления.ВидыТранспортаСообщенийОбмена[ВидТранспортаСтрокой],, НовыйПароль);
	
КонецПроцедуры

&НаСервере
Процедура ВыполнитьПроверкуУстановкиВнешнегоСоединения(Отказ)
	
	ПараметрыСоединения = Новый Структура;
	ПараметрыСоединения.Вставить("COMВариантРаботыИнформационнойБазы", Запись.COMВариантРаботыИнформационнойБазы);
	ПараметрыСоединения.Вставить("COMАутентификацияОперационнойСистемы", Запись.COMАутентификацияОперационнойСистемы);
	ПараметрыСоединения.Вставить("COMИмяИнформационнойБазыНаСервере1СПредприятия",
		Запись.COMИмяИнформационнойБазыНаСервере1СПредприятия);
	ПараметрыСоединения.Вставить("COMИмяПользователя", Запись.COMИмяПользователя);
	ПараметрыСоединения.Вставить("COMИмяСервера1СПредприятия", Запись.COMИмяСервера1СПредприятия);
	ПараметрыСоединения.Вставить("COMКаталогИнформационнойБазы", Запись.COMКаталогИнформационнойБазы);
	
	Если Не COMПарольПользователяИзменен Тогда
		
		УстановитьПривилегированныйРежим(Истина);
		ПараметрыСоединения.Вставить("COMПарольПользователя",
			ОбщегоНазначения.ПрочитатьДанныеИзБезопасногоХранилища(Запись.Узел, "COMПарольПользователя", Истина));
		УстановитьПривилегированныйРежим(Ложь);
		
	Иначе
		
		ПараметрыСоединения.Вставить("COMПарольПользователя", COMПарольПользователя);
		
	КонецЕсли;
	
	ОбменДаннымиВызовСервера.ВыполнитьПроверкуУстановкиВнешнегоСоединения(Отказ, ПараметрыСоединения);
	
КонецПроцедуры

&НаСервере
Процедура ВыполнитьПроверкуУстановкиПодключенияWS(Отказ)
	
	ПараметрыПодключения = ОбменДаннымиСервер.СтруктураПараметровWS();
	ЗаполнитьЗначенияСвойств(ПараметрыПодключения, Запись);
	
	Если Не WSПарольИзменен Тогда
		
		УстановитьПривилегированныйРежим(Истина);
		ПараметрыПодключения.WSПароль = ОбщегоНазначения.ПрочитатьДанныеИзБезопасногоХранилища(Запись.Узел, "WSПароль", Истина);
		УстановитьПривилегированныйРежим(Ложь);
		
	Иначе
		
		ПараметрыПодключения.WSПароль = WSПароль;
		
	КонецЕсли;
	
	СообщениеПользователю = "";
	Если Не ОбменДаннымиСервер.ЕстьПодключениеККорреспонденту(Запись.Узел, ПараметрыПодключения, СообщениеПользователю) Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(СообщениеПользователю,,,, Отказ);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьЭлементовФормы()
	
	ИспользуемыеТранспорты = Новый Массив;
	
	Если ЗначениеЗаполнено(Запись.Узел) Тогда
		
		ИспользуемыеТранспорты = ОбменДаннымиПовтИсп.ИспользуемыеТранспортыСообщенийОбмена(Запись.Узел);
		
	КонецЕсли;
	
	Для Каждого СтраницаВидаТранспорта Из Элементы.СтраницыВидовТранспорта.ПодчиненныеЭлементы Цикл
		
		СтраницаВидаТранспорта.Видимость = Ложь;
		
	КонецЦикла;
	
	Элементы.ВидТранспортаСообщенийОбменаПоУмолчанию.СписокВыбора.Очистить();
	
	Для Каждого Элемент Из ИспользуемыеТранспорты Цикл
		
		ИмяЭлементаФормы = "НастройкиТранспорта[ВидТранспорта]";
		ИмяЭлементаФормы = СтрЗаменить(ИмяЭлементаФормы, "[ВидТранспорта]", ОбщегоНазначения.ИмяЗначенияПеречисления(Элемент));
		
		Элементы[ИмяЭлементаФормы].Видимость = Истина;
		
		Элементы.ВидТранспортаСообщенийОбменаПоУмолчанию.СписокВыбора.Добавить(Элемент, Строка(Элемент));
		
	КонецЦикла;
	
	Если ИспользуемыеТранспорты.Количество() = 1 Тогда
		
		Элементы.СтраницыВидовТранспорта.ОтображениеСтраниц = ОтображениеСтраницФормы.Нет;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОповеститьПользователяОРезультатахПодключения(Знач ОшибкаПодключения)
	
	ТекстПредупреждения = ?(ОшибкаПодключения, НСтр("ru = 'Не удалось установить подключение.'"),
											   НСтр("ru = 'Подключение успешно установлено.'"));
	ПоказатьПредупреждение(, ТекстПредупреждения);
	
КонецПроцедуры

&НаКлиенте
Процедура ВариантРаботыИнформационнойБазыПриИзменении()
	
	ТекущаяСтраница = ?(Запись.COMВариантРаботыИнформационнойБазы = 0, Элементы.СтраницаВариантРаботыФайловый, Элементы.СтраницаВариантРаботыКлиентСерверный);
	
	Элементы.ВариантыРаботыИнформационнойБазы.ТекущаяСтраница = ТекущаяСтраница;
	
КонецПроцедуры

&НаКлиенте
Процедура АутентификацияОперационнойСистемыПриИзменении()
	
	Элементы.COMИмяПользователя.Доступность    = Не Запись.COMАутентификацияОперационнойСистемы;
	Элементы.COMПарольПользователя.Доступность = Не Запись.COMАутентификацияОперационнойСистемы;
	
КонецПроцедуры

&НаКлиенте
Процедура РазрешитьВнешнийРесурсЗавершение(Результат, ПараметрыЗаписи) Экспорт
	
	Если Результат = КодВозвратаДиалога.ОК Тогда
		ВнешниеРесурсыРазрешены = Истина;
		Записать(ПараметрыЗаписи);
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция СоздатьЗапросНаИспользованиеВнешнихРесурсов(Знач Запись, ЗапрашиватьCOM,
	ЗапрашиватьFILE, ЗапрашиватьWS, ЗапрашиватьFTP)
	
	ЗапросыРазрешений = Новый Массив;
	
	ПараметрыЗапроса = РегистрыСведений.НастройкиТранспортаОбмена.ПараметрыЗапросаНаИспользованиеВнешнихРесурсов();
	ПараметрыЗапроса.ЗапрашиватьCOM  = ЗапрашиватьCOM;
	ПараметрыЗапроса.ЗапрашиватьFILE = ЗапрашиватьFILE;
	ПараметрыЗапроса.ЗапрашиватьWS   = ЗапрашиватьWS;
	ПараметрыЗапроса.ЗапрашиватьFTP  = ЗапрашиватьFTP;
	
	РегистрыСведений.НастройкиТранспортаОбмена.ЗапросНаИспользованиеВнешнихРесурсов(ЗапросыРазрешений,
		Запись, ПараметрыЗапроса);
		
	Возврат ЗапросыРазрешений;
	
КонецФункции

&НаКлиенте
Процедура ПроверитьПодключениеFILEЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.ОК Тогда
		
		ПроверитьПодключение("FILE");
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьПодключениеFTPЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.ОК Тогда
		
		ПроверитьПодключение("FTP", ?(FTPСоединениеПарольИзменен, FTPСоединениеПароль, Неопределено));
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьПодключениеWSЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.ОК Тогда
		
		Отказ = Ложь;
		
		ОчиститьСообщения();
		
		ВыполнитьПроверкуУстановкиПодключенияWS(Отказ);
		
		ОповеститьПользователяОРезультатахПодключения(Отказ);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьПодключениеCOMЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.ОК Тогда
		
		Отказ = Ложь;
		
		ОчиститьСообщения();
		
		Если ОбщегоНазначенияКлиент.ИнформационнаяБазаФайловая() Тогда
			
			ОбщегоНазначенияКлиент.ЗарегистрироватьCOMСоединитель(Ложь);
			
		КонецЕсли;
		
		ВыполнитьПроверкуУстановкиВнешнегоСоединения(Отказ);
		
		ОповеститьПользователяОРезультатахПодключения(Отказ);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
