#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ОписаниеОповещения = Новый ОписаниеОповещения("НапечататьСписаниеТоваров", ЭтотОбъект);
	УправлениеПечатьюКлиент.ПроверитьПроведенностьДокументов(ОписаниеОповещения, ПараметрКоманды, ПараметрыВыполненияКоманды.Источник);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура НапечататьСписаниеТоваров(СписокДокументов, ДополнительныеПараметры) Экспорт
	
	Если СписокДокументов.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ТекстСообщения = ?(СписокДокументов.Количество() > 1, 
		НСтр("ru = 'Выполняется формирование печатных форм...'"),
		НСтр("ru = 'Выполняется формирование печатной формы...'"));
	Состояние(ТекстСообщения);
	
	ИмяМакета = "СписаниеТоваровMSWord";
	МакетИДанныеОбъекта = УправлениеПечатьюВызовСервера.МакетыИДанныеОбъектовДляПечати("Обработка._ДемоПечатнаяФорма",
		ИмяМакета, СписокДокументов);
	
	_ДемоСтандартныеПодсистемыКлиент.ПечатьСписаниеТоваров(МакетИДанныеОбъекта, ИмяМакета, СписокДокументов);
	
КонецПроцедуры

#КонецОбласти

