#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОтправитьПриглашениеДляАнкетирования(Ссылка, ПараметрыВыполнения) Экспорт
	
	ФоновоеЗадание = СформироватьИОтправитьПисьмо(Ссылка);
	НастройкиОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
	НастройкиОжидания.ВыводитьОкноОжидания = Истина;
	Обработчик = Новый ОписаниеОповещения("ПослеОтправкиПриглашения", ЭтотОбъект);
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ФоновоеЗадание, Обработчик, НастройкиОжидания);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеОтправкиПриглашения(ФоновоеЗадание, ДополнительныеПараметры) Экспорт
	
	Если ФоновоеЗадание.Статус = "Выполнено" Тогда
		Результат = ПолучитьИзВременногоХранилища(ФоновоеЗадание.АдресРезультата);
		Если Результат.Успешно Тогда
			ПоказатьОповещениеПользователя(НСтр("ru='Приглашение успешно отправлено.'"));
			Возврат;
		Иначе
			ОписаниеОшибки = Результат.ОписаниеОшибки;
		КонецЕсли;
	Иначе
		ОписаниеОшибки = ФоновоеЗадание.КраткоеПредставлениеОшибки;
	КонецЕсли;
	ШаблонОписанияОшибки = НСтр("ru = 'Не удалось отправить приглашение по причине:
	|%1'");
	ОписаниеОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонОписанияОшибки, ОписаниеОшибки);
	ПоказатьПредупреждение(, ОписаниеОшибки);
	
КонецПроцедуры

&НаСервере
Функция СформироватьИОтправитьПисьмо(Ссылка)
	
	ПараметрыВызоваСервера = Новый Структура();
	ПараметрыВызоваСервера.Вставить("Ссылка", Ссылка);
	
	ПараметрыВыполненияВФоне = ДлительныеОперации.ПараметрыВыполненияВФоне(ЭтотОбъект.УникальныйИдентификатор);
	ПараметрыВыполненияВФоне.НаименованиеФоновогоЗадания = НСтр("ru = 'Создание и отправка приглашения для проведения опроса.'");
	
	ФоновоеЗадание = ДлительныеОперации.ВыполнитьВФоне("Обработки._ДемоОтправкаПриглашенияДляАнкетирования.СформироватьИОтправитьПисьмо",
		ПараметрыВызоваСервера, ПараметрыВыполненияВФоне);
	
	Возврат ФоновоеЗадание;
	
КонецФункции

#КонецОбласти
