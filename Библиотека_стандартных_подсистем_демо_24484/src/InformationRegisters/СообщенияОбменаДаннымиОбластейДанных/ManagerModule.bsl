#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

Процедура ДобавитьЗапись(СтруктураЗаписи) Экспорт
	
	ОбменДаннымиСервер.ДобавитьЗаписьВРегистрСведений(СтруктураЗаписи, "СообщенияОбменаДаннымиОбластейДанных");
	
КонецПроцедуры

Процедура УдалитьЗапись(СтруктураЗаписи) Экспорт
	
	ОбменДаннымиСервер.УдалитьНаборЗаписейВРегистреСведений(СтруктураЗаписи, "СообщенияОбменаДаннымиОбластейДанных");
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли