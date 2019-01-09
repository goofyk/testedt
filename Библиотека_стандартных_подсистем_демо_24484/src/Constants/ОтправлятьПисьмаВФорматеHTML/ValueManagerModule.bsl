#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если Значение Тогда
		Возврат;
	КонецЕсли;
	
	НачатьТранзакцию();
	
	Попытка
		
		Блокировка = Новый БлокировкаДанных;
		ЭлементБлокировки = Блокировка.Добавить("РегистрСведений.НастройкиУчетныхЗаписейЭлектроннойПочты");
		Блокировка.Заблокировать();
		
		// Переключение подписей всех учетных записей в обычный текст.
		НастройкиУчетныхЗаписей = РегистрыСведений.НастройкиУчетныхЗаписейЭлектроннойПочты.СоздатьНаборЗаписей();
		НастройкиУчетныхЗаписей.Прочитать();
		Для каждого Настройка Из НастройкиУчетныхЗаписей Цикл
			Настройка.ФорматПодписиДляНовыхСообщений = Перечисления.СпособыРедактированияЭлектронныхПисем.ОбычныйТекст;
			Настройка.ФорматПодписиПриОтветеПересылке = Перечисления.СпособыРедактированияЭлектронныхПисем.ОбычныйТекст;
		КонецЦикла;
		Если НастройкиУчетныхЗаписей.Модифицированность() Тогда
			НастройкиУчетныхЗаписей.Записать();
		КонецЕсли;
		
		ЗафиксироватьТранзакцию();
		
	Исключение
		
		ОтменитьТранзакцию();
		ВызватьИсключение;
		
	КонецПопытки;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли