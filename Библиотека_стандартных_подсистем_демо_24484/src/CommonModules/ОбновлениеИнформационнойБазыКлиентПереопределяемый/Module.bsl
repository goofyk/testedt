#Область ПрограммныйИнтерфейс

// Вызывается при нажатии на гиперссылку или двойном щелчке на ячейке 
// табличного документа с описанием изменений системы (общий макет ОписаниеИзмененийСистемы).
//
// Параметры:
//   Область - ОбластьЯчеекТабличногоДокумента - область документа, на 
//             которой произошло нажатие.
//
Процедура ПриНажатииНаГиперссылкуВДокументеОписанияОбновлений(Знач Область) Экспорт
	
	// _Демо начало примера
	Если Область.Имя = "_ДемоПримерГиперссылки" Тогда
		ПоказатьПредупреждение(,НСтр("ru = 'Нажата гиперссылка.'"));
	КонецЕсли;
	
	Если Область.Имя = "_АктуализироватьАдресныйКлассификатор" Тогда
		ОткрытьФорму("РегистрСведений.АдресныеОбъекты.Форма.АктуализацияУстаревшегоКлассификатора");
	КонецЕсли;
	// _Демо конец примера

КонецПроцедуры

// Вызывается в обработчике ПередНачаломРаботыСистемы, проверяет возможность
// обновления на текущую версию программы.
//
// Параметры:
//  ВерсияДанных - Строка - версия данных основной конфигурации, с которой выполняется обновление
//                          (из регистра сведений ВерсииПодсистем).
//
Процедура ПриОпределенииВозможностиОбновления(Знач ВерсияДанных) Экспорт
	
	// _Демо начало примера
	ДопустимаяВерсия = "2.1.0";
	
	ВерсияДанныхБезНомераСборки = ОбщегоНазначенияКлиентСервер.ВерсияКонфигурацииБезНомераСборки(ВерсияДанных);
	Результат = ОбщегоНазначенияКлиентСервер.СравнитьВерсииБезНомераСборки(ВерсияДанныхБезНомераСборки, ДопустимаяВерсия);
	Если ВерсияДанных <> "0.0.0.0" И Результат < 0 Тогда
		Сообщение = НСтр("ru = 'Обновление на текущую версию допустимо только с версии %1 и выше.
			|(Недопустимая попытка обновления с версии %2)
			|Необходимо восстановить информационную базу из резервной копии
			|и повторить обновление согласно файлу 1cv8upd.htm'");
		Сообщение = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Сообщение, ДопустимаяВерсия, ВерсияДанных);
		ВызватьИсключение Сообщение;
	КонецЕсли;
	// _Демо конец примера
	
КонецПроцедуры

#КонецОбласти
