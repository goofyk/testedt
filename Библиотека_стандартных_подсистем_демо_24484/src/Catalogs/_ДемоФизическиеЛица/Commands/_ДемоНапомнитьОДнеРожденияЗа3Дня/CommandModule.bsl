#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	ТекстНапоминания = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'День рождения сотрудника: %1'"), Строка(ПараметрКоманды));
	НапоминанияПользователяКлиент.НапомнитьОЕжегодномСобытииПредмета(
		ТекстНапоминания,
		60*60*24*3,
		ПараметрКоманды,
		"ДатаРождения");
		
	ПоказатьОповещениеПользователя(НСтр("ru = 'Создано напоминание:'"), , ТекстНапоминания, БиблиотекаКартинок.Информация32);
КонецПроцедуры

#КонецОбласти

