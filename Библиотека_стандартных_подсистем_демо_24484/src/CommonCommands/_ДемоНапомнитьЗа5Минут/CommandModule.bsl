#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	НапоминанияПользователяКлиент.НапомнитьДоВремениПредмета(
		Строка(ПараметрКоманды),
		5*60,
		ПараметрКоманды,
		"СрокИсполнения");
		
	ПоказатьОповещениеПользователя(НСтр("ru = 'Создано напоминание:'"), , Строка(ПараметрКоманды), БиблиотекаКартинок.Информация32);
КонецПроцедуры

#КонецОбласти

