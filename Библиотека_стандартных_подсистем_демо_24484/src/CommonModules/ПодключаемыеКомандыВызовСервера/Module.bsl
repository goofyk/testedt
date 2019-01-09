#Область СлужебныеПроцедурыИФункции

// Возвращает описание команды по имени элемента формы.
Функция ОписаниеКоманды(ИмяКомандыВФорме, АдресНастроек) Экспорт
	Возврат ПодключаемыеКоманды.ОписаниеКоманды(ИмяКомандыВФорме, АдресНастроек);
КонецФункции

// Проводит анализ массива документов на предмет проведенности и наличия прав на их проведение.
Функция ИнформацияОДокументах(МассивСсылок) Экспорт
	Результат = Новый Структура;
	Результат.Вставить("Непроведенные", ОбщегоНазначения.ПроверитьПроведенностьДокументов(МассивСсылок));
	Результат.Вставить("ДоступноПравоПроведения", СтандартныеПодсистемыСервер.ДоступноПравоПроведения(Результат.Непроведенные));
	Возврат Результат;
КонецФункции

#КонецОбласти
