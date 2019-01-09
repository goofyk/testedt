////////////////////////////////////////////////////////////////////////////////
// Подсистема "Электронная подпись в модели сервиса".
//  
////////////////////////////////////////////////////////////////////////////////


#Область ПрограммныйИнтерфейс

Функция ИспользованиеВозможно() Экспорт
	
	Возврат ПолучитьФункциональнуюОпцию("ИспользоватьЭлектроннуюПодписьВМоделиСервиса");
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Вызывается при установке параметров сеанса.
//
// Параметры:
//  ИменаПараметровСеанса - Массив, Неопределено.
//
Процедура ПриУстановкеПараметровСеанса(ИменаПараметровСеанса) Экспорт
	
	Если ИменаПараметровСеанса <> Неопределено 
		И ИменаПараметровСеанса.Найти("МаркерыБезопасности") <> Неопределено Тогда
		ПараметрыСеанса.МаркерыБезопасности = Новый ФиксированноеСоответствие(Новый Соответствие);		
	КонецЕсли;
	
КонецПроцедуры	

////////////////////////////////////////////////////////////////////////////////
// Обработчики событий подсистем конфигурации.

// См. РаботаВМоделиСервисаПереопределяемый.ПриЗаполненииТаблицыПараметровИБ.
Процедура ПриЗаполненииТаблицыПараметровИБ(Знач ТаблицаПараметров) Экспорт
		
	РаботаВМоделиСервиса.ДобавитьКонстантуВТаблицуПараметровИБ(ТаблицаПараметров, "ИспользоватьЭлектроннуюПодписьВМоделиСервиса");
	РаботаВМоделиСервиса.ДобавитьКонстантуВТаблицуПараметровИБ(ТаблицаПараметров, "АдресСервисаПодключенияЭлектроннойПодписиВМоделиСервиса");
	РаботаВМоделиСервиса.ДобавитьКонстантуВТаблицуПараметровИБ(ТаблицаПараметров, "АдресКриптосервиса");	
	
	СтрокаПараметра = ТаблицаПараметров.Добавить();
	СтрокаПараметра.Имя = "ИмяПользователяСервисаПодключенияЭлектроннойПодписиВМоделиСервиса";
	СтрокаПараметра.Описание = "ИмяПользователяСервисаПодключенияЭлектроннойПодписиВМоделиСервиса";
	СтрокаПараметра.Тип = Новый ОписаниеТипов("Строка");
	
	СтрокаПараметра = ТаблицаПараметров.Добавить();
	СтрокаПараметра.Имя = "ПарольПользователяСервисаПодключенияЭлектроннойПодписиВМоделиСервиса";
	СтрокаПараметра.Описание = "ПарольПользователяСервисаПодключенияЭлектроннойПодписиВМоделиСервиса";
	СтрокаПараметра.Тип = Новый ОписаниеТипов("Строка");
	
КонецПроцедуры

// См. РаботаВМоделиСервисаПереопределяемый.ПриУстановкеЗначенийПараметровИБ.
Процедура ПриУстановкеЗначенийПараметровИБ(Знач ЗначенияПараметров) Экспорт
	
	Владелец = ТехнологияСервисаИнтеграцияСБСП.ИдентификаторОбъектаМетаданных("Константа.АдресСервисаПодключенияЭлектроннойПодписиВМоделиСервиса");
	Если ЗначенияПараметров.Свойство("ИмяПользователяСервисаПодключенияЭлектроннойПодписиВМоделиСервиса") Тогда
		УстановитьПривилегированныйРежим(Истина);
		ТехнологияСервисаИнтеграцияСБСП.ЗаписатьДанныеВБезопасноеХранилище(Владелец, ЗначенияПараметров.ИмяПользователяСервисаПодключенияЭлектроннойПодписиВМоделиСервиса, "Логин");
		УстановитьПривилегированныйРежим(Ложь);
		ЗначенияПараметров.Удалить("ИмяПользователяСервисаПодключенияЭлектроннойПодписиВМоделиСервиса");
	КонецЕсли;
	
	Если ЗначенияПараметров.Свойство("ПарольПользователяСервисаПодключенияЭлектроннойПодписиВМоделиСервиса") Тогда
		УстановитьПривилегированныйРежим(Истина);
		ТехнологияСервисаИнтеграцияСБСП.ЗаписатьДанныеВБезопасноеХранилище(Владелец, ЗначенияПараметров.ПарольПользователяСервисаПодключенияЭлектроннойПодписиВМоделиСервиса, "Пароль");
		УстановитьПривилегированныйРежим(Ложь);
		ЗначенияПараметров.Удалить("ПарольПользователяСервисаПодключенияЭлектроннойПодписиВМоделиСервиса");
	КонецЕсли;
	
КонецПроцедуры

// См. ОбщегоНазначенияПереопределяемый.ПриОпределенииПоддерживаемыхВерсийПрограммныхИнтерфейсов.
Процедура ПриОпределенииПоддерживаемыхВерсийПрограммныхИнтерфейсов(СтруктураПоддерживаемыхВерсий) Экспорт
	
	МассивВерсий = Новый Массив;
	МассивВерсий.Добавить("1.0.1.1");
	СтруктураПоддерживаемыхВерсий.Вставить("ЭлектроннаяПодписьВМоделиСервиса", МассивВерсий);	
	
КонецПроцедуры

// См. ОбщегоНазначенияПереопределяемый.ПараметрыРаботыКлиента.
Процедура ПриДобавленииПараметровРаботыКлиента(Параметры) Экспорт
	
	Параметры.Вставить("ИспользованиеЭлектроннойПодписиВМоделиСервисаВозможно", ИспользованиеВозможно());
	
КонецПроцедуры

#КонецОбласти
