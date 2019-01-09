#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ЛокальныеПеременные

Перем ТекущаяИнициализация;
Перем ТекущийКонтейнер;
Перем ТекущиеОбработчики;
Перем ТекущиеСловариЗамен;
Перем ТекущийВес;

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Процедура Инициализировать(Контейнер, Обработчики) Экспорт
	
	Если ТекущаяИнициализация Тогда
		
		ВызватьИсключение НСтр("ru = 'Объект уже был инициализирован ранее!'");
		
	Иначе
		
		ТекущийКонтейнер = Контейнер;
		ТекущиеОбработчики = Обработчики;
		ТекущиеСловариЗамен = Новый Соответствие();
		ТекущийВес = 0;
		
		//
		
		ТекущаяИнициализация = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ЗаменитьСсылку(Знач ИмяТипаXML, Знач СтарыйИдентификатор, Знач НовыйИдентификатор) Экспорт
	
	Если ТекущиеСловариЗамен.Получить(ИмяТипаXML) = Неопределено Тогда
		ТекущиеСловариЗамен.Вставить(ИмяТипаXML, Новый Соответствие());
		ТекущийВес = ТекущийВес + 1;
	КонецЕсли;
	
	ТекущиеСловариЗамен.Получить(ИмяТипаXML).Вставить(СтарыйИдентификатор, НовыйИдентификатор);
	ТекущийВес = ТекущийВес + 1;
	
	Если ТекущийВес >= КоличествоЭлементовВСоответствииСсылок() Тогда
		
		ВыполнитьЗаменуСсылок();
		ТекущиеСловариЗамен = Новый Соответствие();
		ТекущийВес = 0;
		
	КонецЕсли;
	
КонецПроцедуры

// Заменяет ссылки в файле.
//
// Параметры:
//  ОписаниеФайла - СтрокаТаблицыЗначений - см. переменную "Состав" модуля объекта обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера.
//
Процедура ВыполнитьЗаменуСсылокВФайле(Знач ОписаниеФайла) Экспорт
	
	Если ТекущийВес = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ПотокЧтения = Новый ЧтениеТекста(ОписаниеФайла.ПолноеИмя);
	
	ВременныйФайл = ПолучитьИмяВременногоФайла("xml");
	
	ПотокЗаписи = Новый ЗаписьТекста(ВременныйФайл);
	
	// Константы для разбора текста
	НачалоТипа = "xsi:type=""" + ПрефиксТипаСсылок() + ":";
	ДлинаНачалаТипа = СтрДлина(НачалоТипа);
	КонецТипа = """>";
	ДлинаКонцаТипа = СтрДлина(КонецТипа);
	
	ИсходнаяСтрока = ПотокЧтения.ПрочитатьСтроку();
	Пока ИсходнаяСтрока <> Неопределено Цикл
		
		ОстатокСтроки = Неопределено;
		
		ТекущаяПозиция = 1;
		ПозицияТипа = СтрНайти(ИсходнаяСтрока, НачалоТипа);
		Пока ПозицияТипа > 0 Цикл
			
			ПотокЗаписи.Записать(Сред(ИсходнаяСтрока, ТекущаяПозиция, ПозицияТипа - 1 + ДлинаНачалаТипа));
			
			ОстатокСтроки = Сред(ИсходнаяСтрока, ТекущаяПозиция + ПозицияТипа + ДлинаНачалаТипа - 1);
			ТекущаяПозиция = ТекущаяПозиция + ПозицияТипа + ДлинаНачалаТипа - 1;
			
			ПозицияКонцаТипа = СтрНайти(ОстатокСтроки, КонецТипа);
			Если ПозицияКонцаТипа = 0 Тогда
				Прервать;
			КонецЕсли;
			
			ИмяТипа = Лев(ОстатокСтроки, ПозицияКонцаТипа - 1);
			СоответствиеЗамены = ТекущиеСловариЗамен.Получить(ИмяТипа);
			Если СоответствиеЗамены = Неопределено Тогда
				ПозицияТипа = СтрНайти(ОстатокСтроки, НачалоТипа);
				Продолжить;
			КонецЕсли;
			
			ПотокЗаписи.Записать(ИмяТипа);
			ПотокЗаписи.Записать(КонецТипа);
			
			ИсходнаяСсылкаXML = Сред(ОстатокСтроки, ПозицияКонцаТипа + ДлинаКонцаТипа, 36);
			
			НайденнаяСсылкаXML = СоответствиеЗамены.Получить(ИсходнаяСсылкаXML);
			
			Если НайденнаяСсылкаXML = Неопределено Тогда
				ПотокЗаписи.Записать(ИсходнаяСсылкаXML);
			Иначе
				ПотокЗаписи.Записать(НайденнаяСсылкаXML);
			КонецЕсли;
			
			ТекущаяПозиция = ТекущаяПозиция + ПозицияКонцаТипа - 1 + ДлинаКонцаТипа + 36;
			ОстатокСтроки = Сред(ОстатокСтроки, ПозицияКонцаТипа + ДлинаКонцаТипа + 36);
			ПозицияТипа = СтрНайти(ОстатокСтроки, НачалоТипа);
			
		КонецЦикла;
		
		Если ОстатокСтроки <> Неопределено Тогда
			ПотокЗаписи.ЗаписатьСтроку(ОстатокСтроки);
		Иначе
			ПотокЗаписи.ЗаписатьСтроку(ИсходнаяСтрока);
		КонецЕсли;
		
		ИсходнаяСтрока = ПотокЧтения.ПрочитатьСтроку();
		
	КонецЦикла;
	
	ПотокЧтения.Закрыть();
	ПотокЗаписи.Закрыть();
	
	ТекущийКонтейнер.ЗаменитьФайл(ОписаниеФайла.Имя, ВременныйФайл);
	
КонецПроцедуры

Процедура Закрыть() Экспорт
	
	ВыполнитьЗаменуСсылок();
	ТекущийКонтейнер = Неопределено;
	ТекущиеСловариЗамен = Новый Соответствие();
	ТекущийВес = 0;
	ТекущаяИнициализация = Ложь;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Возвращает количество элементов в соответствии,
// в котором хранится соответствие ссылок. Число определялось экспериментально, чтобы объем занимаемой оперативной памяти не превышал 10 Мб.
//
// Возвращаемое значение:
//	Число - количество элементов.
//
Функция КоличествоЭлементовВСоответствииСсылок()
	
	Возврат 51000;
	
КонецФункции

// Выполняет ряд действий по замене ссылок.
//
// Параметры:
//	Контейнер - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер
//		контейнера, используемый в процессе выгрузи данных. Подробнее см. комментарий
//		к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера.
//	СловарьЗаменыСсылок - Соответствие - см. параметр "СловарьЗамен" в процедуре "ОбновитьСловарьСопоставленияСсылок".
//
Процедура ВыполнитьЗаменуСсылок()
	
	ТипыФайлов = ВыгрузкаЗагрузкаДанныхСлужебный.ТипыФайловПоддерживающиеЗаменуСсылок();
	
	ОписанияФайлов = ТекущийКонтейнер.ПолучитьОписанияФайловИзКаталога(ТипыФайлов);
	Для Каждого ОписаниеФайла Из ОписанияФайлов Цикл
		
		ВыполнитьЗаменуСсылокВФайле(ОписаниеФайла);
		
	КонецЦикла;
	
	ТекущиеОбработчики.ПриЗаменеСсылок(ТекущийКонтейнер, ТекущиеСловариЗамен);
	
КонецПроцедуры

Функция ПрефиксТипаСсылок()
	
	ПрефиксыПространствИмен = ВыгрузкаЗагрузкаДанныхСлужебный.ПрефиксыПространствИмен();
	Возврат ПрефиксыПространствИмен.Получить("http://v8.1c.ru/8.1/data/enterprise/current-config");
	
КонецФункции

#КонецОбласти

#Область Инициализация

ТекущаяИнициализация = Ложь;

#КонецОбласти

#КонецЕсли