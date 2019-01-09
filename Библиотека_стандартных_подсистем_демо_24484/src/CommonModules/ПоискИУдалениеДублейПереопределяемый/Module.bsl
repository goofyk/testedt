#Область ПрограммныйИнтерфейс

// Определить объекты, в модулях менеджеров которых предусмотрена возможность параметризации 
// алгоритма поиска дублей с помощью экспортных процедур ПараметрыПоискаДублей, ПриПоискеДублей 
// и ВозможностьЗаменыЭлементов.
//
// Параметры:
//   Объекты - Соответствие - объекты, в модулях менеджеров которых размещены экспортные процедуры.
//       ** Ключ     - Строка - полное имя объекта метаданных, подключенного к подсистеме "Поиск и удаление дублей".
//                              Например, "Справочник.Контрагенты".
//       ** Значение - Строка - имена экспортных процедур, определенных в модуле менеджера.
//                              Могут быть указаны:
//                              "ПараметрыПоискаДублей",
//                              "ПриПоискеДублей",
//                              "ВозможностьЗаменыЭлементов".
//                              Каждое имя должно начинаться с новой строки.
//                              Если указана пустая строка, то в модуле менеджера определены все процедуры.
//
// Пример:
//  1. В справочнике определены все процедуры:
//  Объекты.Вставить(Метаданные.Справочники.Контрагенты.ПолноеИмя(), "");
//
//  2. Определены только процедуры ПараметрыПоискаДублей и ПриПоискеДублей:
//  Объекты.Вставить(Метаданные.Справочники.ЗадачиПроекта.ПолноеИмя(), "ПараметрыПоискаДублей
//                   |ПриПоискеДублей");
//
Процедура ПриОпределенииОбъектовСПоискомДублей(Объекты) Экспорт
	
	// _Демо начало примера
	Объекты.Вставить(Метаданные.Справочники._ДемоНоменклатура.ПолноеИмя(), "");
	// _Демо конец примера
	
КонецПроцедуры

#КонецОбласти
