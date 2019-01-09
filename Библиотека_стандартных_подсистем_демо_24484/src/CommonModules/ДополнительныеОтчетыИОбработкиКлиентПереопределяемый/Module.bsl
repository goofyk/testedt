#Область ПрограммныйИнтерфейс

// Выполняет дополнительные действия перед формированием печатной формы.
//
// Параметры:
//  ПечатаемыеОбъекты    - Массив - ссылки на объекты, для которых выполняется команда печати;
//  СтандартнаяОбработка - Булево - признак необходимости проверки проведенности печатаемых документов,
//                                  если установить в Ложь, то проверка выполняться не будет.
//
Процедура ПередВыполнениемКомандыПечатиВнешнейПечатнойФормы(ПечатаемыеОбъекты, СтандартнаяОбработка) Экспорт
	// _Демо начало примера
	Если ТипЗнч(ПечатаемыеОбъекты[0]) = Тип("ДокументСсылка._ДемоСчетНаОплатуПокупателю") Тогда
		СтандартнаяОбработка = Ложь;
	КонецЕсли;
	// _Демо конец примера
КонецПроцедуры

#КонецОбласти
