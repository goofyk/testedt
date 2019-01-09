#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗагрузитьДанные(Команда)
	
	НачатьЗагрузкуЖурналаНаСервер(Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура СформироватьОтчет(Команда)
	
	Если НЕ ЭтоАдресВременногоХранилища(Отчет.АдресДанных) Тогда
		НачатьЗагрузкуЖурналаНаСервер(Истина);
		Возврат;
	КонецЕсли;
	
	СформироватьОтчетНаСервере();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура СформироватьОтчетНаСервере()
	
	Результат.Очистить();
	
	ИнформацияРасшифровки = Неопределено;
	РеквизитФормыВЗначение("Отчет").СкомпоноватьРезультат(Результат, ИнформацияРасшифровки);
	ДанныеРасшифровки = ПоместитьВоВременноеХранилище(ИнформацияРасшифровки, УникальныйИдентификатор);
	Элементы.Результат.ОтображениеСостояния.Видимость = Ложь;
	Элементы.Результат.ОтображениеСостояния.ДополнительныйРежимОтображения = ДополнительныйРежимОтображения.НеИспользовать;
	
КонецПроцедуры

&НаКлиенте
Функция НачатьЗагрузкуЖурналаНаСервер(Знач СформироватьПослеЗагрузки)
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ОбработатьРезультатПомещенияФайла", 
		ЭтотОбъект, СформироватьПослеЗагрузки);
	НачатьПомещениеФайла(ОписаниеОповещения, , "eventlog.xml", Истина, УникальныйИдентификатор); 
	
КонецФункции

&НаКлиенте
Процедура ОбработатьРезультатПомещенияФайла(ВыборВыполнен, Адрес, ВыбранноеИмяФайла, ДополнительныеПараметры) Экспорт
	
	Если Не ВыборВыполнен Тогда
		Возврат;
	КонецЕсли;
	
	Отчет.АдресДанных = Адрес;
	Если ДополнительныеПараметры Тогда
		СформироватьОтчетНаСервере();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти