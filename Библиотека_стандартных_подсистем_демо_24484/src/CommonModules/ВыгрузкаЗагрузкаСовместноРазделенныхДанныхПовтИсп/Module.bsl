////////////////////////////////////////////////////////////////////////////////
// Подсистема "Выгрузка загрузка данных".
//
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

// Возвращает объекты метаданных, разделенные разделителями с типом разделения
//  данных "Независимо и совместно".
//
// Возвращаемое значение: ФиксированнаяСтруктура:
//                         * Ключ - Строка, имя разделителя,
//                         * Значение - ФиксированнаяСтруктура:
//                            * Константы - Массив(Строка) - массив полных имен констант, разделенных разделителем,
//                            * Объекты - Массив(Строка) - массив полных имен объектов, разделенных разделителем,
//                            * НаборыЗаписей - Массив(Строка) - массив полных имен наборов записей, разделенных разделителем.
//
Функция СовместноРазделенныеОбъектыМетаданных() Экспорт
	
	Кэш = Новый Структура();
	
	Разделители = РазделителиСТипомРазделенияНезависимоИСовместно();
	
	Для Каждого Разделитель Из Разделители Цикл
		
		СтруктураРазделенныхОбъектов = Новый Структура("Константы,Объекты,НаборыЗаписей", Новый Массив(), Новый Массив(), Новый Массив());
		
		АвтоИспользование = (Разделитель.АвтоИспользование = Метаданные.СвойстваОбъектов.АвтоИспользованиеОбщегоРеквизита.Использовать);
		
		Для Каждого ЭлементСостава Из Разделитель.Состав Цикл
			
			Если ЭлементСостава.Использование = Метаданные.СвойстваОбъектов.ИспользованиеОбщегоРеквизита.Использовать
					ИЛИ (АвтоИспользование И ЭлементСостава.Использование = Метаданные.СвойстваОбъектов.ИспользованиеОбщегоРеквизита.Авто) Тогда
				
				Если ОбщегоНазначенияБТС.ЭтоКонстанта(ЭлементСостава.Метаданные) Тогда
					СтруктураРазделенныхОбъектов.Константы.Добавить(ЭлементСостава.Метаданные.ПолноеИмя());
				ИначеЕсли ОбщегоНазначенияБТС.ЭтоСсылочныеДанные(ЭлементСостава.Метаданные) Тогда
					СтруктураРазделенныхОбъектов.Объекты.Добавить(ЭлементСостава.Метаданные.ПолноеИмя());
				ИначеЕсли ОбщегоНазначенияБТС.ЭтоНаборЗаписей(ЭлементСостава.Метаданные) Тогда
					СтруктураРазделенныхОбъектов.НаборыЗаписей.Добавить(ЭлементСостава.Метаданные.ПолноеИмя());
				КонецЕсли;
				
			КонецЕсли;
			
			Кэш.Вставить(Разделитель.Имя, Новый ФиксированнаяСтруктура(СтруктураРазделенныхОбъектов));
			
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат Новый ФиксированнаяСтруктура(Кэш);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция РазделителиСТипомРазделенияНезависимоИСовместно()
	
	Результат = Новый Массив();
	
	Для Каждого ОбщийРеквизит Из Метаданные.ОбщиеРеквизиты Цикл
		
		Если ОбщийРеквизит.РазделениеДанных = Метаданные.СвойстваОбъектов.РазделениеДанныхОбщегоРеквизита.Разделять
				И ОбщийРеквизит.ИспользованиеРазделяемыхДанных = Метаданные.СвойстваОбъектов.ИспользованиеРазделяемыхДанныхОбщегоРеквизита.НезависимоИСовместно Тогда
			
			Результат.Добавить(ОбщийРеквизит);
			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти