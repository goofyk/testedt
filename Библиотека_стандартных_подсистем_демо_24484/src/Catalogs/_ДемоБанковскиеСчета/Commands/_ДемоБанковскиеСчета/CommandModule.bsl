#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	Отбор = Новый Структура("Владелец", ПараметрКоманды);
	ПараметрыФормы = Новый Структура("Отбор, РежимОткрытияИзФормы", Отбор, Истина);
	ОткрытьФорму("Справочник._ДемоБанковскиеСчета.ФормаСписка", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно);
КонецПроцедуры

#КонецОбласти
