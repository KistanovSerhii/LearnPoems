﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ИнициализироватьИнтерфейсСтатистикаАвтора();

КонецПроцедуры

&НаСервере
Процедура ИнициализироватьИнтерфейсСтатистикаАвтора()

	СтатистикаАвторов = ОбщегоНазначенияСервер.ПолучитьСтатистикуВсехАвторов();
	ВыборкаСтатистика = СтатистикаАвторов.Выборка;
	ВсегоПроизведений = СтатистикаАвторов.Всего;
	
    Если НЕ ВсегоПроизведений Тогда	
		Возврат;	
	КонецЕсли;
	
	Пока ВыборкаСтатистика.Следующий() Цикл
		АвтораУИД				= XMLСтрока(ВыборкаСтатистика.Ссылка);
		ИмяАвтора				= ВыборкаСтатистика.ИмяАвтора;
		КоличествоПроизведений	= ВыборкаСтатистика.Количество;
		
		КонструкторИнтерфейсовСервер.СоздатьСтатистическуюКарточкуАвтора(
		ЭтаФорма, АвтораУИД, ИмяАвтора, КоличествоПроизведений, ВсегоПроизведений);
	КонецЦикла;

КонецПроцедуры

&НаСервере
Функция ПолучитьЗначениеОтбораПоИмениКомандыНаСервере(ИмяКоманды)

	ЗаголовокКоманды = ЭтаФорма.Команды.Найти(ИмяКоманды).Заголовок;

	Если НЕ ЗначениеЗаполнено(ЗаголовокКоманды) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	АвторУИД		= Новый УникальныйИдентификатор(ЗаголовокКоманды);
	АвторСсылка 	= Справочники.Авторы.ПолучитьСсылку(АвторУИД).Ссылка;
	
	ЗначениеОтбора 	= Новый Структура("Автор", АвторСсылка);
	
	Возврат ЗначениеОтбора;

КонецФункции

&НаКлиенте
Процедура АвторНажатие(Элемент, СтандартнаяОбработка)
	
	ЗначениеОтбора = ПолучитьЗначениеОтбораПоИмениКомандыНаСервере(Элемент.Имя);
	Если ЗначениеОтбора = Неопределено Тогда
		ОшибкаПолученияЗаголовкаКоманды = ОбщийОписаниеОшибокНаКлиенте.текстОшибкиПолучитьЗначениеОтбораПоИмениКоманды();
		Сообщить(ОшибкаПолученияЗаголовкаКоманды);	
		Возврат;
	КонецЕсли;
	
	ПараметрыВыбора = Новый Структура("Отбор", ЗначениеОтбора);
	ОткрытьФорму("Справочник.Произведения.ФормаСписка", ПараметрыВыбора, ЭтаФорма, Истина);
	
КонецПроцедуры
