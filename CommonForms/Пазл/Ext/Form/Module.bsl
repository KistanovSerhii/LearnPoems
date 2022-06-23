﻿&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	НаполнитьФормуКомандамиИзСтрокиПоИндексу(0);
	
КонецПроцедуры

&НаКлиенте
Процедура Проверить(Команда)
	
	СловаСоответствуютПорядку = ПроверитьСловаСоответствуютПорядку();
	
	Если СловаСоответствуютПорядку = Неопределено Тогда
		текстОшибкиПоискаСловаВВыходныхДанных = ОбщийОписаниеОшибокНаКлиенте.текстОшибкиПроверкиСловаСоответствуютПорядку();
		Сообщить(текстОшибкиПоискаСловаВВыходныхДанных);
		Возврат;	
	КонецЕсли;
	
	Если НЕ СловаСоответствуютПорядку Тогда	
		текстОшибкиПроверкаПорядкаСловНеПройдена = ОбщийОписаниеОшибокНаКлиенте.текстОшибкиПроверкаПорядкаСловНеПройдена();
		ОчиститьСообщения();
		Сообщить(текстОшибкиПроверкаПорядкаСловНеПройдена);
		Возврат;
	КонецЕсли;
	
	ОчиститьСообщения();
	ТекстПоздравления = НСтр("ru = 'Отлично!'; en = 'Great!'");
	Сообщить(ТекстПоздравления); // Строка собрана верно!

	ПеренестиСтрокуВВыходныеДанныеСервер(ЭтотОбъект.ТекущийИндексСтроки);
	
	ИндексСтроки 					= ЭтотОбъект.ТекущийИндексСтроки + 1;	 
	ЭтотОбъект.ТекущийИндексСтроки  = ИндексСтроки;
	
	ОчиститьКомандыГруппаПроверкиНаСервере();
	НаполнитьФормуКомандамиИзСтрокиПоИндексу(ИндексСтроки);
	ЗавершитьСборкуПазлаЕслиЭтоПоследняяСтрокаНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ПеренестиСтрокуВВыходныеДанныеСервер(ТекущийИндексСтроки)
	
	ТЧ = ЭтаФорма.Параметры.Ссылка.Тело;
	Если ТЧ.Количество() <= ТекущийИндексСтроки Тогда	
		Возврат;	
	КонецЕсли;
	
	ТекстТекСтроки = ТЧ[ТекущийИндексСтроки].СтрокаДанных;
	ЭтаФорма.ВыходныеДанные = ЭтаФорма.ВыходныеДанные + ТекстТекСтроки + Символы.ПС;

КонецПроцедуры

&НаСервере
Функция ПолучитьТекстПодсказкиТекущейСтрокиСервер(ТекущийИндексСтроки)
	
	ТЧ = ЭтаФорма.Параметры.Ссылка.Тело;
	Если ТЧ.Количество() <= ТекущийИндексСтроки Тогда	
		Возврат Неопределено;	
	КонецЕсли;
	
	ТекстТекСтроки = ТЧ[ТекущийИндексСтроки].СтрокаДанных;
	Возврат ТекстТекСтроки;

КонецФункции


// Функция - Получить описание слова
// ВНИМАНИЕ - возврат НЕОПРЕДЕЛЕНО Если не корректно составленно имя команды!
//
// Параметры:
//  Команда	 - КомандаФормы - Строка где разделитель "_", Индек:
//	0 - Строка - ИмяКоманды
//	1 - Число  - Индекс строки произведения
//	2 - Число  - Индекс слова в строке
//	3 - Строка - Слово
// 
// Возвращаемое значение:
//  ОписаниеСлова - Структура:
//	ИмяКоманды 		- Строка
//	ИндексСтроки 	- Число
//	ИндексСлова 	- Число
//	Слово 			- Строка	
//
&НаКлиенте
Функция ПолучитьОписаниеСлова(Команда)

	ОписанияСлова = Новый Структура;
	ОписанияСлова.Вставить("ИмяКоманды");
	ОписанияСлова.Вставить("ИндексСтроки");
	ОписанияСлова.Вставить("ИндексСлова");
	ОписанияСлова.Вставить("Слово");
	
    мИзЗаголовкаКоманды = СтрРазделить(Команда.Имя, "_");
	Если мИзЗаголовкаКоманды.Количество() <> 4 Тогда	
		Возврат Неопределено;	
	КонецЕсли;	
	
	ОписанияСлова.ИмяКоманды 	= мИзЗаголовкаКоманды[0];
	ОписанияСлова.ИндексСтроки	= Число(мИзЗаголовкаКоманды[1]);
	ОписанияСлова.ИндексСлова   = Число(мИзЗаголовкаКоманды[2]);
	ОписанияСлова.Слово			= мИзЗаголовкаКоманды[3];
	
	Возврат ОписанияСлова;

КонецФункции // Полу()

&НаКлиенте
Процедура СловоВыбрано(Команда)
	
	ОписанияСлова = ПолучитьОписаниеСлова(Команда);
	
	Если ОписанияСлова = Неопределено Тогда
		текстОшибкиРасшифровкиСлова = ОбщийОписаниеОшибокНаКлиенте.текстОшибкиРасшифровкиСлова();
		Сообщить(текстОшибкиРасшифровкиСлова);
		Возврат;
	КонецЕсли;
		
	ЭлементСлово = ЭтаФорма.Элементы[Команда.Имя];	
	
	Если ЭлементСлово.Родитель = ЭтаФорма.Элементы.ГруппаСлова Тогда
		ПрисвоитьКомандеРодителя(ЭлементСлово.Имя, ЭтаФорма.Элементы.ГруппаПроверки.Имя);
		ЭтаФорма.Элементы.ФормаПроверить.Доступность = ЭтаФорма.Элементы.ГруппаПроверки.ПодчиненныеЭлементы.Количество() <> 0;
	Иначе
		ПрисвоитьКомандеРодителя(ЭлементСлово.Имя, ЭтаФорма.Элементы.ГруппаСлова.Имя);
		ЭтаФорма.Элементы.ФормаПроверить.Доступность = ЭтаФорма.Элементы.ГруппаПроверки.ПодчиненныеЭлементы.Количество() <> 0;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция ПроверитьСловаСоответствуютПорядку()
	
	РезультатПроверки = Ложь;
	
	Если ЭтаФорма.Элементы.ГруппаПроверки.ПодчиненныеЭлементы.Количество() = 0 Тогда	
		Возврат РезультатПроверки;
	КонецЕсли;
	
	мКомандыГруппыПроверка = ЭтаФорма.Элементы.ГруппаПроверки.ПодчиненныеЭлементы;
	
	мСлов = Новый Массив;
	Для каждого эКоманда Из мКомандыГруппыПроверка Цикл	
		ОписаниеПерваяКомандаГруппы = ПолучитьОписаниеСлова(эКоманда);
		
		ОписаниеДанных = Новый Структура;		
		ОписаниеДанных.Вставить("Слово", 		ОписаниеПерваяКомандаГруппы.Слово);
		ОписаниеДанных.Вставить("ИндексСтроки", ОписаниеПерваяКомандаГруппы.ИндексСтроки);
		ОписаниеДанных.Вставить("ИндексСлова", 	ОписаниеПерваяКомандаГруппы.ИндексСлова);
		
		мСлов.Добавить(ОписаниеДанных);	
	КонецЦикла;
	
	РезультатПроверки = ПроверитьСловаВСтрокеСоответствуютПорядкуНаСервере(мСлов);
	// РезультатПроверки = ПроверитьПервыеСловаСтрокСоответствуютПорядкуНаСервере(мСлов);
		
	Возврат РезультатПроверки;

КонецФункции // ПроверитьСловаСоответствуютПорядку()

&НаСервере
Процедура ОчиститьКомандыГруппаПроверкиНаСервере()
	
	Пока ЭтаФорма.Элементы.ГруппаПроверки.ПодчиненныеЭлементы.Количество() > 0 Цикл
		
		ИмяТекущейКоманды = ЭтаФорма.Элементы.ГруппаПроверки.ПодчиненныеЭлементы[0].Имя;		
		ТекущаяКомандаЭлм = ЭтаФорма.Элементы[ИмяТекущейКоманды];
		ТекущаяКомандаОбк = ЭтаФорма.Команды.Найти(ИмяТекущейКоманды);
		
		ЭтаФорма.Элементы.Удалить(ТекущаяКомандаЭлм);
		ЭтаФорма.Команды.Удалить(ТекущаяКомандаОбк);
		
	КонецЦикла	
	 
КонецПроцедуры

&НаСервере
Процедура ЗавершитьСборкуПазлаЕслиЭтоПоследняяСтрокаНаСервере()
	
	ИндексСтроки 	= ЭтотОбъект.ТекущийИндексСтроки;	
	ТЧДанные 		= ЭтотОбъект.Параметры.Ссылка.Тело;
	
	Если ИндексСтроки >= ТЧДанные.Количество() Тогда
		ЭтаФорма.КоманднаяПанель.Доступность = Ложь;
		
		РодительИнфСообщения = ЭтаФорма.Элементы.ГруппаСлова;
		Элемент 			= Элементы.Добавить("ИнформационноеСообщенияОЗавершении", Тип("ДекорацияФормы"), РодительИнфСообщения);
    	Элемент.Вид			= ВидДекорацииФормы.Надпись;
    	Элемент.Заголовок 	= НСтр("ru = 'Ура! Пазл собран!'; en = 'Yes! The puzzle is assembled!'");
	КонецЕсли;
	 
КонецПроцедуры

&НаСервере
Функция ПроверитьСловаВСтрокеСоответствуютПорядкуНаСервере(мСлов)
	
	РезультатПроверкиНаСервере = Истина;

	Если ЭтаФорма.Параметры.Ссылка.Тело.Количество() < мСлов[0].ИндексСтроки + 1 Тогда
		РезультатПроверкиНаСервере = Ложь;
		Возврат РезультатПроверкиНаСервере;
	КонецЕсли;
	
	данные 		= ЭтаФорма.Параметры.Ссылка.Тело[мСлов[0].ИндексСтроки].СтрокаДанных;
	стрДанных 	= СтрРазделить(данные, " ", Ложь);
	
	Если стрДанных.Количество() <> мСлов.Количество() Тогда
		РезультатПроверкиНаСервере = Ложь;
		Возврат РезультатПроверкиНаСервере;	
	КонецЕсли;
	
	///////////////////////////////////////////////////////////////////
	ИтераторСлов = 0;
	Пока ИтераторСлов < стрДанных.Количество() Цикл				
		
		СловоОригинал = ОбщегоНазначенияСервер.ЗаменитьНеВалидныеСимволыВСтроке(стрДанных[ИтераторСлов]);
		
		Если ВРег(СловоОригинал) <> ВРег(мСлов[ИтераторСлов].Слово) Тогда
			РезультатПроверкиНаСервере = Ложь;
			Возврат РезультатПроверкиНаСервере;
		КонецЕсли;
		
		ИтераторСлов = ИтераторСлов + 1;
	КонецЦикла;
	
	Возврат РезультатПроверкиНаСервере;
	
КонецФункции // ПроверитьСловаВСтрокеСоответствуютПорядкуНаСервере()

&НаСервере
Процедура ДобавитьСловоКакКомандуВНабор(ИндексСтроки, ИндексСлова, Слово)

	ВалидноеИмяКоманды		= ОбщегоНазначенияСервер.ЗаменитьНеВалидныеСимволыВСтроке(Слово);	
	ЗаголовокКоманды		= Слово;
	РодительКоманды 		= ЭтаФорма.Элементы.ГруппаСлова;
	ТекущееКоличествоКоманд	= ЭтаФорма.Элементы.ГруппаСлова.ПодчиненныеЭлементы.Количество();
	ИмяКомандыСПараметрами	= СтрШаблон("КомандаСловоВыбрано%1_%2_%3_%4", 
								ТекущееКоличествоКоманд, ИндексСтроки, ИндексСлова, ВалидноеИмяКоманды);
	
	НоваяКоманда 			= Команды.Добавить(ИмяКомандыСПараметрами);
	НоваяКоманда.Действие 	= "СловоВыбрано"; // Имя процедуры
	НоваяКоманда.Заголовок 	= ЗаголовокКоманды;
	
	НовыйЭлемент 			= Элементы.Добавить(ИмяКомандыСПараметрами, Тип("КнопкаФормы"), РодительКоманды);
	НовыйЭлемент.ИмяКоманды = ИмяКомандыСПараметрами;
	НовыйЭлемент.Заголовок  = Слово;
	
КонецПроцедуры

&НаСервере
Процедура ПрисвоитьКомандеРодителя(эКомандаФормыИмя, эРодительИмя)

	ЭтаФорма.Элементы.Переместить(ЭтаФорма.Элементы[эКомандаФормыИмя], ЭтаФорма.Элементы[эРодительИмя]);

КонецПроцедуры

&НаСервере
Процедура НаполнитьФормуКомандамиИзСтрокиПоИндексу(ИндексСтроки)
	
	ТЧДанные = ЭтотОбъект.Параметры.Ссылка.Тело;
	
	Если ИндексСтроки >= ТЧДанные.Количество() Тогда
		Возврат;
	КонецЕсли;
	
	мСловВСтроке = СтрРазделить(ТЧДанные[ИндексСтроки].СтрокаДанных, " ", Ложь);

	минЗнчИндекса 		= 0;
	максЗнчИндекса		= мСловВСтроке.Количество() - 1;
	СлучайноеЧисло		= ОбщегоНазначенияСервер.ПолучитьСлучайноеЧисло(минЗнчИндекса, максЗнчИндекса);
	мДобавленныхСлов	= Новый Массив;
	
	Пока мДобавленныхСлов.Количество() < мСловВСтроке.Количество() И СлучайноеЧисло < мСловВСтроке.Количество() Цикл	
		
		СлучайноеЧисло 		= ОбщегоНазначенияСервер.ПолучитьСлучайноеЧисло(минЗнчИндекса, максЗнчИндекса);		
		ПозицияСловаВСтроке = СлучайноеЧисло;
		
		словоДобавлено = Ложь;
		
		Для каждого ОписаниеСлова Из мДобавленныхСлов Цикл
			Если СлучайноеЧисло = ОписаниеСлова.ПозицияСловаВСтроке Тогда 
				словоДобавлено = Истина;
				Прервать;
			КонецЕсли;
		КонецЦикла;
		
		Если словоДобавлено Тогда		
			Продолжить;		
		КонецЕсли;
		
		Слово = Новый Структура;
		
		Слово.Вставить("ПозицияСловаВСтроке",	СлучайноеЧисло);
		Слово.Вставить("Текст",					мСловВСтроке[СлучайноеЧисло]);
		
		мДобавленныхСлов.Добавить(Слово);
		
	КонецЦикла;
	
	Для каждого ОписаниеСлова Из мДобавленныхСлов Цикл	
		ДобавитьСловоКакКомандуВНабор(ИндексСтроки, ОписаниеСлова.ПозицияСловаВСтроке, ОписаниеСлова.Текст);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура Подсказка(Команда)
	
	ТекстПодсказки = ПолучитьТекстПодсказкиТекущейСтрокиСервер(ЭтотОбъект.ТекущийИндексСтроки);
	Если ТекстПодсказки = Неопределено Тогда
		текстОшибкиПолучитьПодсказку = ОбщийОписаниеОшибокНаКлиенте.текстОшибкиПолучитьПодсказку();
		Сообщить(текстОшибкиПолучитьПодсказку);
		Возврат;	
	КонецЕсли;
	
	ОчиститьСообщения();
	Сообщить(ТекстПодсказки);
	
КонецПроцедуры