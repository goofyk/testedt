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
	
	Результат.Добавить("КраткоеПредставление");
	Результат.Добавить("Комментарий");
	Результат.Добавить("ВнешняяРоль");
	Результат.Добавить("УзелОбмена");
	
	Возврат Результат
КонецФункции

// Конец СтандартныеПодсистемы.ГрупповоеИзменениеОбъектов

#КонецОбласти

#КонецОбласти

#КонецЕсли

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;
	
	Если ПользователиКлиентСервер.ЭтоСеансВнешнегоПользователя() Тогда
		ТекущийПользователь = ПользователиКлиентСервер.ТекущийВнешнийПользователь();
		ОбъектАвторизации = Справочники[ТекущийПользователь.ОбъектАвторизации.Метаданные().Имя].ПустаяСсылка();
	Иначе
		ОбъектАвторизации = Справочники.Пользователи.ПустаяСсылка();
	КонецЕсли;
	
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 50
	                      |	РолиИсполнителейНазначение.Ссылка КАК Ссылка
	                      |ИЗ
	                      |	Справочник.РолиИсполнителей.Назначение КАК РолиИсполнителейНазначение
	                      |ГДЕ
	                      |	РолиИсполнителейНазначение.ТипПользователей = &Тип
	                      |	И РолиИсполнителейНазначение.Ссылка.Наименование ПОДОБНО &СтрокаПоиска");
	
	Запрос.УстановитьПараметр("Тип", ОбъектАвторизации);
	Запрос.УстановитьПараметр("СтрокаПоиска", "%" + Параметры.СтрокаПоиска + "%");
	РезультатЗапроса = Запрос.Выполнить().Выбрать();
	
	ДанныеВыбора = Новый СписокЗначений;
	Пока РезультатЗапроса.Следующий() Цикл
		ДанныеВыбора.Добавить(РезультатЗапроса.Ссылка, РезультатЗапроса.Ссылка);
	КонецЦикла;

КонецПроцедуры

#КонецОбласти