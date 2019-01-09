#Область ОписаниеПеременных

&НаКлиенте
Перем ПараметрыАдминистрирования, ИмяСобытияЖурнала;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ОбновлениеКонфигурации.ЕстьПраваНаУстановкуОбновления() Тогда
		ВызватьИсключение НСтр("ru = 'Недостаточно прав для обновления конфигурации. Обратитесь к администратору.'");
	ИначеЕсли ПользователиКлиентСервер.ЭтоСеансВнешнегоПользователя() Тогда
		ВызватьИсключение НСтр("ru = 'Данная операция не доступна внешнему пользователю системы.'");
	КонецЕсли;
	
	Если Не ОбщегоНазначенияКлиентСервер.ЭтоWindowsКлиент() Тогда
		Возврат; // Отказ устанавливается в ПриОткрытии().
	КонецЕсли;
	
	СтандартныеПодсистемыСервер.УстановитьОтображениеЗаголовковГрупп(ЭтотОбъект);
	
	ЭтоФайловаяБаза = ОбщегоНазначения.ИнформационнаяБазаФайловая();
	
	// Если это первый запуск после обновления конфигурации, то запоминаем и сбрасываем статус.
	Объект.РезультатОбновления = ОбновлениеКонфигурации.ОбновлениеКонфигурацииУспешно(КаталогСкрипта);
	Если Объект.РезультатОбновления <> Неопределено Тогда
		ОбновлениеКонфигурации.СброситьСтатусОбновленияКонфигурации();
	КонецЕсли;
	
	Если Не ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаСПочтовымиСообщениями") Тогда
		Элементы.ПанельПочта.Видимость = Ложь;
	КонецЕсли;
	
	Элементы.ПанельИнформацииОбОшибках.Видимость = ВидимостьПанелиОшибок();
	
	// Проверяем каждый раз при открытии помощника.
	КонфигурацияИзменена = КонфигурацияИзменена();
	НуженФайлОбновления = Не КонфигурацияИзменена;
	
	Если Параметры.ЗавершениеРаботыСистемы Тогда
		Элементы.ПереключательОбновленияФайл.Видимость = Ложь;
		Элементы.ПереключательОбновленияСервер.Видимость = Ложь;
		Элементы.ПолеДатаВремяОбновления.Видимость = Ложь;
		Элементы.НадписьНажмитеДалее.Видимость = Истина;
	КонецЕсли;
	
	Если Параметры.ПолученоОбновлениеКонфигурации Тогда
		Элементы.СтраницыСпособОбновленияФайл.ТекущаяСтраница = Элементы.СтраницаПолученоОбновлениеИзПриложенияФайл;
	КонецЕсли;
	
	Элементы.НадписьОбновлениеКонфигурацииВыполняетсяПриОбменеДаннымиСГлавнымУзлом.Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		Элементы.НадписьОбновлениеКонфигурацииВыполняетсяПриОбменеДаннымиСГлавнымУзлом.Заголовок, ПланыОбмена.ГлавныйУзел());
	
	УстановитьПривилегированныйРежим(Истина);
	
	ВосстановитьНастройкиОбновленияКонфигурации();
	
	Если ЭтоФайловаяБаза И Объект.РежимОбновления > 1 Или Параметры.ЗавершениеРаботыСистемы Тогда
		Объект.РежимОбновления = 0;
	КонецЕсли;
	
	Элементы.ПоискИУстановкаОбновлений.Видимость = ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.ПолучениеОбновленийПрограммы");
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ИмяСобытияЖурнала = ОбновлениеКонфигурацииКлиент.СобытиеЖурналаРегистрации();
	
	Если Не ВозможенЗапускОбновления() Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	Если Параметры.ВыполнитьОбновление Тогда
		ПерейтиКВыборуРежимаОбновления();
		Возврат;
	КонецЕсли;
	
	Страницы    = Элементы.СтраницыПомощника.ПодчиненныеЭлементы;
	ИмяСтраницы = Страницы.ФайлОбновления.Имя;
	
	Если Объект.КодЗадачиПланировщика <> 0 И Не ОбновлениеКонфигурацииКлиент.СуществуетЗадачаПланировщика(Объект.КодЗадачиПланировщика) Тогда
		Объект.КодЗадачиПланировщика = 0;
	КонецЕсли;
	
	Если Не СтандартныеПодсистемыКлиент.ПараметрыРаботыКлиента().ЭтоГлавныйУзел Тогда
		Если КонфигурацияИзменена Тогда
			ПерейтиКВыборуРежимаОбновления();
			Возврат;
		Иначе
			ИмяСтраницы = Страницы.ОбновленияНеОбнаружено.Имя;
		КонецЕсли;
	КонецЕсли;
	
	ПередОткрытиемСтраницы(Страницы[ИмяСтраницы]);
	Элементы.СтраницыПомощника.ТекущаяСтраница = Страницы[ИмяСтраницы];
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	Если ВРег(ИсточникВыбора.ИмяФормы) = ВРег("Обработка.АктивныеПользователи.Форма.АктивныеПользователи") Тогда
		ОбновитьИнформациюОНаличииСоединений();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ЛегальностьПолученияОбновлений" И Не Параметр Тогда
		
		ОтработатьНажатиеКнопкиНазад();
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;
	
	ОбновлениеКонфигурацииКлиент.ЗаписатьСобытияВЖурналРегистрации();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

////////////////////////////////////////////////////////////////////////////////
// Страница ФайлОбновления

&НаКлиенте
Процедура ПереключательНуженФайлОбновленияПриИзменении(Элемент)
	ПередОткрытиемСтраницы();
КонецПроцедуры

&НаКлиенте
Процедура ПолеФайлОбновленияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	Диалог.Каталог = ПолучитьКаталогФайла(Элементы.ПолеФайлОбновления.ТекстРедактирования);
	Диалог.ПроверятьСуществованиеФайла = Истина;
	Диалог.Фильтр = НСтр("ru = 'Все файлы поставки (*.cf*;*.cfu)|*.cf*;*.cfu|Файлы поставки конфигурации (*.cf)|*.cf|Файлы поставки обновления конфигурации(*.cfu)|*.cfu'");
	Диалог.Заголовок = НСтр("ru = 'Выбор поставки обновления конфигурации'");
	
	Если Диалог.Выбрать() Тогда
		Объект.ИмяФайлаОбновления = Диалог.ПолноеИмяФайла;
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Страница ВыборРежимаОбновленияФайл

&НаКлиенте
Процедура НадписьСписокДействийНажатие(Элемент)
	ПоказатьАктивныхПользователей();
КонецПроцедуры

&НаКлиенте
Процедура НадписьСписокДействий1Нажатие(Элемент)
	ПоказатьАктивныхПользователей();
КонецПроцедуры

&НаКлиенте
Процедура НадписьСписокДействий3Нажатие(Элемент)
	ПоказатьАктивныхПользователей();
КонецПроцедуры

&НаКлиенте
Процедура НадписьРезервнаяКопияНажатие(Элемент)
	
	ПараметрыРезервногоКопирования = Новый Структура;
	ПараметрыРезервногоКопирования.Вставить("СоздаватьРезервнуюКопию",           Объект.СоздаватьРезервнуюКопию);
	ПараметрыРезервногоКопирования.Вставить("ИмяКаталогаРезервнойКопииИБ",       Объект.ИмяКаталогаРезервнойКопииИБ);
	ПараметрыРезервногоКопирования.Вставить("ВосстанавливатьИнформационнуюБазу", Объект.ВосстанавливатьИнформационнуюБазу);
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПослеЗакрытияФормыРезервногоКопирования", ЭтотОбъект);
	ОбновлениеКонфигурацииКлиент.ПоказатьРезервноеКопирование(ПараметрыРезервногоКопирования, ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗакрытияФормыРезервногоКопирования(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат <> Неопределено Тогда
		ЗаполнитьЗначенияСвойств(Объект, Результат);
		Элементы.НадписьРезервнаяКопияФайл.Заголовок = ОбновлениеКонфигурацииКлиент.ЗаголовокСозданияРезервнойКопии(Результат);
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Страница ВыборРежимаОбновленияСервер

&НаКлиенте
Процедура ПереключательОбновленияПриИзменении(Элемент)
	ПередОткрытиемСтраницы();
КонецПроцедуры

&НаКлиенте
Процедура ВыслатьОтчетНаПочтуПриИзменении(Элемент)
	ПередОткрытиемСтраницы();
КонецПроцедуры

&НаКлиенте
Процедура НадписьОтложенныеОбработчикиОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОбновлениеИнформационнойБазыКлиент.ПоказатьОтложенныеОбработчики();
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Страница НеуспешноеОбновление

&НаКлиенте
Процедура НадписьОткрытьЖурналРегистрацииНажатие(Элемент)
	
	СписокПриложений = Новый Массив;
	СписокПриложений.Добавить("COMConnection");
	СписокПриложений.Добавить("Designer");
	СписокПриложений.Добавить("1CV8");
	СписокПриложений.Добавить("1CV8C");
	
	ОтборЖурналаРегистрации = Новый Структура;
	ОтборЖурналаРегистрации.Вставить("Пользователь", ИмяПользователя());
	ОтборЖурналаРегистрации.Вставить("ИмяПриложения", СписокПриложений);
	
	ОткрытьФорму("Обработка.ЖурналРегистрации.Форма", ОтборЖурналаРегистрации);
	
КонецПроцедуры

&НаКлиенте
Процедура НадписьВыявленныеПроблемыОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.КонтрольВеденияУчета") Тогда
		МодульКонтрольВеденияУчетаКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("КонтрольВеденияУчетаКлиент");
		МодульКонтрольВеденияУчетаКлиент.ОткрытьОтчетПоПроблемамИзОбработкиОбновления(ЭтотОбъект, СтандартнаяОбработка);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ВидимостьПанелиОшибок()
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.КонтрольВеденияУчета") Тогда
		МодульКонтрольВеденияУчета       = ОбщегоНазначения.ОбщийМодуль("КонтрольВеденияУчета");
		СводнаяИнформацияПоВидамПроверки = МодульКонтрольВеденияУчета.СводнаяИнформацияПоВидамПроверки("СистемныеПроверки");
		Возврат СводнаяИнформацияПоВидамПроверки.Количество > 0;
	Иначе
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КнопкаНазадНажатие(Команда)
	ОтработатьНажатиеКнопкиНазад();
КонецПроцедуры

&НаКлиенте
Процедура КнопкаДалееНажатие(Команда)
	ОбработатьНажатиеКнопкиДалее();
КонецПроцедуры

&НаКлиенте
Процедура ПоискИУстановкаОбновлений(Команда)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.ПолучениеОбновленийПрограммы") Тогда
		Закрыть();
		МодульПолучениеОбновленийПрограммыКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ПолучениеОбновленийПрограммыКлиент");
		МодульПолучениеОбновленийПрограммыКлиент.ОбновитьПрограмму();
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПередОткрытиемСтраницы(НоваяТекущаяСтраница = Неопределено)
	
	ИмяПараметра = "СтандартныеПодсистемы.СообщенияДляЖурналаРегистрации";
	Если ПараметрыПриложения[ИмяПараметра] = Неопределено Тогда
		ПараметрыПриложения.Вставить(ИмяПараметра, Новый СписокЗначений);
	КонецЕсли;
	
	Страницы = Элементы.СтраницыПомощника.ПодчиненныеЭлементы;
	Если НоваяТекущаяСтраница = Неопределено Тогда
		НоваяТекущаяСтраница = Элементы.СтраницыПомощника.ТекущаяСтраница;
	КонецЕсли;
	
	ДоступностьКнопкиНазад = Истина;
	ДоступностьКнопкиДалее = Истина;
	ДоступностьКнопкиЗакрыть = Истина;
	ФункцияКнопкиДалее = Истина; // Истина = "Далее", Ложь = "Готово"
	ФункцияКнопкиЗакрыть = Истина; // Истина = "Отмена", Ложь = "Закрыть"
	
	Элементы.КнопкаДалее.Отображение = ОтображениеКнопки.Текст;
	
	Если НоваяТекущаяСтраница = Страницы.ОбновленияНеОбнаружено Тогда
		
		ФункцияКнопкиДалее = Ложь;
		ФункцияКнопкиЗакрыть = Ложь;
		ДоступностьКнопкиДалее = Ложь;
		Элементы.НадписьОписаниеТекущейКонфигурации.Заголовок = СтандартныеПодсистемыКлиент.ПараметрыРаботыКлиента().СинонимКонфигурации;
		Элементы.НадписьВерсияТекущейКонфигурации.Заголовок = СтандартныеПодсистемыКлиент.ПараметрыРаботыКлиента().ВерсияКонфигурации;
		
		Если Не СтандартныеПодсистемыКлиент.ПараметрыРаботыКлиента().ЭтоГлавныйУзел Тогда
			ДоступностьКнопкиНазад = Ложь;
		КонецЕсли;
		
	ИначеЕсли НоваяТекущаяСтраница = Страницы.ВыборРежимаОбновленияФайл Тогда
		
		ФункцияКнопкиДалее = (Объект.РежимОбновления = 0);// Если Не обновляем сейчас, то "готово".
		
		ОбновитьИнформациюОНаличииСоединений(Страницы.ВыборРежимаОбновленияФайл);
		
		Если Объект.СоздаватьРезервнуюКопию = 2 Тогда
			Объект.ВосстанавливатьИнформационнуюБазу = Истина;
		ИначеЕсли Объект.СоздаватьРезервнуюКопию = 0 Тогда
			Объект.ВосстанавливатьИнформационнуюБазу = Ложь;
		КонецЕсли;
		
		Элементы.НадписьРезервнаяКопияФайл.Заголовок = ОбновлениеКонфигурацииКлиент.ЗаголовокСозданияРезервнойКопии(Объект);
		
		Если Не СтандартныеПодсистемыКлиент.ПараметрыРаботыКлиента().ЭтоГлавныйУзел Тогда
			ДоступностьКнопкиНазад = Ложь;
		КонецЕсли;
	ИначеЕсли НоваяТекущаяСтраница = Страницы.ВыборРежимаОбновленияСервер Тогда
		
		Если Объект.КодЗадачиПланировщика = 0 И Не ДатаВремяОбновленияУстановлена Тогда
			Объект.ДатаВремяОбновления = ВернутьДату(НачалоДня(ОбщегоНазначенияКлиент.ДатаСеанса()) + 24*60*60, Объект.ДатаВремяОбновления);
			ДатаВремяОбновленияУстановлена = Истина;
		КонецЕсли;
		
		ФункцияКнопкиДалее = (Объект.РежимОбновления = 0);// Если не обновляем сейчас, то "готово".
		Объект.ВосстанавливатьИнформационнуюБазу = Ложь;
		
		СтраницыПанелиИнформацииПерезагрузки = Элементы.СтраницыИнформацииПерезагрузки.ПодчиненныеЭлементы;
		Элементы.СтраницыИнформацииПерезагрузки.ТекущаяСтраница = ?(Объект.РежимОбновления = 0,
			СтраницыПанелиИнформацииПерезагрузки.СтраницаПерезагрузкиСейчас,
			СтраницыПанелиИнформацииПерезагрузки.СтраницаЗапланированнойПерезагрузки);
		
		ОбновитьИнформациюОНаличииСоединений(Страницы.ВыборРежимаОбновленияСервер);
		
		Элементы.ПолеДатаВремяОбновления.Доступность = (Объект.РежимОбновления = 2);
		Элементы.АдресЭлектроннойПочты.Доступность	= Объект.ВыслатьОтчетНаПочту;
		
		Если Не СтандартныеПодсистемыКлиент.ПараметрыРаботыКлиента().ЭтоГлавныйУзел Тогда
			ДоступностьКнопкиНазад = Ложь;
		КонецЕсли;
		
		Если Объект.РежимОбновления = 2 Тогда 
			Элементы.КнопкаДалее.Отображение = ОтображениеКнопки.КартинкаИТекст;
		КонецЕсли;
		
	ИначеЕсли НоваяТекущаяСтраница = Страницы.НеуспешноеОбновление Тогда
		
		ФункцияКнопкиДалее = Ложь;
		ДоступностьКнопкиЗакрыть = Ложь;
		
	ИначеЕсли НоваяТекущаяСтраница = Страницы.ФайлОбновления Тогда
		
		ДоступностьКнопкиНазад = Ложь;
		
		Если НуженФайлОбновления = 0 Тогда
			Если КонфигурацияИзменена Тогда
				Элементы.СтраницыНадписиИзмененнойКонфигурации.ТекущаяСтраница = Элементы.СтраницыНадписиИзмененнойКонфигурации.ПодчиненныеЭлементы.ЕстьИзменения;
			Иначе
				Элементы.СтраницыНадписиИзмененнойКонфигурации.ТекущаяСтраница = Элементы.СтраницыНадписиИзмененнойКонфигурации.ПодчиненныеЭлементы.НетИзменений;
				ДоступностьКнопкиДалее = Ложь;
			КонецЕсли;
		КонецЕсли;
		Элементы.ПанельОбновлениеИзОсновнойКонфигурации.Видимость = НуженФайлОбновления = 0;
		Элементы.ПолеФайлОбновления.Доступность                   = НуженФайлОбновления = 1;
		Элементы.ПолеФайлОбновления.АвтоОтметкаНезаполненного     = НуженФайлОбновления = 1;
		
	КонецЕсли;
	
	ОбновлениеКонфигурацииКлиент.ЗаписатьСобытияВЖурналРегистрации();
	
	КнопкаДалее = Элементы.КнопкаДалее;
	КнопкаЗакрыть = Элементы.КнопкаЗакрыть;
	Элементы.КнопкаНазад.Доступность = ДоступностьКнопкиНазад;
	КнопкаДалее.Доступность   = ДоступностьКнопкиДалее;
	КнопкаЗакрыть.Доступность = ДоступностьКнопкиЗакрыть;
	Если ДоступностьКнопкиДалее Тогда
		Если Не КнопкаДалее.КнопкаПоУмолчанию Тогда
			КнопкаДалее.КнопкаПоУмолчанию = Истина;
		КонецЕсли;
	ИначеЕсли ДоступностьКнопкиЗакрыть Тогда
		Если Не КнопкаЗакрыть.КнопкаПоУмолчанию Тогда
			КнопкаЗакрыть.КнопкаПоУмолчанию = Истина;
		КонецЕсли;
	КонецЕсли;
	
	КнопкаДалее.Заголовок = ?(ФункцияКнопкиДалее, НСтр("ru = 'Далее >'"), НСтр("ru = 'Готово'"));
	КнопкаЗакрыть.Заголовок = ?(ФункцияКнопкиЗакрыть, НСтр("ru = 'Отмена'"), НСтр("ru = 'Закрыть'"));
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИнформациюОНаличииСоединений(ТекущаяСтраница = Неопределено)
	
	Если ТекущаяСтраница = Неопределено Тогда
		ТекущаяСтраница = Элементы.СтраницыПомощника.ТекущаяСтраница;
	КонецЕсли;
	
	ИмяПараметра = "СтандартныеПодсистемы.СообщенияДляЖурналаРегистрации";
	Если ТекущаяСтраница = Элементы.ВыборРежимаОбновленияФайл Тогда
		
		СоединенияИнфо = СоединенияИБВызовСервера.ИнформацияОСоединениях(Ложь, ПараметрыПриложения[ИмяПараметра]);
		Элементы.ГруппаСоединений.Видимость = СоединенияИнфо.НаличиеАктивныхСоединений;
		
		Если СоединенияИнфо.НаличиеАктивныхСоединений Тогда
			ВсеСтраницы = Элементы.ПанельАктивныеПользователи.ПодчиненныеЭлементы;
			ДоступностьКнопкиДалее = Истина;
			Если СоединенияИнфо.НаличиеCOMСоединений Тогда
				Элементы.ПанельАктивныеПользователи.ТекущаяСтраница = ВсеСтраницы.АктивныеСоединения;
			ИначеЕсли СоединенияИнфо.НаличиеСоединенияКонфигуратором Тогда
				Элементы.ПанельАктивныеПользователи.ТекущаяСтраница = ВсеСтраницы.СоединениеКонфигуратора;
			Иначе
				Элементы.ПанельАктивныеПользователи.ТекущаяСтраница = ВсеСтраницы.АктивныеПользователи;
			КонецЕсли;
		КонецЕсли;
		
	ИначеЕсли ТекущаяСтраница = Элементы.ВыборРежимаОбновленияСервер Тогда
		
		ПараметрыСтраницы = ПараметрыСтраницыВыборРежимаОбновленияСервер(ПараметрыПриложения[ИмяПараметра]);
		Элементы.НадписьОтложенныеОбработчики.Видимость = ПараметрыСтраницы.ЕстьОтложенныеОбработчики;
		
		СоединенияИнфо = ПараметрыСтраницы.ИнформацияОСоединениях;
		НаличиеСоединений = СоединенияИнфо.НаличиеАктивныхСоединений И Объект.РежимОбновления = 0;
		Элементы.ГруппаСоединений1.Видимость = НаличиеСоединений;
		Если НаличиеСоединений Тогда
			ВсеСтраницы = Элементы.ПанельАктивныеПользователи1.ПодчиненныеЭлементы;
			Элементы.ПанельАктивныеПользователи1.ТекущаяСтраница = ? (СоединенияИнфо.НаличиеCOMСоединений, 
				ВсеСтраницы.АктивныеСоединения1, ВсеСтраницы.АктивныеПользователи1);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьОбновление()
	
	ПараметрыОбновления = Новый Структура;
	ПараметрыОбновления.Вставить("РежимОбновления");
	ПараметрыОбновления.Вставить("ДатаВремяОбновления");
	ПараметрыОбновления.Вставить("ВыслатьОтчетНаПочту");
	ПараметрыОбновления.Вставить("АдресЭлектроннойПочты");
	ПараметрыОбновления.Вставить("КодЗадачиПланировщика");
	ПараметрыОбновления.Вставить("ИмяФайлаОбновления");
	ПараметрыОбновления.Вставить("СоздаватьРезервнуюКопию");
	ПараметрыОбновления.Вставить("ИмяКаталогаРезервнойКопииИБ");
	ПараметрыОбновления.Вставить("ВосстанавливатьИнформационнуюБазу");
	
	ЗаполнитьЗначенияСвойств(ПараметрыОбновления, Объект);
	ПараметрыОбновления.Вставить("ЗавершениеРаботыСистемы", Параметры.ЗавершениеРаботыСистемы);
	ПараметрыОбновления.Вставить("НуженФайлОбновления", Булево(НуженФайлОбновления));
	
	ОбновлениеКонфигурацииКлиент.УстановитьОбновление(ЭтотОбъект, ПараметрыОбновления, ПараметрыАдминистрирования);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьНажатиеКнопкиДалее()
	
	ОчиститьСообщения();
	ТекущаяСтраница = Элементы.СтраницыПомощника.ТекущаяСтраница;
	Страницы = Элементы.СтраницыПомощника.ПодчиненныеЭлементы;
	
	Если ТекущаяСтраница = Страницы.ФайлОбновления Тогда
		ПерейтиСоСтраницыФайлаОбновления();
	ИначеЕсли ТекущаяСтраница = Страницы.ВыборРежимаОбновленияФайл
		Или ТекущаяСтраница = Страницы.ВыборРежимаОбновленияСервер Тогда
		УстановитьОбновление();
	Иначе
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОтработатьНажатиеКнопкиНазад()
	
	Страницы = Элементы.СтраницыПомощника.ПодчиненныеЭлементы;
	ТекущаяСтраница = Элементы.СтраницыПомощника.ТекущаяСтраница;
	НоваяТекущаяСтраница = ТекущаяСтраница;
	
	Если ТекущаяСтраница = Страницы.ВыборРежимаОбновленияФайл
		Или ТекущаяСтраница = Страницы.ВыборРежимаОбновленияСервер
		Или ТекущаяСтраница = Страницы.НеуспешноеОбновление Тогда
		НоваяТекущаяСтраница = Страницы.ФайлОбновления;
	КонецЕсли;
	
	ПередОткрытиемСтраницы(НоваяТекущаяСтраница);
	Элементы.СтраницыПомощника.ТекущаяСтраница = НоваяТекущаяСтраница;
	
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиСоСтраницыФайлаОбновления()
	
	Обработчик = Новый ОписаниеОповещения("ПослеПодтвержденияБезопасности", ЭтотОбъект);
	ПараметрыФормы = Новый Структура("Ключ", "ПередВыборомФайлаОбновления");
	ОткрытьФорму("ОбщаяФорма.ПредупреждениеБезопасности", ПараметрыФормы, , , , , Обработчик);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеПодтвержденияБезопасности(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = "Продолжить" Тогда
		
		Если НуженФайлОбновления = 1 Тогда
			Если Не ЗначениеЗаполнено(Объект.ИмяФайлаОбновления) Тогда
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Укажите файл поставки обновления конфигурации.'"),,"Объект.ИмяФайлаОбновления");
				ТекущийЭлемент = Элементы.ПолеФайлОбновления;
				Возврат;
			КонецЕсли;
			Файл = Новый Файл(Объект.ИмяФайлаОбновления);
			Если Не Файл.Существует() Или Не Файл.ЭтоФайл() Тогда
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Файл поставки обновления конфигурации не найден.'"),,"Объект.ИмяФайлаОбновления");
				ТекущийЭлемент = Элементы.ПолеФайлОбновления;
				Возврат;
			КонецЕсли;
		КонецЕсли;
		
		ПриПроверкеЛегальностиПолученияОбновления();
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиКВыборуРежимаОбновления(ЭтоПереходДалее = Ложь)
	
	Если ПараметрыАдминистрирования = Неопределено Тогда
		
		ОписаниеОповещения = Новый ОписаниеОповещения("ПослеПолученияПараметровАдминистрирования", ЭтотОбъект, ЭтоПереходДалее);
		ЗаголовокФормы = НСтр("ru = 'Установка обновления'");
		Если ЭтоФайловаяБаза Тогда
			ПоясняющаяНадпись = НСтр("ru = 'Для установки обновления необходимо ввести
				|параметры администрирования информационной базы'");
			ЗапрашиватьПараметрыАдминистрированияКластера = Ложь;
		Иначе
			ПоясняющаяНадпись = НСтр("ru = 'Для установки обновления необходимо ввести параметры
				|администрирования кластера серверов и информационной базы'");
			ЗапрашиватьПараметрыАдминистрированияКластера = Истина;
		КонецЕсли;
		
		СоединенияИБКлиент.ПоказатьПараметрыАдминистрирования(ОписаниеОповещения, Истина, ЗапрашиватьПараметрыАдминистрированияКластера,
			ПараметрыАдминистрирования, ЗаголовокФормы, ПоясняющаяНадпись);
		
	Иначе
		
		ПослеПолученияПараметровАдминистрирования(ПараметрыАдминистрирования, ЭтоПереходДалее);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриПроверкеЛегальностиПолученияОбновления()
	
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПроверкаЛегальностиПолученияОбновления") Тогда
		Оповещение = Новый ОписаниеОповещения("ПриПроверкеЛегальностиПолученияОбновленияЗавершение", ЭтотОбъект);
		МодульПроверкаЛегальностиПолученияОбновленияКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ПроверкаЛегальностиПолученияОбновленияКлиент");
		МодульПроверкаЛегальностиПолученияОбновленияКлиент.ПоказатьПроверкуЛегальностиПолученияОбновления(Оповещение);
	Иначе
		ПриПроверкеЛегальностиПолученияОбновленияЗавершение(Истина, Неопределено);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриПроверкеЛегальностиПолученияОбновленияЗавершение(ОбновлениеПолученоЛегально, ДополнительныеПараметры) Экспорт
	
	Если ОбновлениеПолученоЛегально = Истина Тогда
		ПерейтиКВыборуРежимаОбновления(Истина);
	Иначе
		ОтработатьНажатиеКнопкиНазад();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеПолученияПараметровАдминистрирования(Результат, ЭтоПереходДалее) Экспорт
	
	Если ЭтоПереходДалее Тогда
		Элементы.СтраницыПомощника.ТекущаяСтраница.Доступность = Истина;
	КонецЕсли;
	
	Если Результат <> Неопределено Тогда
		
		ПараметрыАдминистрирования = Результат;
		Страницы = Элементы.СтраницыПомощника.ПодчиненныеЭлементы;
		НоваяТекущаяСтраница = ?(ЭтоФайловаяБаза, Страницы.ВыборРежимаОбновленияФайл, Страницы.ВыборРежимаОбновленияСервер);
		УстановитьПарольАдминистратора(ПараметрыАдминистрирования);
		
		ПередОткрытиемСтраницы(НоваяТекущаяСтраница);
		Элементы.СтраницыПомощника.ТекущаяСтраница = НоваяТекущаяСтраница;
		
	Иначе
		
		ТекстПредупреждения = НСтр("ru = 'Для установки обновления необходимо ввести параметры администрирования.'");
		ПоказатьПредупреждение(, ТекстПредупреждения);
		
		ТекстСообщения = НСтр("ru = 'Не удалось установить обновление программы, т.к. не были введены
			|корректные параметры администрирования информационной базы.'");
		ЖурналРегистрацииКлиент.ДобавитьСообщениеДляЖурналаРегистрации(ИмяСобытияЖурнала, "Ошибка", ТекстСообщения);
		
		НоваяТекущаяСтраница = Элементы.НеуспешноеОбновление;
		ПередОткрытиемСтраницы(НоваяТекущаяСтраница);
		Элементы.СтраницыПомощника.ТекущаяСтраница = НоваяТекущаяСтраница;
		
	КонецЕсли;
	
	ОбновлениеКонфигурацииКлиент.ЗаписатьСобытияВЖурналРегистрации();
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьАктивныхПользователей()
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ОповещатьОЗакрытии", Истина);
	СтандартныеПодсистемыКлиент.ОткрытьСписокАктивныхПользователей(ПараметрыФормы, ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Функция ВернутьДату(Дата, Время)
	Возврат Дата(Год(Дата), Месяц(Дата), День(Дата), Час(Время), Минута(Время), Секунда(Время));
КонецФункции	

&НаКлиенте
Функция ВозможенЗапускОбновления()
	
	ВозможенЗапускОбновления = Истина;
	
	#Если ВебКлиент Тогда
		ВозможенЗапускОбновления = Ложь;
		ТекстСообщения = НСтр("ru = 'Обновление программы недоступно в веб-клиенте.'");
	#КонецЕсли
	
	Если Не ОбщегоНазначенияКлиентСервер.ЭтоWindowsКлиент() Тогда
		ВозможенЗапускОбновления = Ложь;
		ТекстСообщения = НСтр("ru = 'Обновление программы доступно только в клиенте под управлением ОС Windows.'");
	КонецЕсли;
	
	Если ОбщегоНазначенияКлиент.КлиентПодключенЧерезВебСервер() Тогда
		ВозможенЗапускОбновления = Ложь;
		ТекстСообщения = НСтр("ru = 'Обновление программы недоступно при подключении через веб-сервер.'");
	КонецЕсли;
	
	Если Не ВозможенЗапускОбновления Тогда
		ПоказатьПредупреждение(, ТекстСообщения);
	КонецЕсли;
		
	Возврат ВозможенЗапускОбновления;
	
КонецФункции

&НаСервере
Функция ПараметрыСтраницыВыборРежимаОбновленияСервер(СообщенияДляЖурналаРегистрации)
	
	ПараметрыСтраницы = Новый Структура;
	ПараметрыСтраницы.Вставить("ЕстьОтложенныеОбработчики", (ОбновлениеИнформационнойБазыСлужебный.СтатусНевыполненныхОбработчиков() = "СтатусНеВыполнено"));
	ПараметрыСтраницы.Вставить("ИнформацияОСоединениях", СоединенияИБ.ИнформацияОСоединениях(Ложь, СообщенияДляЖурналаРегистрации));
	Возврат ПараметрыСтраницы;
	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// Планирование обновления в указанное время.

&НаКлиенте
// Возвратить каталог файла - часть пути без имени файла.
//
// Параметры:
//  ПутьКФайлу  - Строка - путь к файлу.
//
// Возвращаемое значение:
//   Строка   - каталог файла
Функция ПолучитьКаталогФайла(Знач ПутьКФайлу)
	
	ПозицияСимвола = СтрНайти(ПутьКФайлу, "\", НаправлениеПоиска.СКонца);
	Если ПозицияСимвола > 1 Тогда
		Возврат Сред(ПутьКФайлу, 1, ПозицияСимвола - 1); 
	Иначе
		Возврат "";
	КонецЕсли;
	
КонецФункции

&НаСервере
Процедура ВосстановитьНастройкиОбновленияКонфигурации()
	
	Настройки = ОбновлениеКонфигурации.НастройкиОбновленияКонфигурации();
	ЗаполнитьЗначенияСвойств(Объект, Настройки);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьПарольАдминистратора(ПараметрыАдминистрирования)
	
	АдминистраторИБ = ПользователиИнформационнойБазы.НайтиПоИмени(ПараметрыАдминистрирования.ИмяАдминистратораИнформационнойБазы);
	
	Если Не АдминистраторИБ.АутентификацияСтандартная Тогда
		
		АдминистраторИБ.АутентификацияСтандартная = Истина;
		АдминистраторИБ.Пароль = ПараметрыАдминистрирования.ПарольАдминистратораИнформационнойБазы;
		АдминистраторИБ.Записать();
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти