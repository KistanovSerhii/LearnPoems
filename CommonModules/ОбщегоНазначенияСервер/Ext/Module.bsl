﻿
Функция ПолучитьСлучайноеЧисло(числоОт, числоДо) Экспорт

	НачальноеЧисло 	= числоОт;
	ГСЧ 			= Новый ГенераторСлучайныхЧисел(НачальноеЧисло);
	СлучайноеЧисло 	= ГСЧ.СлучайноеЧисло(числоОт, числоДо);
	
	Возврат СлучайноеЧисло;

КонецФункции // ПолучитьСлучайноеЧисло()

Функция ПолучитьСтруктуруСправочникаПроизведения() Экспорт

	ДанныеСтруктура = Новый Структура;
	
	ДанныеСтруктура.Вставить("Description", 		"");
	ДанныеСтруктура.Вставить("DeletionMark", 		Ложь);
	ДанныеСтруктура.Вставить("Связь", 				Справочники.Произведения.ПустаяСсылка());
	ДанныеСтруктура.Вставить("Дата",				'00010101');
	ДанныеСтруктура.Вставить("Автор",				"");
	ДанныеСтруктура.Вставить("Подсказка",			"");
	ДанныеСтруктура.Вставить("Коммент",				"");
	ДанныеСтруктура.Вставить("СодержитКартинку", 	Ложь);
	ДанныеСтруктура.Вставить("АдресКартинки",		Неопределено);
	ДанныеСтруктура.Вставить("Тело", 				Новый Массив);
	
	Возврат ДанныеСтруктура;

КонецФункции // ПолучитьСтруктуруСправочникаПроизведения()


