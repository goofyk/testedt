#Область ПрограммныйИнтерфейс

#Область УстаревшиеПроцедурыИФункции

// Устарела. Следует использовать ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды.
//
// Обновляет список команд печати в зависимости от текущего контекста.
//
// Параметры:
//  Форма - УправляемаяФорма - форма, для которой требуется обновление команд печати.
//  Источник - ДанныеФормыСтруктура, ТаблицаФормы - контекст для проверки условий (Форма.Объект или Форма.Элементы.Список).
//
Процедура ОбновитьКоманды(Форма, Источник) Экспорт
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(Форма, Источник);
КонецПроцедуры

#КонецОбласти

#КонецОбласти