-- ============================================================
-- Русская локализация для мода Cryptid (Balatro)
-- ============================================================

-- ─── Шаблоны, которые используются многократно ──────────────
-- Теги серии «базовый джокер → выпуск»
local function edition_tag(edition_ru)
    return {
        "В следующем магазине базовый",
        "Джокер бесплатен и",
        "становится {C:dark_edition}" .. edition_ru,
    }
end

-- «Рука содержит #2#» для джокеров одного шаблона
local function hand_contains(bonus_line)
    return {
        bonus_line,
        "содержит",
        "{C:attention}#2#",
    }
end

-- «Выберите #1# из #2# карт кода»
local CODE_PACK_TEXT = {
    "Выберите {C:attention}#1#{} из",
    "{C:attention}#2#{C:cry_code} карт кода",
}

-- «Все карты в наборе являются …»
local function booster_sticker(name_ru, sticker_ru)
    return {
        name = name_ru,
        text = {
            "Все карты в наборе",
            "являются {C:attention}" .. sticker_ru,
        },
    }
end

-- ─── Шаблон для планет-трио (Sydan / Klubi / Lapio / Timantti / Kaikki / Voxel) ──
local TRIO_PLANET_TEXT = {
    "({V:1}ур.#4#{})({V:2}ур.#5#{})({V:3}ур.#6#{}) Повышение уровня",
    "{C:attention}#1#{},",
    "{C:attention}#2#{},",
    "и {C:attention}#3#{}",
}

-- ─── Шаблон для asteroidbelt / void / marsmoons  / nibiru ──
local SPACE_OBJECT_TEXT = {
    "({V:1}ур.#1#{}) Повышение уровня",
    "{C:attention}#2#{},",
    "{C:mult}+#3#{} Множ. и",
    "{C:chips}+#4#{} шт. фишек",
}

-- ─── Шаблон для тегов-множителей (Triple/Quadruple/Quintuple) ──
local function multiplier_tag(name_ru, count_ru)
    return {
        name = name_ru,
        text = {
            "Даёт {C:attention}#1#{} " .. count_ru .. " копии",
            "следующего выбранного {C:attention}тега",
            "{s:0.8,C:inactive}Копирующие теги исключены",
        },
    }
end

-- ============================================================
return {
    descriptions = {

        -- ── КОЛОДЫ ──────────────────────────────────────────
        Back = {
            b_cry_antimatter = {
                name = "Колода антиматерии",
                text = {
                    "Применяет {C:legendary,E:1}плюсы{}",
                    "{C:attention}каждой{} колоды",
                },
            },
            b_cry_beta = {
                name = "Ностальгическая колода",
                text = {
                    "Слоты под {C:attention}Джокеры{}",
                    "и под {C:attention}Расходники{} {C:attention}соединены",
                    "{C:attention}Ностальгические{} блайнды заменяют",
                    "их обновлённые блайнды",
                },
            },
            b_cry_blank = {
                name = "Пустая колода",
                text = { "{C:inactive,E:1}Ничего не делает?" },
            },
            b_cry_CCD = {
                name = "CCD Колода",
                text = {
                    "Каждая карта это ещё и",
                    "{C:attention}случайный{} расходник",
                },
            },
            b_cry_conveyor = {
                name = "Конвейерная колода",
                text = {
                    "Джокеров {C:attention}нельзя{} двигать",
                    "в начале раунда,",
                    "{C:attention}дублирует{} самого правого джокера",
                    "и {C:attention}уничтожает{} самого левого джокера",
                },
            },
            b_cry_critical = {
                name = "Критическая колода",
                text = {
                    "После каждой сыгранной руки,",
                    "{C:green}#1# к #2#{} шанс для {X:dark_edition,C:white} ^2 {} Множ",
                    "{C:green}#1# к #3#{} шанс для {X:dark_edition,C:white} ^0.5 {} Множ",
                },
            },
            b_cry_encoded = {
                name = "Закодированная колода",
                text = {
                    "Начинаете партию с {C:cry_code,T:j_cry_CodeJoker}Код Джокером{}",
                    "и {C:cry_code,T:j_cry_copypaste}Копировать/Вставить{}",
                    "Только {C:cry_code}Карты кода{} появляются в магазине",
                },
            },
            b_cry_equilibrium = {
                name = "Колода равновесия",
                text = {
                    "Все карты имеют",
                    "{C:attention}одинаковый шанс{}",
                    "Появления в магазинах,",
                    "Начинаете партию с",
                    "{C:attention,T:v_overstock_plus}Изобилие перебросов",
                },
            },
            b_cry_glowing = {
                name = "Светящаяся колода",
                text = {
                    "Умножает значения всех",
                    "джокеров на {X:dark_edition,C:white} X1.25 {}",
                    "после победы над босс-блайндом",
                    "{X:cry_jolly,C:white,s:0.8} Jolly#1#Open#1#Winner#1#-#1#wawa#1#person",
                },
            },
            b_cry_infinite = {
                name = "Бесконечная колода",
                text = {
                    "Вы можете выбрать{C:attention}любое",
                    "количество карт",
                    "{C:attention}+1{} размер руки",
                },
            },
            b_cry_misprint = {
                name = "Колода с опечатками",
                text = {
                    "Числа карт",
                    "и покерных рук",
                    "{C:attention}случайны",
                },
            },
            b_cry_redeemed = {
                name = "Погашенная колода",
                text = {
                    "Когда {C:attention}Ваучер{} куплен,",
                    "получаешь {C:attention}все улучш. версии",
                },
            },
            b_cry_very_fair = {
                name = "Очень честная колода",
                text = {
                    "{C:blue}-2{} руки, {C:red}-2{} сброса",
                    "каждый раунд",
                    "{C:attention}Ваучеры{} не появляются",
                    "в магазине",
                },
            },
            b_cry_wormhole = {
                name = "Колода червоточины",
                text = {
                    "Начинаете с {C:cry_exotic}Экзотическим{C:attention} Джокером",
                    "Джокеры в {C:attention}20X{} чаще",
                    "появляются {C:dark_edition}Негативными",
                    "{C:attention}-2{} Слота джокера",
                },
            },
            b_cry_bountiful = {
				name = "Изобильная колода",
				text = {
					"После {C:blue}Игры{} или {C:red}Сброса{},",
					"всегда тяните {C:attention}5{} карт",
				},
				unlock = {
					"Победите {C:attention}Змея",
					"без {C:red}сбросов",
				},
			},
            b_cry_sk_deck = {
				name = "Колода с наклейками",
				text = {
					"Все карты с {C:attention}#1#{}",
					"{C:inactive}(Нажмите чтобы сменить)",
				},
				unlock = {
					"Используйте {C:spectral}Замок",
				},
			},
			b_cry_sl_deck = {
				name = "Колода с печятями",
				text = {
					"Все карты с {C:dark_edition}#1#{}",
					"Карты не могут сменить печати",
					"{C:inactive}(Нажмите чтобы сменить)",
				},
				unlock = {
					"Используйте {C:spectral}Тайфун",
				},
			},
            b_cry_beige = {
				name = "Бежевая колода",
				text = {
					"Значения {C:attention}обычных{} Джокеров",
					"{C:attention}учетверены{}",
				},
				unlock = {
					"Откройте минимум",
					"{C:attention}200{} предметов",
					"в коллекции",
				},
			},
            b_cry_e_deck = {
				name = "Колода изданий",
				text = {
					"Все карты — {C:dark_edition}#1#{}",
					"Карты не могут менять издание",
					"{C:inactive}(Нажмите чтобы сменить)",
				},
				unlock = {
					"Откройте все",
					"{C:dark_edition}Издания",
				},
			},
			b_cry_spooky = {
				name = "Жуткая колода",
				text = {
					"Начните с {C:eternal}вечным{} {C:attention,T:j_cry_chocolate_dice}Шоколадным кубиком",
					"после каждого {C:attention}Анте{}, создайте",
					"{C:cry_candy}Конфету{} или {X:cry_cursed,C:white}Проклятого{} джокера",
				},
				unlock = {
					"Получите {C:cry_candy}любую конфету{C:attention}",
				},
			},
            b_cry_legendary = {
				name = "Легендарная колода",
				text = {
					"Начать с {C:legendary}Легендарным{C:legendary} Джокером",
					"{C:green}#1# к #2#{} шанс создать ещё одного",
					"после победы над Босс-блайндом{C:inactive}",
                    "(Должно быть место){C:inactive}",
				},
				unlock = {
					"Имейте {C:attention}2 Легендарных Джокера",
					"одновременно",
				},
			},
            b_cry_et_deck = {
				name = "Колода улучшений",
				text = {
					"Все игровые карты — {C:dark_edition}#1#",
					"{C:inactive}(Нажмите чтобы сменить)",
				},
				unlock = {
					"Используйте {C:spectral}Вакуум",
				},
			},
			b_cry_st_deck = {
				name = "Одномастная колода",
				text = {
					"Все игровые карты — {C:dark_edition}#1#",
					"и не могут менять масть",
					"{C:inactive}(Нажмите чтобы сменить)",
				},
				unlock = {
					"Используйте {C:spectral}Реплику",
				},
			},
        },

        -- ── БЛАЙНДЫ ─────────────────────────────────────────
        Blind = {
            bl_cry_box          = { name = "Коробка",               text = { "Все обычные джокеры", "ослабляются" } },
            bl_cry_clock        = { name = "Часы",                  text = { "+0.1X минимум очков каждые", "12 секунды в этом анте" } },
            bl_cry_hammer       = { name = "Молоток",               text = { "Все карты с нечётным", "рангом ослабляются" } },
            bl_cry_joke         = { name = "Шутка",                 text = { "Если очки в два раза больше минимума,", "Умножить анте на #1#" } },
            bl_cry_magic        = { name = "Магия",                 text = { "Все карты с чётным", "рангом ослабляются" } },
            bl_cry_lavender_loop = { name = "Лавандовый круг",      text = { "1.25X минимум очков каждые", "6 секунды потраченные в этом раунде" } },
            bl_cry_obsidian_orb = { name = "Обсидиановая сфера",    text = { "Применяет все способности", "побеждённых босс-блайдов" } },
            bl_cry_oldarm       = { name = "Рука, Ностальгия",      text = { "Необходима сыграть 4", "или меньше карт" } },
            bl_cry_oldfish      = { name = "Рыба, Ностальгия",      text = { "Все руки начинают", "с 1 Множ." } },
            bl_cry_oldflint     = { name = "Кремень, Ностальгия",   text = { "Без флешов" } },
            bl_cry_oldhouse     = { name = "Дом, Ностальгия",       text = { "Без фулл-хаусов" } },
            bl_cry_oldmanacle   = { name = "Кандалы, Ностальгия",   text = { "Разделить Множ. на Сбросы" } },
            bl_cry_oldmark      = { name = "Знак, Ностальгия",      text = { "Без рук,", "которые содержат пару" } },
            bl_cry_oldox        = { name = "Буйвол, Ностальгия",    text = { "Все руки начинают", "с нулём фишек" } },
            bl_cry_oldpillar    = { name = "Столп, Ностальгия",     text = { "Без стритов" } },
            bl_cry_oldserpent   = { name = "Змей, Ностальгия",      text = { "Разделить Множ.", "на уровень разыгранной руки" } },
            bl_cry_pin          = { name = "Булавка",               text = { "Джокеры с эпической или выше", "редкостью ослабляются" } },
            bl_cry_pinkbow      = { name = "Бантик",                text = { "Картам присваивается случайная", "" } },
            bl_cry_sapphire_stamp = { name = "Сапфировый штамп",    text = { "Выбор дополнительной карты,", "случайная карта не учитывается" } },
            bl_cry_shackle      = { name = "Кандалы 2.0",           text = { "Все негативные джокеры", "ослаблены" } },
            bl_cry_striker      = { name = "Нападающий",            text = { "Все редкие джокеры", "ослаблены" } },
            bl_cry_tax          = { name = "Налог",                 text = { "Максимальные очки за руку", "0.4X требований блайнда" } },
            bl_cry_tornado      = { name = "Бирюзовый торнадо",     text = { "#1# в #2# шанс что", "руку не посчитает" } },
            bl_cry_trick        = { name = "Трюк",                  text = { "После каждой руки, переворачивает", "все карты в руке рубашкой вверх" } },
            bl_cry_vermillion_virus = { name = "Вирус Вермиллион",  text = { "Один случайный джокер", "заменяется каждую руку" } },
            bl_cry_windmill     = { name = "Мельница",              text = { "Все необычные джокеры", "ослаблены" } },
			bl_cry_scorch       = { name = "Ожог",                  text = {"Необходимо сыграть 5 карт,", "уничтожает сыгранные и", "сброшеные карты"} },
			bl_cry_greed        = { name = "Жадность",              text = {"+(0.25X баз.) требования блайнда", "за каждие $5 когда выбран"} },
			bl_cry_decision     = { name = "Решение",               text = {"Закрепите джокеров при игре или сбросе", "Откройте «Злобный набор шута»", "после раунда."} },
			bl_cry_repulsor     = { name = "Репульсор",             text = {"Повторно активируйте крайний правый и", "крайний левый джокеры, остальные джокеры не активируются."} },
			bl_cry_chromatic    = { name = "Хроматический",         text = {"Счёт нечётных рук вычитается"} },
			bl_cry_landlord     = { name = "Помещик",               text = {"Cлучайный джокер", "становится прокатным", "когда сыграна рука"} },
			bl_cry_trophy       = { name = "Лимонный трофей",       text = {"Множ. не может", "превысить фишки"} },
        },

        -- ── КАРТЫ КОДА ──────────────────────────────────────
        Code = {
            c_cry_alttab = {
				name = "://ALTTAB",
				text = {
					"Создать {C:cry_code}текущий{}",
					"тег пропуска блайнда",
					"{C:inactive}(Сейчас: {C:cry_code}#1#{C:inactive})",
				},
			},
            c_cry_assemble = {
				name = "://ASSEMBLE",
				text = {
					"Добавить {C:cry_code}Множ.{} к",
					"{C:cry_code}выбранной руке{} равный",
					"количеству имеющихся Джокеров",
				},
			},
            c_cry_class = {
                name = "://CLASS",
                text = {
                    "Конвертировать {C:cry_code}#1#{} выбранную карту",
                    "в {C:cry_code}выбранное{} улучшение",
                },
            },
            c_cry_commit = {
                name = "://COMMIT",
                text = {
                    "Уничтожить {C:cry_code}выбранного{} джокера,",
                    "создать {C:cry_code}нового{} джокера",
                    "той же {C:cry_code}редкости",
                },
            },
            c_cry_ctrl_v = {
				name = "://CTRL+V",
				text = {
					"Создать {C:cry_code}копию{} выбранной",
					"игровой карты или расходника",
				},
			},
            c_cry_crash = {
                name = "://CRASH",
                text = { "{C:cry_code,E:1}Не думай." },
            },
            c_cry_declare = {
				name = "://DECLARE",
				text = {
					"Ваши {C:attention}текущие{} выбранные карты",
					"становятся {C:cry_code}новой{} покерной рукой,",
					"считающейся содержащей {C:attention}#1#{}",
					"Можно создать до {C:attention}3{} {C:inactive}[#2#]{} рук",
				},
			},
            c_cry_delete = {
                name = "://DELETE",
                text = {
                    "{C:cry_code}Навсегда{} удалить",
                    "{C:cry_code}выбранный{} предмет из магазина",
                    "{C:inactive,s:0.8}Предмет больше не появится в этом забеге",
                },
            },
            c_cry_divide = {
                name = "://DIVIDE",
                text = {
                    "Уменьшить цены {C:cry_code}Наполовину{}",
                    "в текущем магазине",
                },
            },
            c_cry_exploit = {
                name = "://EXPLOIT",
                text = {
                    "{C:cry_code}Следущая{} рука",
                    "считается",
                    "{C:cry_code}выбранной{} покерной рукой",
                    "{C:inactive,s:0.8}Секретные покерные руки",
                    "{C:inactive,s:0.8}должны быть найдены, чтобы они считались",
                },
            },
            c_cry_global = {
				name = "://GLOBAL",
				text = {
					"Выберите игровую карту,",
					"чтобы она стала {C:cry_code}Глобальной{}",
				},
			},
            c_cry_cryfunction = {
				name = "FUNCTION://",
				text = {
					"Сохраняет {C:cry_code}последние три{} использованных расходника,",
					"повторное использование создаёт копию",
					"первого с наклейкой {C:cry_code}Function://{}",
				},
			},
            c_cry_hook = {
                name = "HOOK://",
                text = {
                    "Выберите двух джокеров",
                    "которые будут {C:cry_code}соединены",
                },
            },
            c_cry_inst = {
				name = "://INSTANTIATE",
				text = {
					"Взять карту с {C:cry_code}рангом{} выбранной карты",
					"и карту с {C:cry_code}мастью{} выбранной карты",
					"{C:inactive}(если возможно){}",
				},
			},
            c_cry_machinecode = { name = "://MACHINECODE", text = { "" } },
            c_cry_malware = {
                name = "://MALWARE",
                text = {
                    "Добавляет {C:dark_edition}Глючный{} ко всем",
                    "картам {C:cry_code}в руке",
                },
            },
            c_cry_merge = {
                name = "://MERGE",
                text = {
                    "Соединить {C:cry_code}Расходник",
                    "с выбранной {C:cry_code}игральной картой",
                },
            },
            c_cry_keygen = {
				name = "://KEYGEN",
				text = {
					"Создать случайный {C:cry_code}ваучер Банан{}",
					"со стикером Скоропортящийся, {C:cry_code}уничтожить{} ранее",
					"созданный таким образом ваучер",
				},
			},
            c_cry_nperror = {
				name = "://NPERROR",
				text = {
					"Возвращает {C:cry_code}последнюю сыгранную руку{}",
					"обратно в вашу руку",
				},
			},
            c_cry_log = {
				name = "://LOG",
				text = {
					"Показать {C:cry_code}данные{} на выбор: ",
					"{C:attention}Босс-блайнд{} и {C:attention}ваучер{} следующего анте,",
					"следующие {C:attention}5{} {C:attention}Джокеров{} из магазина, или",
					"следующие {C:attention}10{} игровых карт для {C:attention}вытягивания{}",
					"{C:inactive}(Только в блайнде){}",
				},
			},
            c_cry_multiply = {
                name = "://MULTIPLY",
                text = {
                    "{C:cry_code}Удваивает{} все значения",
                    "выбранного {C:cry_code}Джокера{} до",
                    "конца раунда",
                },
            },
            c_cry_payload = {
                name = "://PAYLOAD",
                text = {
                    "Следующий блайнд",
                    "даёт {C:cry_code}X#1#{} процентов ",
                },
            },
            c_cry_oboe = {
                name = "://OFFBYONE",
                text = {
                    "Следующий {C:cry_code}Набор{} имеет на",
                    "{C:cry_code}#1#{} дополнительную карту и",
                    "{C:cry_code}#1#{} дополнительный выбор",
                    "{C:inactive}(Сейчас: {C:cry_code}+#2#{C:inactive})",
                },
            },
            c_cry_reboot = {
                name = "://REBOOT",
                text = {
                    "Даёт обратно {C:blue}Руки{} и {C:red}Сбросы{},",
                    "возвращает {C:cry_code}все{} карты в колоду",
                    "и вытягивает {C:cry_code}новую{} руку",
                },
            },
            c_cry_revert = {
                name = "://REVERT",
                text = {
                    "Ставит {C:cry_code}состояние игры{} на",
                    "начало {C:cry_code}Анте{}",
                },
            },
            c_cry_rework = {
                name = "://REWORK",
                text = {
                    "Уничтожить {C:cry_code}выбранного{} Джокера,",
                    "создаёт {C:cry_code}Тэг доработки{} с",
                    "{C:cry_code}улучшенной{} версии",
                    "{C:inactive,s:0.8}Следует порядку как в коллекции",
                },
            },
            c_cry_patch = {
				name = "://PATCH",
				text = {
					"Снять все {C:cry_code}ослабления{}",
					"с видимых предметов",
					"{C:cry_code}Сбросить{} состояние магазина",
				},
			},
            c_cry_run = {
                name = "://RUN",
                text = {
                    "Посетить {C:cry_code}магазин",
                    "посреди {C:cry_code}Блайнда",
                },
            },
            c_cry_seed = {
                name = "://SEED",
                text = {
                    "Выбери джокера",
                    "или игровую карту",
                    "чтобы те стали {C:cry_code}Подкрученными",
                },
            },
            c_cry_semicolon = {
                name = ";//",
                text = {
                    "Закончить текущий не-босс {C:cry_code}Блайнд{}",
                    "{C:cry_code}без{} подсчета денег",
                },
            },
            c_cry_spaghetti = {
                name = "://SPAGHETTI",
                text = {
                    "Создать {C:cry_code}Глючного",
                    "Съедобного Джокера",
                },
            },
            c_cry_quantify = {
				name = "://QUANTIFY",
				text = {
					"Переместить {C:attention}#1#{} выбранных",
					"{C:attention}карт или наборов{}",
					"в слот {C:attention}Джокеров{}",
				},
			},
            c_cry_variable = {
                name = "://VARIABLE",
                text = {
                    "Конвертировать {C:cry_code}#1#{} выбранных карт",
                    "в {C:cry_code}выбранный{} ранг",
                },
            },
        },
        ["Content Set"] = {
			set_cry_blind = {
				name = "Блайнды",
				text = {
					"{C:attention}Босс-Блайнды{} добавленные",
					"модом Cryptid",
				},
			},
			set_cry_code = {
				name = "Карты кода",
				text = {
					"{C:cry_code}Карты кода{} и",
					"связаные предметы",
				},
			},
			set_cry_cursed = {
				name = "Проклятые джокеры",
				text = {
					"Вредные джокеры с",
					"{X:cry_cursed,C:white}Проклятой{} редкостью",
				},
			},
			set_cry_deck = {
				name = "Колоды",
				text = {
					"{C:attention}Колоды{} добавленные",
					"модом Cryptid",
				},
			},
			set_cry_epic = {
				name = "Эпические Джокеры",
				text = {
					"Джокеры с",
					"{C:cry_epic}Эпической{} редкостью",
					"{C:inactive,s:0.8}(Между редкими и легендарными)",
				},
			},
			set_cry_exotic = {
				name = "Экзотические джокеры",
				text = {
					"Мощные джокеры с",
					"{C:cry_exotic}Экзотической{} редкостью",
				},
			},
			set_cry_m = {
				name = "М джокеры",
				text = {
					"Джокеры, связанные с",
					"буквой {C:attention}М{}",
					"и {C:attention}Весёлым джокером",
				},
			},
			set_cry_meme = {
				name = "Мемы",
				text = {
					"Вещи, связанные с",
					"множественными отсылками",
				},
			},
			set_cry_misc = {
				name = "Проч.",
				text = {
					"Вещи, которые",
					"не вписываются ни в какой другой",
					"{C:cry_ascendant}Тематический набор",
				},
			},
			set_cry_misc_joker = {
				name = "Проч. джокеры",
				text = {
					"{C:attention}Прочие джокеры{} добавленные",
					"модом Cryptid",
				},
			},
			set_cry_planet = {
				name = "Карты планет",
				text = {
					"Разные карты {C:planet}Планет{} добавленные",
					"модом Cryptid",
				},
			},
			set_cry_poker_hand_stuff = {
				name = "Покерные руки",
				text = {
					"5 новых {C:attention}покерных рук",
					"включая {C:attention}вознесённые руки",
				},
			},
			set_cry_spectral = {
				name = "Спектральные карты",
				text = {
					"{C:spectral}Спектральные{} карты добавленные",
					"модом Cryptid",
				},
			},
			set_cry_spooky = {
				name = "Жуткое обновление",
				text = {
					"Предметы из жуткого обновления,",
					"включая {C:cry_candy}Конфетных{} джокеров",
				},
			},
			set_cry_tag = {
				name = "Теги",
				text = {
					"{C:attention}Теги{} добавленные",
					"модом Cryptid",
				},
			},
			set_cry_tier3 = {
				name = "Ваучеры 3 уровня",
				text = {
					"Новый {C:attention}уровень{}",
					"Ваучеров",
				},
			},
			set_cry_timer = {
				name = "Механики связанные с таймерами",
				text = {
					"Предметы с еффектами завязаных на {C:attention}таймерах",
				},
			},
			set_cry_voucher = {
				name = "Проч. Ваучеры",
				text = {
					"{C:attention}Ваучеры{} 1 и 2 уровня добавленные",
					"модом Cryptid",
				},
			},
		},

        -- ── ВЫПУСКИ ─────────────────────────────────────────
        Edition = {
            e_cry_astral = {
                name = "Астральный",
                text = { "{X:dark_edition,C:white}^#1#{} Множ." },
            },
            e_cry_blur = {
                name = "Размытый",
                text = {
                    "{C:attention}Перезапустить{} эту",
                    "карту {C:attention}1{} раз",
                    "{C:green}#1# к #2#{} шанс",
                    "перезапустить ещё{C:attention}#3#{} раза",
                },
            },
            e_cry_double_sided = {
                name = "Двухсторонний",
                text = {
                    "Эта карта может быть",
                    "{C:attention}перевёрнута{} чтобы",
                    "показать другую карту",
                },
            },
            e_cry_glass = {
                name  = "Хрупкий",
                label = "Хрупкий",
                text  = {
                    "{C:white,X:mult} X#3# {} Множ",
                    "{C:green}#1# к #2#{} шанс, чтобы эта",
                    "карта не {C:red}уничтожилась",
                    "при срабатывании",
                },
            },
            e_cry_glitched = {
                name = "Глючный",
                text = {
                    "Все значения на карте",
                    "{C:dark_edition}случайны{}",
                    "между {C:attention}X0.1{} и {C:attention}X10{}",
                    "{C:inactive}(если возможно){}",
                },
            },
            e_cry_gold = {
                name  = "Золотой",
                label = "Золотой",
                text  = { "Заработать {C:money}$#1#{} при использовании", "или срабатывании" },
            },
            e_cry_m = {
                name = "Весёлый",
                text = {
                    "{C:mult}+#1#{} Множ",
                    "Эта карта чуствует",
                    "скорее всего {C:attention}веселье{}",
                },
            },
            e_cry_mosaic  = { name = "Мозаичный",      text = { "{X:chips,C:white} X#1# {} Фишек" } },
            e_cry_noisy   = { name = "Шумный",          text = { "???" } },
            e_cry_oversat = {
                name = "Перенасыщенный",
                text = {
                    "Все значения",
                    "на карте",
                    "{C:attention}удвоенны{}",
                    "{C:inactive}(Если возможно)",
                },
            },
        },

        -- ── УЛУЧШЕНИЯ ────────────────────────────────────────
        Enhanced = {
            m_cry_echo = {
                name = "Эхо-Карта",
                text = {
                    "{C:green}#2# к #3#{} шанс",
                    "{C:attention}перезапустить{} #1# дополнительных",
                    "раза когда сыграно",
                },
            },
            m_cry_light = {
				name = "Cветовая Карта",
                text = {
					"При активации вместе с {C:attention}#4#{} {C:inactive}(#3#){} другими",
					"засчитаними картами, получите {X:mult,C:white}X#1#{} Множ. и",
					"увеличьте требование на {C:attention}5{}",
					"{C:inactive}(В настоящее время {X:mult,C:white}X#2#{C:inactive} Множ.)",
				},
			},
			m_cry_abstract = {
				name = "Абстрактная Карта",
                text = {
					"{X:dark_edition,C:white}^#1#{} Множ.",
					"Считается своим {C:attention}собственным{} рангом и мастью",
					"{C:green}#4# к #5#{} шанс что",
					"{C:red,E:2}уничтожит{} карту, когда она находится в руке",
                    "когда {C:attention}разыграна рука{} или в {C:attention}конце раунда{}",
				},
			},
        },

        -- ── ДЖОКЕРЫ ─────────────────────────────────────────
        Joker = {
            j_cry_altgoogol = {
                name = "Ностальгическая Карта Googol Play",
                text = {
                    "Продайте эту карту, чтобы создать",
                    "{C:attention}2{} копии крайнего левого {C:attention}Джокера{}",
                    "{C:inactive,s:0.8}Не копирует Ностальгические Гугол Игровые Карты{}",
                },
            },
            j_cry_antennastoheaven = {
                name = " ...КАК АНТЕННЫ ДО НЕБЕС",
                text = {
                    "Этот джокер даёт",
                    "{X:chips,C:white} X#1# {} Фишек при подсчете",
                    "разыгранных {C:attention}7{} или {C:attention}4{}",
                    "{C:inactive}(Сейчас: {X:chips,C:white}X#2# {C:inactive} Фишек)",
                },
            },
            j_cry_apjoker = {
                name = "ББ Джокер",
                text = { "{X:mult,C:white} X#1# {} Множ. против {C:attention}Босс-Блайндов{}" },
            },
            j_cry_big_cube = {
                name = "Большой Куб",
                text = { "{X:chips,C:white} X#1# {} Фишек" },
            },
            j_cry_biggestm = {
                name = "ОгроМный",
                text = {
                    "{X:mult,C:white} X#1# {} Множ. до конца",
                    "раунда если {C:attention}покерная рука{}",
                    "это {C:attention}#2#{}",
                    "{C:inactive}(Сейчас: Множ {C:attention}#3#{}{C:inactive}){}",
                    "{C:inactive,s:0.8}просто широкая кость.",
                },
            },
            j_cry_blender = {
                name = "Блендер",
                text = {
                    "Создать {C:attention}случайный{}",
                    "Расходник когда",
                    "{C:cry_code}Карта кода{}  использована",
                    "{C:inactive}(Должно быть место){}",
                },
            },
            j_cry_blurred = {
                name = "Мыльный джокер",
                text = {
                    "{C:blue}+#1#{} рука(и) при",
                    "выборе {C:attention}блайнда{}",
                },
            },
            j_cry_bonk = {
                name = "Хрясь",
                text = {
                    "Каждый {C:attention}Джокер{} дает {C:chips}+#1#{} фишек",
                    "Увеличивает значение на {C:chips}+#2#{} если",
                    "{C:attention}покерная рука{} это {C:attention}#3#{}",
                    "{C:inactive,s:0.8}Веселые Джокеры вместо этого дают{} {C:chips,s:0.8}+#4#{} {C:inactive,s:0.8}фишек{}",
                },
            },
            j_cry_bonusjoker = {
                name = "Бонусный Джокер",
                text = {
                    "{C:green}#1# из #2#{} шанс что каждая",
                    "сыгранная {C:attention}Бонусная{} карта увеличит",
                    "{C:attention}слоты для {C:attention}джокеров{} или {C:attention}расходников",
                    "на {C:dark_edition}1{} когда засчитана",
                    "{C:red}Работает дважды за раунд",
                    "{C:inactive,s:0.8}(Равный шанс у каждой){}",
                },
            },
            j_cry_booster = {
                name = "Бустер Джокер",
                text = {
                    "{C:attention}+#1#{}Слот под Бустерные джокеры",
                    "В магазине",
                },
            },
            j_cry_boredom = {
                name = "Скука",
                text = {
                    "{C:green}#1# к #2#{} шанс",
                    "{C:attention}перезапустить{} каждого {C:attention}Джокера{}",
                    "или {C:attention}Игровую карту{}",
                    "{C:inactive,s:0.8}Не влияет на скуки{}",
                },
            },
            j_cry_bubblem = {
                name = "Пузырный М",
                text = {
                    "Создаёт {C:dark_edition}Фольгового {C:attention}Весёлого Джокера{}",
                    "если сыгранная рука содержит {C:attention}#1#{}",
                    "{C:red,E:2}самоуничтожается{}",
                },
            },
            j_cry_busdriver = {
                name = "Водитель автобуса",
                text = {
                    "{C:green}#1# к #3#{} шанс на {C:mult}+#2#{} Множ.",
                    "{C:green}1 к 4{} шанс на {C:mult}-#2#{} Множ.",
                },
            },
            j_cry_canvas = {
                name = "Холст",
                text = {
                    "{C:attention}Перезапускает{} ВСЕХ {C:attention}Джокеров{} слева",
                    "за {C:attention}каждого{} не-{C:blue}Обычного{C:attention} Джокера{}",
                    "справа этого джокера",
                },
            },
            j_cry_caramel = {
                name = "Карамель",
                text = {
                    "Каждая сыгранная карта даёт",
                    "{X:mult,C:white}X#1#{} Множ. при подсчете",
                    "для следующих {C:attention}#2#{} раундов",
                },
            },
            j_cry_chad = {
                name = "Чад",
                text = {
                    "Перезапуск {C:attention}крайнего левого{} Джокера",
                    "{C:attention}#1#{} дополнительный(ых) раз(а)",
                },
            },
            j_cry_chili_pepper = {
                name = "Перец чили",
                text = {
                    "Этот джокер даёт {X:mult,C:white} X#2# {} Множ.",
                    "в конце раунда,",
                    "{C:red,E:2}самоуничтожается{} через {C:attention}#3#{} раунда",
                    "{C:inactive}(Сейчас:{} Множ.{X:mult,C:white} X#1# {} {C:inactive}){}",
                },
            },
            j_cry_circulus_pistoris = {
                name = "Circulus Pistoris",
                text = {
                    "{X:dark_edition,C:white}^#1#{} Фишек, {X:dark_edition,C:white}^#1#{} Множ.",
                    "если {C:attention}ровно{} #2#",
                    "руки остаются",
                },
            },
            j_cry_circus = {
                name = "Цирк",
                text = {
                    "Каждый {C:red}Редкий{} даёт {X:mult,C:white} X#1# {} Множ.",
                    "Каждый {C:cry_epic}Эпический{} даёт {X:mult,C:white} X#2# {} Множ.",
                    "Каждый {C:legendary}Легендарный{} даёт {X:mult,C:white} X#3# {} Множ.",
                    "Каждый {C:cry_exotic}Экзотический{} даёт {X:mult,C:white} X#4# {} Множ.",
                },
            },
            j_cry_CodeJoker = {
                name = "Код Джокер",
                text = {
                    "Создаёт {C:dark_edition}Негативную{}",
                    "{C:cry_code}Код карту{} при",
                    "выборе {C:attention}Блайнда{}",
                },
                unlock = {
					"Открыть {C:attention}каждую",
					"{C:cry_code}Карту кода",
				},
            },
            j_cry_CodeJoker_modest = {
				name = "Код Джокер (Умеренный)",
				text = {
					"Может хранить и исполнять",
					"{C:cry_code}Карты кода{}",
					"{C:inactive}(Умеренная версия){}",
				},
			},
            j_cry_coin = {
                name = "Крипто Монета",
                text = {
                    "Получите между",
                    "{C:money}$#1#{} и {C:money}$#2#{} за",
                    "каждого {C:attention}проданного{} джокера",
                },
            },
            j_cry_compound_interest = {
                name = "Сложный процент",
                text = {
                    "Получайте {C:money}#1#%{} от всех денег",
                    "в конце раунда,",
                    "увеличивается на {C:money}#2#%{} за",
                    "каждую последующую выплату",
                },
            },
            j_cry_crustulum = {
                name = "Crustulum",
                text = {
                    "Этот джокер дает {C:chips}+#2#{} фишек",
                    "за каждый {C:attention}переброс{} в лавке",
                    "{C:green}Все перебросы бесплатные{}",
                    "{C:inactive}(Сейчас {C:chips}+#1#{C:inactive} фишек)",
                },
            },
            j_cry_cryptidmoment = {
                name = "Цепь М",
                text = {
                    "Продайте эту карту",
                    "чтобы добавить {C:money}$#1#{} {C:attention}к цене продажи{}",
                    "каждого {C:attention}джокера{}",
                },
            },
            j_cry_cube = { name = "Куб", text = { "{C:chips}+#1#{} фишек" } },
            j_cry_curse_sob = {
                name = "Рыдание",
                text = {
                    "{C:edition,E:1}ты не можешь{} {C:cry_ascendant,E:1}бежать...{}",
                    "{C:edition,E:1}ты не можешь{} {C:cry_ascendant,E:1}прятаться...{}",
                    "{C:dark_edition,E:1}ты не можешь...{}",
                    "{C:inactive}(Должно быть место){}",
                },
                unlock = {
					"Заполучите {C:purple}Вечный{}",
					"{C:attention}Обелиск",
				},
            },
            j_cry_cursor = {
                name = "Курсор",
                text = {
                    "Этот джокер дает {C:chips}+#2#{} фишек",
                    "за каждую {C:attention}купленную{} карта",
                    "{C:inactive}(Сейчас {C:chips}+#1#{C:inactive} фишек)",
                },
            },
            j_cry_cut = {
                name = "Вырезать",
                text = {
                    "Этот джокер уничтожает",
                    "случайную карту {C:cry_code}Кода{}",
                    "и получает {X:mult,C:white} X#1# {} множ.",
                    "в конце {C:attention}магазина{}",
                    "{C:inactive}(Сейчас {X:mult,C:white} X#2# {C:inactive} множ.)",
                },
            },
            -- Джокеры типа «рука содержит #2#» (шаблон hand_contains)
            j_cry_delirious  = { name = "Бредовый джокер",      text = hand_contains("{C:red}+#1#{} Множ., если рука") },
            j_cry_discreet   = { name = "Сдержанный джокер",    text = hand_contains("{C:chips}+#1#{} Фишек, если рука") },
            j_cry_filler     = { name = "Наполнитель",          text = hand_contains("{X:mult,C:white} X#1# {} Множ., если рука"), unlock = {"Выграть партию","не сыграв","{E:1,C:attention}Старшая карта"} },
            j_cry_foxy       = { name = "Хитрый джокер",        text = hand_contains("{C:chips}+#1#{} Фишек, если рука") },
            j_cry_giggly     = { name = "Абсурдный джокер",     text = hand_contains("{C:red}+#1#{} Множ., если рука") },
            j_cry_home       = { name = "Дом",                  text = hand_contains("{X:mult,C:white} X#1# {} множ. если сыгранная"), unlock = {"Выграть партию","не сыграв","{E:1,C:attention}Фулл-хаус"} },
            j_cry_kooky      = { name = "Чудаковатый джокер",   text = hand_contains("{C:red}+#1#{} множ. если сыгранная\nрука") },
            j_cry_manic      = { name = "Маниакальный джокер",  text = hand_contains("{C:red}+#1#{} Множ., если рука") },
            j_cry_nuts       = { name = "Сумасшествие",         text = hand_contains("{X:mult,C:white} X#1# {} Множ., если рука"), unlock = {"Выграть партию","не сыграв","{E:1,C:attention}Стрит-флеш"} },
            j_cry_quintet    = { name = "Квинтет",              text = hand_contains("{X:mult,C:white} X#1# {} Множ., если рука"), unlock = {"Победите когда", "вашей последней рукой был", "{E:1,C:attention}Пять одного вида",} },
            j_cry_swarm      = { name = "Рой",                  text = hand_contains("{X:mult,C:white} X#1# {} Множ., если рука"), unlock = {"Победите когда", "вашей последней рукой был", "{E:1,C:attention}Флеш-пять",} },
            j_cry_unity      = { name = "Единство",             text = hand_contains("{X:mult,C:white} X#1# {} Множ., если рука"), unlock = {"Победите когда", "вашей последней рукой был", "{E:1,C:attention}Флеш-xаус",} },
            j_cry_duos       = { name = "Пары",                 text = hand_contains("{X:mult,C:white} X#1# {} Множ., если рука"), unlock = {"Выграть партию","не сыграв","{E:1,C:attention}Две пары"} },
            j_cry_nutty      = { name = "Сумасшедший джокер",   text = hand_contains("{C:red}+#1#{} Множ., если рука") },
            j_cry_wacky      = { name = "Чокнутый джокер",      text = hand_contains("{C:red}+#1#{} Множ., если рука") },
            j_cry_tricksy    = { name = "Шаловливый джокер",    text = hand_contains("{C:chips}+#1#{} Фишек, если рука") },
            j_cry_dubious    = { name = "Подозрительный джокер",text = hand_contains("{C:chips}+#1#{} Фишек, если рука") },
            j_cry_savvy      = { name = "Смекалистый джокер",   text = hand_contains("{C:chips}+#1#{} Фишек, если рука") },
            j_cry_shrewd     = { name = "Проницательный джокер",text = hand_contains("{C:chips}+#1#{} Фишек, если рука") },
            j_cry_silly      = { name = "Глуповатый джокер",    text = hand_contains("{C:red}+#1#{} Множ., если рука") },
            j_cry_bonkers    = { name = "Спятивший джокер",     text = hand_contains("{C:red}+#1#{} Множ., если рука") },
            j_cry_foolhardy  = { name = "Безрассудный джокер",  text = hand_contains("{C:red}+#1#{} Множ., если рука") },
            j_cry_undefined  = { name = "Неопределенный джокер",text = hand_contains("{C:red}+#1#{} Множ., если рука") },
            j_cry_adroit     = { name = "Искусный джокер",      text = hand_contains("{C:chips}+#1#{} Фишек, если рука") },
            j_cry_penetrating = { name = "Проникающий джокер",  text = hand_contains("{C:chips}+#1#{} Фишек, если рука") },
            j_cry_treacherous = { name = "Предательский джокер",text = hand_contains("{C:chips}+#1#{} Фишек, если рука") },
            j_cry_nebulous   = { name = "Расплывчатый джокер",  text = hand_contains("{C:chips}+#1#{} Фишек, если рука") },
            j_cry_subtle     = { name = "Утонченный джокер",    text = hand_contains("{C:chips}+#1#{} Фишек, если рука") },
            j_cry_words_cant_even = { name = "Словами невозможно описать этого Джокера.", text = hand_contains("{X:mult,C:white} X#1# {} Множ., если рука") },
            j_cry_many_lost_minds = { name = "Многие сошли с ума, пытаясь понять этого джокера.", text = hand_contains("{C:chips}+#1#{} Фишек, если рука") },

            j_cry_fuckedup = {
				name = Cryptid_config.family_mode and "Аккуратный джокер" or "Бардачный джокер",
				text = hand_contains("{C:red}+#1#{} Множ., если рука") 
            },
            j_cry_stronghold = {
				name = "Крепость",
				text = {
					"{X:mult,C:white} X#1# {} Множ., если рука",
					"содержит",
					"{C:attention}#2#",
				},
				unlock = {
					"Победите когда",
					"вашей последней рукой был",
					"{E:1,C:attention}Бастион",
				},
			},
            j_cry_wtf = {
				name = Cryptid_config.family_mode and "Кластер" or "Что за хрень!?",
				text = {
					"{X:mult,C:white} X#1# {} Множ., если рука",
					"содержит",
					"{C:attention}#2#",
				},
				unlock = {
					"Победите когда",
					"вашей последней рукой был",
					"{E:1,C:attention}#1#",
				},
			},
            j_cry_clash = {
				name = "Столкновение",
				text = {
					"{X:mult,C:white} X#1# {} Множ., если рука",
					"содержит",
					"{C:attention}#2#",
				},
				unlock = {
					"Победите когда",
					"вашей последней рукой была",
					"{E:1,C:attention}Ультимативная пара",
				},
			},
            j_cry_emergencychips = {
				name = "Аварийные фишки",
				text = {
					"Мгновенно получите",
					"{C:chips}#1#%{} от требования блайнда",
					"как счёт при продаже",
					"{C:inactive}(Сейчас {}{C:chips}#2#{}{C:inactive}){}",
				},
			},
            j_cry_astral_bottle = {
				name = "Астрал в бутылке",
				text = {
					"При продаже применяет {C:dark_edition}Астральный{}",
					"и {C:attention}Портящийся{} к",
					"случайному {C:attention}джокеру{}",
				},
			},
			j_cry_astral_bottle_mainline = {
				name = "Астрал в бутылке",
				text = {
					"При продаже применяет {C:dark_edition}Астральный{}",
					"и {C:attention}Портящийся{} к",
					"другим, случайным {C:attention}джокерам{}",
				},
			},
			j_cry_astral_bottle_madness = {
				name = "Астрал в бутылке",
				text = {
					"При продаже применяет {C:dark_edition}Астральный{}",
					"случайному {C:attention}джокеру{}",
				},
			},
            j_cry_universe = {
				name = "Вселенная",
				text = {
					"Другие {C:dark_edition}Астральные{} карты",
					"дают {X:dark_edition,C:white}^#1#{} Множ.",
				},
			},
            j_cry_annihalation = {
				name = {
                    "Полное и абсолютное уничтожение всего,",
                    "что делает Балатро священным.",
                },
				text = {
					"{X:dark_edition,C:white}^#1#{} Множ., если рука",
					"содержит",
					"{C:attention}#2#",
				},
				unlock = {
					"Победите когда",
					"вашей последней рукой была",
					"{E:1,C:attention}#1#",
				},
			},
			j_cry_the = {
				name = "",
				text = {
					"{X:mult,C:white} X#1# {} Множ., если рука",
					"это {C:attention}#2#",
				},
				unlock = {
					"Победите когда",
					"вашей последней рукой было",
					"{E:1,C:attention}Пусто",
				},
			},
            j_cry_exposed = {
				name = "Обезличили",
				text = {
					"Перезапуск всех засчитаных карт {C:attention}без лица",
					"{C:attention}#1#{} дополнительных раз",
					"Все карты с {C:attention}лицом{} ослаблены",
				},
			},
            j_cry_mask = {
				name = "Маска",
				text = {
					"Перезапуск всех засчитаных карт {C:attention}с лицом",
					"{C:attention}#1#{} дополнительных раз",
					"Все карты {C:attention}без лица{} ослаблены",
				},
			},
            j_cry_tropical_smoothie = {
				name = "Тропический смузи",
				text = {
					"Продайте эту карту",
					"чтобы {C:attention}умножить{} значения",
					"джокеров во владении на {C:attention}X#1#{}",
				},
			},
            j_cry_necromancer = {
				name = "Некромант",
				text = {
					"Когда Джокер  {C:attention}продан{} по цене, превышающей {C:attention}#1#{},",
					"получите {C:attention}случайного{} джокера {C:attention}проданного{} в этой партии",
					"с {C:money}#1#{} ценой продажи",
				},
			},
            j_cry_oil_lamp = {
				name = "Масляная лампа",
				text = {
					"Увеличьте значения {C:attention}джокера{} справа",
					"на {C:attention}X#1#{} в конце раунда",
				},
			},
            j_cry_tax_fraud = {
				name = "Уклонение от налогов",
				text = {
					"Получите {C:attention}$#1#{} за каждого {C:attention}прокатного джокера",
					"в конце раунда",
				},
			},
            j_cry_pity_prize = {
				name = "Жалкий приз",
				text = {
					"При пропуске {C:attention}Бустерного набора{},",
					"Получите случайный {C:attention}тег{}",
				},
			},
			j_cry_pity_prize_modest = {
				name = "Жалкий приз",
				text = {
					"При пропуске {C:attention}Бустерного набора{},",
					"Получите случайный {C:attention}тег{}",
					"{C:red,E:2}Cамоуничтожается{}",
				},
			},
            j_cry_digitalhallucinations = {
				name = "Цифровые галлюцинации",
				text = {
					"При открытии {C:attention}Бустерного набора{},",
					"{C:green}#1# к #2#{} шанс на создание",
					"случайной {C:dark_edition}Негативной{} карты",
					"соответствующий его {C:attention}типу{}",
				},
			},
            j_cry_cotton_candy = {
				name = "Сахарная вата",
				text = {
					"При продаже, соседние",
					"{C:attention}джокеры{} становятся {C:dark_edition}Негативными{}",
				},
			},
            j_cry_wrapped = {
				name = "Завернутая конфета",
				text = {
					"Создаст случайного {C:attention}Еда-джокер{}",
					"после {C:attention}#1#{} раундов",
					"{C:red,E:2}Cамоуничтожается{}",
				},
			},
            j_cry_arsonist = {
				name = "Поджигатель",
				text = {
					"Если сыгранная рука",
					"содержит {C:attention}Фулл-хаус{},",
					"{C:red}уничтожает{} все карты",
					"после срабатывания",
				},
			},
            j_cry_zooble = {
				name = "Зубл",
				text = {
					"Если сыгранная рука",
					"{C:attention}не{} содержит {C:attention}Стрит{},",
					"этот джокер получает {C:mult}+#2#{} Множ. за каждое",
					"{C:attention}уникальное достоинство{} в засчитаной руке",
					"{C:inactive}(Сейчас {C:mult}+#1#{C:inactive} Множ.)",
				},
			},
            j_cry_chocolate_dice = {
				name = "Шоколадный кубик",
				text = {
					"Бросьте {C:green}десятигранный кубик{} когда",
					"{C:attention}Босс-блайнд{} повержен",
					"чтобы начать {C:cry_ascendant,E:1}событие",
					"{C:inactive}(Сейчас: #1#)",
				},
			},
            j_cry_kittyprinter = {
				name = "Кошачий принтер",
				text = {
					"{X:mult,C:white} X#1# {} Множ.",
					"Все {C:attention}теги{}",
					"становятся {C:attention}Кошачими тегами{}",
				},
			},
            j_cry_lebaron_james = {
				name = "ЛеБарон Джеймс",
				text = {
					"Сыгранные и засчитанные {C:attention}Короли{} дают",
					"{C:attention}+#1#{} к размеру руки до конца раунда",
					"и срабатыванию {C:attention}еффектов{} в руке",
					"{C:inactive}(Сейчас {}{C:attention}+#2#{}{C:inactive})",
				},
			},
            j_cry_clicked_cookie = {
				name = "Нажатое печенье",
				text = {
					"{C:chips}+#1#{} Фишек",
					"{C:chips}-#2#{} Фишек при",
					"вашем {C:attention}нажатии",
				},
			},
            j_cry_spectrogram = {
				name = "Спектрограмма",
				text = {
					"{C:attention}Перезапускает{} самого правого Джокера",
                    "один раз за каждую засчитанную {C:attention}Эхо-карту",
				},
			},
            j_cry_trick_or_treat = {
				name = "Сладость или гадость",
				text = {
					"При {C:attention}продаже{}:",
					"{C:green}#1# к #2#{} шанс на создание {C:attention}#3#{} {C:cry_candy}Конфет",
					"Иначе, создаст {X:cry_cursed,C:white}Проклятого{} джокера",
					"{C:inactive}(Может переполнить количество джокеров)",
				},
			},
            j_cry_huntingseason = {
				name = "Сезон охоты",
				text = {
					"Если в сыгранной руке ровно {C:attention}3{} карты,",
					"{C:red}уничтожает{} {C:attention}центральную{} карту после подсчета очков",
				},
			},
            j_cry_clockwork = {
				name = "Заводной джокер",
				text = {
					"Перезапускает удерживаемые стальные карты каждые {C:attention}#9#{} {C:inactive}(#1#){} руки",
					"Этот джокер получает {X:mult,C:white}X#6#{} Множ. {C:inactive}(X#5#){} каждые {C:attention}#10#{} {C:inactive}(#2#){} руки",
					"Превращяет первую сыгранную карту в стальную каждые {C:attention}#11#{} {C:inactive}(#3#){} рук",
					"Удерживаемые стальные карты дают + {X:mult,C:white}X#8#{} Множ. {C:inactive}(X#7#){} каждые {C:attention}#12#{} {C:inactive}(#4#){} рук",
				},
			},
            j_cry_candy_basket = {
				name = "Корзинка конфет",
				text = {
					"Продайте эту карту, чтобы создать {C:attention}#1#{} {C:cry_candy}Конфет",
					"{C:attention}+#2#{} {C:cry_candy}Конфет{} каждие {C:attention}#3#{} победы над блайндом",
					"{C:attention}+#3#{} {C:cry_candy}Конфет{} когда {C:attention}Босс-блайнд{} повержен",
				},
			},
            j_cry_blacklist = {
				name = "Черный список",
				text = {
					"Если {C:attention}#1#{} находится в руке или разыграна,",
					"устанавливает {C:chips}Фишки{} и {C:mult}Множ.{} на 0",
					"{C:red,E:2}самоуничтожается{} если {C:attention}#1#{} нет в колоде",
					"{C:inactive,s:0.8}Достоинство не меняется",
				},
			},
            j_cry_rotten_egg = {
				name = "Гнилое яйцо",
				text = {
					"После получения установливает стоимость продажи",
					"всех текущих и будущих джокеров на {C:attention}$#1#{}",
					"Уменьшает стоимость продажи всех {C:attention}джокеров{} на {C:attention}$#2#{}",
					"В конце раунда, после получения {C:attention}$#3#{} {C:inactive}[#4#]{}",
					"от продажи {C:attention}джокеров{}, {C:red}Самоуничтожается{}",
				},
			},
            j_cry_highfive = {
				name = "Дай пять",
				text = {
					"Если наивысшое {C:attention}засчитанное достоинство{}",
					"это {C:attention}5{}, преобразовывает {C:attention}все{} засчитанные карты",
					"в {C:attention}5{}",
					"{s:0.8,C:inactive}Тузы считаются 1",
				},
			},
            j_cry_familiar_currency = {
				name = "Знакомая валюта",
				text = {
					"Создаст {C:attention}Мем джокера{}",
					"в конце раунда",
					"за {C:money}$#1#{} {C:inactive}(если возможно)",
					"{C:inactive}(Должно быть место)",
				},
			},
            j_cry_sock_and_sock = {
				name = "Носок и носок",
				text = {
					"Перезапускает все сыгранные",
					"{C:attention}Абстрактные{} карты {C:attention}#1#{} раз",
				},
			},
            j_cry_candy_dagger = {
				name = "Конфетный кинжал",
				text = {
					"При выборе {C:attention}Блайнда{},",
					"уничтожает джокера справа",
					"чтобы создать {C:cry_candy}Конфету{}",
				},
			},
            j_cry_candy_cane = {
				name = "Леденец",
				text = {
					"В следующих {C:attention}#1#{} раундах,",
					"игральные карты дают {C:money}$#2#",
					"при {C:attention}повторном срабатывании",
				},
			},
            j_cry_brokenhome = {
                name = "Разрушенный дом",
                text = {
                    "{X:mult,C:white} X#1# {} Множ.",
                    "{C:green}#2# к #3#{} шанс что",
                    "эта карта будет уничтожена",
                    "в конце раунда",
                },
            },
            j_cry_candy_buttons = {
                name = "Конфетные пуговички",
                text = {
                    "Следующие {C:attention}#1#{} перебросы",
                    "стоят {C:money}$1{}",
                },
            },
            j_cry_yarnball = {
                name = "Клубок шерсти",
                text = {
                    "Добавляет уровень наивысшего {C:attention}Кошачьего тега{}",
                    "ко всем {C:green}указанным вероятностям",
                },
            },
            j_cry_pizza = {
                name = "Пицца",
                text = {
                    "После {C:attention}#1#{} {C:inactive}[#2#]{} раундов",
                    "продайте этого Джокера чтобы создать",
                    "{C:attention}#3#{} Кусков пиццы",
                },
            },
            j_cry_pizza_slice = {
                name = "Кусок пиццы",
                text = {
                    "Этот Джокер получает {X:mult,C:white}X#1#{} Множ.",
                    "когда {C:attention}Кусок пиццы{} продан",
                    "{C:inactive}(Сейчас{} {X:mult,C:white}X#2#{}{C:inactive} Множ.){}",
                },
            },
            j_cry_jawbreaker = {
                name = "Зубодробилка",
                text = {
                    "При победе над {C:attention}Босс-блайндом{},",
                    "{C:attention}удваивает{} значения соседних Джокеров",
                    "{E:2,C:red}самоуничтожается{}",
                },
            },
            j_cry_paved_joker = {
                name = "Мощёный Джокер",
                text = {
                    "Каменные карты могут заполнять",
                    "пробелы в {C:attention}#1#{} в",
                    "{C:attention}Стритах{} и {C:attention}Флешах{}",
                },
            },
            j_cry_mellowcreme = {
                name = "Нежный крем",
                text = {
                    "Продай эту карту чтобы {C:attention}умножить",
                    "цену продажи всех",
                    "{C:attention}расходников{} на {C:attention}X#1#",
                },
            },
            j_cry_brittle = {
                name = "Хрупкая конфета",
                text = {
                    "Следующие {C:attention}#1#{} рук,",
                    "добавляет {C:attention}Каменный{}, {C:attention}Золотой{} или {C:attention}Стальной{} к",
                    "самой правой засчитанной карте",
                },
            },
            j_cry_fading_joker = {
                name = "Угасающий Джокер",
                text = {
                    "Этот Джокер получает",
                    "{X:mult,C:white}X#1#{} Множ. когда",
                    "{C:attention}портящаяся{} карта ослаблена",
                    "{C:inactive}(Сейчас{} {X:mult,C:white}X#2#{} {C:inactive}Множ.){}",
                },
            },
            j_cry_poor_joker = {
                name = "Бедный Джокер",
                text = {
                    "Этот Джокер получает",
                    "{C:mult}+#1#{} Множ. когда",
                    "{C:attention}прокатная{} карта забирает деньги",
                    "{C:inactive}(Сейчас{} {C:mult}+#2#{} {C:inactive}Множ.){}",
                },
            },
            j_cry_monopoly_money = {
                name = "Монопольные деньги",
                text = {
                    "{C:green}#1# к #2#{} шанс",
                    "{C:attention}уничтожить{} купленные предметы",
                    "При продаже деньги уменьшаются вдвое",
                },
            },
            j_cry_broken_sync_catalyst = {
                name = "Сломанный катализатор синхронизации",
                text = {
                    "Уравнивает {C:attention}#1#%{} {C:chips}Фишек{} и {C:attention}#1#%{} {C:mult}Множ.{}",
                    "{C:inactive,s:0.8}Я уже видел эту штуку раньше...",
                    "{C:inactive,s:0.8}...видала лучшие времена.",
                },
            },
            j_cry_thalia = {
                name = "Талия и Мельпомем",
                text = {
                    "{C:white,X:mult}X#1#{} Множ. за каждую",
                    "пару уникальных редкостей",
                    "{C:inactive}(Сейчас {C:white,X:mult}X#2#{C:inactive}){}",
                },
            },
            j_cry_candy_sticks = {
                name = "Конфетная палочка",
                text = {
                    "Эффект следующего босс-блайнда не активен",
                    "пока не сыграно {C:attention}#1#{} рук",
                },
            },
            j_cry_keychange = {
				name = "Ключевые изменения",
				text = {
					"Получает {C:white,X:mult}X#1#{} если {C:attention}покерная рука{}",
                    "не была сыграна в этом раунде",
                    "Сбрасывается в {C:attention}конце раунда{}",
                    "{C:inactive}(Сейчас {C:white,X:mult}X#2#{C:inactive{})",
				},
			},
            j_cry_fleshpanopticon = {
				name = "Паноптикум из плоти",
				text = {
                    "{C:red}X#1#{} к размеру {C:attention}Босс-блайнда{}",
                    "При победе над {C:attention}Босс-блайндом{},",
                    "{C:red}самоуничтожается{} и создаёт",
                    "{C:dark_edition}Негативные{} {C:spectral}Врата{}",
                    '{C:inactive,s:0.8}"Эта тюрьма... чтобы удержать... меня?"',
                },
			},
            j_cry_wonka_bar = {
				name = "Плитка Вонки",
				text = {
					"Продайте эту карту чтобы",
                    "навсегда получить {C:attention}+#1#{}",
                    "к лимиту выбора карт",
				},
			},
            j_cry_buttercup = {
				name = "Арахисовая чашечка",
				text = {
					"Может сохранить {C:attention}#1#{} предмет из магазина",
                    "При продаже: добавляет хранимый предмет",
                    "в следующий магазин",
				},
			},
            j_cry_scrabble = {
				name = "Фишка Скрэббла",
				text = {
					"{C:green}#1# к #2#{} шанс создать",
					"{C:dark_edition}Весёлого {C:green}Необычного{} Джокера",
					"когда сыграна рука",
				},
			},
            j_cry_sacrifice = {
				name = "Жертва",
				text = {
					"Создаёт {C:green}Необычного{} Джокера",
					"и 3 {C:attention}Весёлых Джокера{} когда",
					"{C:spectral}Спектральная{} карта использована",
					"{C:red}Работает один раз за раунд{}",
					"{C:inactive}#1#{}",
				},
			},
            j_cry_doodlem = {
                name = "Каракули М",
                text = {
                    "Создаёт 2 {C:dark_edition}Негативных{} {C:attention}расходника",
                    "при выборе {C:attention}Блайнда",
                    "Создаёт ещё 1 {C:attention}расходник",
                    "за каждого {C:attention}Весёлого джокера",
                },
            },
            ["j_cry_Double Scale"] = {
                name = "Двойное масштабирование",
                text = {
                    "Растущие {C:attention}джокеры{}",
                    "растут {C:attention}квадратично",
                    "{C:inactive,s:0.8}(прим. +1, +3, +6, +10)",
                    "{C:inactive,s:0.8}(растёт на +1, +2, +3)",
                },
            },
            j_cry_rnjoker = {
				name = "РНДжокер",
				text = {
					"Случайные способности каждое {C:attention}Анте{}",
				},
                unlock = {
					"{C:green}1 к 20{} шанс",
					"разблокировать эту карту",
					"при {C:attention}Поражении",
				},
			},
            j_cry_dropshot = {
                name = "Дропшот",
                text = {
                    "Этот джокер получает {X:mult,C:white} X#1# {} Множ. за",
                    "каждую сыгранную, {C:attention}не подсчитанную{} {V:1}#2#{} карту,",
                    "масть меняется каждый раунд",
                    "{C:inactive}(Сейчас {X:mult,C:white} X#3# {C:inactive} Множ.)",
                },
            },
            j_cry_sapling = {
				name = "Росток",
				text = {
					"После засчитивания {C:attention}#2#{} {C:inactive}[#1#]{} улучшенных",
					"карт, продайте эту карту, чтобы",
					"создать {V:1}Эпического{} {C:attention}Джокера{}",
				},
			},
            j_cry_soccer = {
				name = "Один за всех",
				text = {
					"{C:attention}+#1#{} слот джокера",
					"{C:attention}+#1#{} слот бустерного набора",
					"{C:attention}+#1#{} размер руки",
					"{C:attention}+#1#{} слот расходника",
					"{C:attention}+#1#{} карта в магазине",
				},
                unlock = {
					"Победите используя",
					"только {C:attention}Старшую карту",
				},
			},
            j_cry_duplicare = {
                name = "Duplicare",
                text = {
                    "Каждый {C:attention}Джокер{} даёт",
                    "{X:dark_edition,C:white}^#1#{} Множ.",
                },
            },
            j_cry_effarcire = {
                name = "Effarcire",
                text = {
                    "Вытаскивает {C:green}всю колоду{} в руку",
                    "при выборе {C:attention}Блайнда",
                    '{C:inactive,s:0.8}"Если ты не можешь справиться со мной на 1x,',
                    '{C:inactive,s:0.8}ты не заслуживаешь меня на 2x"',
                },
            },
            j_cry_energia = {
                name = "Energia",
                text = {
                    "Когда получен {C:attention}Тег{},",
                    "создаёт {C:attention}#1#{} копии",
                    "и {C:attention}увеличивает{} количество",
                    "копий на {C:attention}#2#",
                },
            },
            j_cry_equilib = {
                name = "Туз Равновесия",
                text = {
                    "Джокеры появляются по",
                    "порядку из {C:attention}Коллекции{}",
                    "Создаёт {C:attention}#1#{} {C:dark_edition}Негативных{} джокера(ов)",
                    "когда рука сыграна",
                    "{C:cry_exotic,s:0.8}Экзотические {C:inactive,s:0.8}и выше джокеры не появляются",
                    "{s:0.8}Последний созданный джокер: {C:attention,s:0.8}#2#",
                },
            },
            j_cry_error = { name = "{C:red}ERR{}{C:dark_edition}O{}{C:red}R{}", text = { "" } },
            j_cry_exponent = {
                name = "Показатель",
                text = {
                    "Этот джокер получает {X:dark_edition,C:white}^#1#{} Множ.",
                    "когда срабатывает {X:red,C:white} XМнож.{}",
                    "{C:inactive}(Сейчас {X:dark_edition,C:white} ^#2# {C:inactive} Множ.)",
                },
            },
            j_cry_facile = {
                name = "Facile",
                text = {
                    "{X:dark_edition,C:white}^#1#{} Множ., если",
                    "сыгранные карты засчитаны",
                    "{C:attention}#2#{} раз или меньше",
                },
            },
            j_cry_eternalflame2 = {
				name = "Вечный огонь",
				text = {
					"Этот джокер получает {X:mult,C:white} X#1# {} Множ.",
					"за каждую {C:attention}проданную{} карту",
					"{C:inactive}(Сейчас {X:mult,C:white} X#2# {C:inactive} Множ.)",
				},
			},
            j_cry_fractal = {
                name = "Фрактальные пальцы",
                text = { "{C:attention}+#1#{} лимит выбора карт" },
            },
            j_cry_seal_the_deal = {
				name = "Запечатать сделку",
				text = {
					"Добавить {C:attention}случайную печать{} каждой карте,",
					"засчитанной в {C:attention}последней руке{} раунда",
				},
			},
            j_cry_flip_side = {
                name = "На обратной стороне",
                text = {
                    "{C:dark_edition}Двухсторонние{} джокеры используют",
                    "обратную сторону для эффектов",
                    "{C:attention}Перезапустить{} всех {C:dark_edition}Двухсторонних{} Джокеров",
                },
            },
            j_cry_foodm = {
                name = "Фастфуд М",
                text = {
                    "{C:mult}+#1#{} Множ.",
                    "{C:red,E:2}самоуничтожается{} через {C:attention}#2#{} раунда",
                    "Увеличивается на {C:attention}#3#{} раунд когда",
                    "{C:attention}Весёлый Джокер{} {C:attention}продан{}",
                    "{C:inactive,s:0.8}2 McDoubles, 2 McChickens{}",
                    "{C:inactive,s:0.8}Картошка фри, 20 штук & Торт{}",
                },
            },
            j_cry_fspinner = {
                name = "Спиннер",
                text = {
                    "Этот джокер получает {C:chips}+#2#{} Фишек",
                    "если рука {C:attention}не{}",
                    "наиболее сыгранная {C:attention}покерная рука{}",
                    "{C:inactive}(Сейчас {C:chips}+#1#{C:inactive} Фишек)",
                },
            },
            j_cry_gardenfork = {
                name = "Сад расходящихся троп",
                text = {
                    "Получите {C:money}$#1#{}, если {C:attention}рука",
                    "содержит {C:attention}Туза{} и {C:attention}7{}",
                },
            },
            j_cry_gemino = {
                name = "Gemini",
                text = {
                    "{C:attention}Удвоить{} все значения",
                    "крайнего левого {C:attention}Джокера",
                    "в конце раунда",
                },
            },
            j_cry_goldjoker = {
                name = "Золотой джокер",
                text = {
                    "Получите {C:money}#1#%{} от всех",
                    "денег в конце раунда",
                    "Выплата растёт на {C:money}#2#%{}",
                    "когда сыгранная {C:attention}Золотая{}",
                    "карта засчитана",
                },
            },
            j_cry_googol_play = {
                name = "Карта Googol Play",
                text = {
                    "{C:green}#1# из #2#{} шанс на",
                    "{X:red,C:white} X#3# {} Множ.",
                },
                unlock = {
					"Наберите {C:attention}1.0e100{} фишек",
					"за одну руку",
				},
            },
            j_cry_happy = {
                name = ":D",
                text = {
                    "Создать случайного {C:attention}Джокера",
                    "в конце раунда",
                    "Продайте эту карту,",
                    "чтобы создать случайного {C:attention}Джокера",
                    "{C:inactive}(Должно быть место)",
                },
            },
            j_cry_happyhouse = {
                name = "Счастливый дом",
                text = {
                    "{X:dark_edition,C:white}^#1#{} Множ. только после",
                    "{C:attention}114{} сыгранных рук{}",
                    "{C:inactive}(Сейчас #2#/114){}",
                    "{C:inactive,s:0.8}Нет места лучше дома!{}",
                },
            },
            j_cry_hunger = {
                name = "Расходу-емое",
                text = {
                    "Получите {C:money}$#1#{} при",
                    "использовании {C:attention}расходника{}",
                },
            },
            j_cry_iterum = {
                name = "Iterum",
                text = {
                    "Перезапустить все сыгранные карты",
                    "{C:attention}#2#{} раз(а),",
                    "каждая карта даёт",
                    "{X:mult,C:white} X#1# {} Множ. при засчитывании",
                },
            },
            j_cry_jimball = {
                name = "Джимбол",
                text = {
                    "Этот джокер получает {X:mult,C:white} X#1# {} множ.",
                    "за каждую {C:attention}последовательную{} сыгранную руку",
                    "пока играете своей",
                    "наиболее часто играемой {C:attention}покерной рукой",
                    "{C:inactive}(Сейчас {X:mult,C:white} X#2# {C:inactive} Множ.)",
                },
                unlock = {
					"Выграйте",
					"играя только",
					" {C:attention}одним типом{}",
					"{C:attention}покерной руки",
				},
            },
            j_cry_jollysus = {
                name = "Веселый джокер?",
                text = {
                    "Создаёт {C:dark_edition}Весёлого{} Джокера",
                    "когда Джокер {C:attention}продан{}",
                    "{C:red}Работает один раз за раунд{}",
                    "{C:inactive}#1#{}",
                    "{C:inactive,s:0.8}Выглядит легально...{}",
                },
            },
            j_cry_kidnap = {
                name = "Похищение",
                text = {
                    "Получайте {C:money}$#2#{} в конце раунда",
                    "Выплата увеличивается на {C:money}$#1#{}",
                    "когда {C:attention}Тип множ.{} или",
                    "{C:attention}Тип фишек{} джокер продан",
                },
            },
            j_cry_krustytheclown = {
                name = "Красти-клоун",
                text = {
                    "Этот джокер получает",
                    "{X:mult,C:white} X#1# {} Множ. когда",
                    "каждая {C:attention}карта{} засчитана",
                    "{C:inactive}(Сейчас {X:mult,C:white} X#2# {C:inactive} Множ.)",
                },
            },
            j_cry_kscope = {
                name = "Калейдоскоп",
                text = {
                    "Добавляет {C:dark_edition}Полихром{} к",
                    "случайному {C:attention}джокеру{} когда",
                    "{C:attention}блайнд босс{} побежден",
                },
            },
            j_cry_lightupthenight = {
                name = "Зажги ночь",
                text = {
                    "Каждая сыгранная {C:attention}7{} или {C:attention}2{}",
                    "дает {X:mult,C:white}X#1#{} множ. когда подсчитана",
                },
            },
            j_cry_longboi = {
                name = "Монстр",
                text = {
                    "Дает будущим копиям",
                    "этого джокера {X:mult,C:white}X#1#{} множ.",
                    "в конце раунда",
                    "{C:inactive}(Сейчас {X:mult,C:white}X#2#{C:inactive} множ.){}",
                },
            },
            j_cry_loopy = {
                name = "Петля",
                text = {
                    "{C:attention}Перезапустить{} всех Джокеров",
                    "раз за каждого {C:attention}Весёлого{}",
                    "{C:attention}Джокера{}, проданного в этом раунде",
                    "{C:inactive}(Сейчас{}{C:attention:} #1#{}{C:inactive} перезапуск(ов)){}",
                    "{C:inactive,s:0.8}Места не хватило...{}",
                },
            },
            j_cry_lucky_joker = {
                name = "Счастливый джокер",
                text = {
                    "Получите {C:money}$#1#{} каждый раз когда",
                    "{C:attention}Счастливая{} карта {C:green}успешно{}",
                    "срабатывает",
                },
            },
            j_cry_luigi = {
                name = "Луиджи",
                text = { "Все джокеры дают", "{X:chips,C:white} X#1# {} фишек" },
            },
            j_cry_m = {
                name = "м",
                text = {
                    "Этот джокер получает {X:mult,C:white} X#1# {} множ.",
                    "когда {C:attention}Веселый Джокер{} продан",
                    "{C:inactive}(Сейчас {X:mult,C:white} X#2# {C:inactive} множ.)",
                },
            },
            j_cry_M = {
                name = "М",
                text = {
                    "Создает {C:dark_edition}Негативного{}",
                    "{C:attention}Веселого Джокера{} при",
                    "выборе {C:attention}блайнда{}",
                },
            },
            j_cry_macabre = {
                name = "Жуткий джокер",
                text = {
                    "При выборе {C:attention}Блайнда{},",
                    "уничтожает каждого {C:attention}Джокера{} кроме",
                    "{C:legendary}М-Джокеров{} и {C:attention}Весёлых Джокеров{}",
                    "и создаёт 1 {C:attention}Весёлого Джокера{}",
                    "за каждую уничтоженную карту",
                },
            },
            j_cry_magnet = {
                name = "Магнит на холодильник",
                text = {
                    "Получайте {C:money}$#1#{} в конце раунда",
                    "Дает {X:money,C:white} X#2# {} если",
                    "у вас {C:attention}#3#{} или меньше {C:attention}джокеров{}",
                },
            },
            j_cry_mario = {
                name = "Марио",
                text = {
                    "Перезапустить всех Джокеров",
                    "{C:attention}#1#{} дополнительный(ых) раз(а)",
                },
            },
            j_cry_maximized = {
                name = "Максимизация",
                text = {
                    "Все {C:attention}картинки{}",
                    "считаются {C:attention}Королями{},",
                    "все {C:attention}числовые{} карты",
                    "считаются {C:attention}10-ками{}",
                },
            },
            j_cry_maze = {
                name = "Лабиринт",
                text = {
                    "Все руки считаются",
                    "{C:attention}первыми руками{} каждого раунда,",
                    "все сбросы считаются",
                    "{C:attention}первыми сбросами{} каждого раунда",
                },
            },
            j_cry_megg = {
                name = "Мегг",
                text = {
                    "Продайте эту карту, чтобы создать",
                    "{C:attention}#2#{} Весёлых #3#, растёт",
                    "на {C:attention}#1#{} в конце раунда",
                },
            },
            j_cry_membershipcard = {
                name = "Членский билет",
                text = {
                    "{X:mult,C:white}X#1#{} Множ. за каждого участника",
                    "в {C:attention}Cryptid Discord{}",
                    "{C:inactive}(Сейчас {X:mult,C:white}X#2#{C:inactive} Множ.)",
                    "{C:blue,s:0.7}https://discord.gg/eUf9Ur6RyB{}",
                },
            },
            j_cry_membershipcardtwo = {
                name = "Старый членский билет",
                text = {
                    "{C:chips}+#1#{} Фишек за каждого участника",
                    "в {C:attention}Cryptid Discord{}",
                    "{C:inactive}(Сейчас {C:chips}+#2#{C:inactive} Фишек)",
                    "{C:blue,s:0.7}https://discord.gg/eUf9Ur6RyB{}",
                },
            },
            j_cry_meteor = {
                name = "Метеоритный дождь",
                text = { "{C:dark_edition}Фольговые{} карты", "дают {C:chips}+#1#{} фишек" },
            },
            j_cry_exoplanet = {
				name = "Экзопланета",
				text = {
					"{C:dark_edition}Голографические{} карты",
					"дают {C:mult}+#1#{} множ.",
				},
			},
            j_cry_mneon = {
                name = "Неоновая М",
                text = {
                    "Получите {C:money}$#2#{} в конце раунда",
                    "Выплата увеличивается на",
                    "{C:money}$#1#{} за каждого {C:attention}Весёлого Джокера{}",
                    "или {C:legendary}М Джокера в конце раунда",
                },
            },
            j_cry_mondrian = {
                name = "Мондриан",
                text = {
                    "Этот джокер получает {X:mult,C:white} X#1# {} множ.",
                    "если никаких {C:attention}сбросов{} не было",
                    "использовано в этом раунде",
                    "{C:inactive}(Сейчас {X:mult,C:white} X#2# {C:inactive} Множ.)",
                },
            },
            j_cry_monkey_dagger = {
                name = "Обезьяний кинжал",
                text = {
                    "При выборе {C:attention}Блайнда{},",
                    "уничтожить Джокера слева",
                    "и навсегда добавить {C:attention}десятикратную{}",
                    "его цену продажи к {C:chips}Фишкам{}",
                    "{C:inactive}(Сейчас {C:chips}+#1#{C:inactive} Фишек)",
                },
            },
            j_cry_morse = {
                name = "Код Морзе",
                text = {
                    "Получите {C:money}$#2#{} в конце раунда",
                    "Выплата увеличивается на {C:money}$#1#{} когда",
                    "карта с {C:attention}Выпуском{} продана",
                },
            },
            j_cry_mprime = {
                name = "Tredecim",
                text = {
                    "Создаёт {C:legendary}М Джокера{} в конце раунда",
                    "Каждый {C:attention}Весёлый Джокер{} или {C:legendary}М Джокер",
                    "даёт {X:dark_edition,C:white}^#1#{} Множ.",
                    "Увеличивает на {X:dark_edition,C:white}^#2#{}",
                    "когда {C:attention}Весёлый Джокер{} {C:attention}продан",
                    "{C:inactive,s:0.8}(Tredecim исключён)",
                },
            },
            j_cry_mstack = {
                name = "Стопка М",
                text = {
                    "Перезапустить все сыгранные карты",
                    "раз за каждого",
                    "{C:attention}#2#{} {C:inactive}[#3#]{} проданных {C:attention}Весёлых Джокеров",
                    "{C:inactive}(Сейчас{}{C:attention:} #1#{}{C:inactive} перезапуск(ов)){}",
                },
            },
            j_cry_multjoker = {
                name = "Множ. джокер",
                text = {
                    "{C:green}#1# из #2#{} шанс за каждую",
                    "сыгранную {C:attention}Множ.{} карту создать",
                    "{C:spectral}Криптид{} карту при засчитывании",
                    "{C:inactive}(Должно быть место)",
                },
            },
            j_cry_negative = {
                name = "Негативный джокер",
                text = { "{C:dark_edition}+#1#{}слотов для {C:attention}джокеров{}" },
            },
            j_cry_jtron = {
				name = "Джимбо-трон 9000",
				text = {
					"Этот Джокер получает {X:dark_edition,C:white} ^#1# {} Множ.",
					"за каждого стандартного {C:attention}джокера{}",
					"{C:inactive}(Сейчас {X:dark_edition,C:white}^#2#{C:inactive} Множ.)",
				},
			},
            j_cry_nice = {
                name = "Отлично",
                text = {
                    "{C:chips}+#1#{} Фишек, если рука",
                    "содержит {C:attention}6{} и {C:attention}9",
                    "{C:inactive,s:0.8}Отлично.{}",
                },
            },
            j_cry_Scalae = {
                name = "Scalae",
                text = {
                    "{C:attention}Масштабируемые{} Джокеры растут",
                    "как полином {C:attention}#1#{}-й степени",
                    "степень повышается на {C:attention}#2#{}",
                    "в конце раунда",
                    "{C:inactive,s:0.8}({C:attention,s:0.8}Scalae{C:inactive,s:0.8} исключён)",
                    "{C:inactive,s:0.8}(пр. +1, +#3#, +#4#, +#5#)",
                },
            },
            j_cry_exponentia = {
                name = "Exponentia",
                text = {
                    "Этот Джокер получает {X:dark_edition,C:white} ^#1# {} Множ.",
                    "когда срабатывает {X:red,C:white} XМнож. {}",
                    "{C:inactive}(Сейчас {X:dark_edition,C:white} ^#2# {C:inactive} Множ.)",
                },
            },
            j_cry_formidiulosus = {
                name = "Formidiulosus",
                text = {
                    "При получении {X:cry_cursed,C:white}Проклятого{} Джокера — уничтожить его",
                    "Создаёт {C:attention}#1#{} {C:dark_edition}Негативных {C:cry_candy}Конфет#<ок,у>1#{} в конце магазина",
                    "Получает {X:dark_edition,C:white}^#2#{} Множ. за каждую {C:cry_candy}Конфету{} в наличии",
                    "{C:inactive}(Сейчас {X:dark_edition,C:white}^#3#{C:inactive} Множ.)",
                },
            },
            j_cry_caeruleum = {
                name = "Caeruleum",
                text = {
                    "Соседние Джокеры изменяющие {C:chips}фишки{}",
                    "используют следующий по силе {C:attention}оператор{} при подсчёте",
                    "{C:inactive}(Максимум — возведение в степень)",
                },
            },
            j_cry_spaceglobe = {
				name = "Небесный шар",
				text = {
					"Этот Джокер получает {X:chips,C:white}X#2#{} фишек",
					"если {C:attention}покерная рука{} это {C:attention}#3#{},",
					"Рука меняется после увеличения{}",
					"{C:inactive}(Сейчас{} {X:chips,C:white}X#1#{} {C:inactive}фишек){}",
				},
			},
            j_cry_night = {
                name = "Ночь",
                text = {
                    "{X:dark_edition,C:white}^#1#{} множ. в последней руке раунда",
                    "{E:2,C:red}самоуничтожается{} в последней руке раунда",
                },
            },
            j_cry_nosound = {
                name = "Без звука, без памяти",
                text = {
                    "Перезапустить каждую сыгранную {C:attention}7{}",
                    "{C:attention:}#1#{} дополнительный(ых) раз(а)",
                },
            },
            j_cry_notebook = {
                name = "Блокнот",
                text = {
                    "{C:green} #1# к #2#{} шанс получить {C:dark_edition}+1{} слот",
                    "джокера за каждый {C:attention}переброс{} в магазине",
                    "{C:green}Всегда срабатывает{}, если есть",
                    "{C:attention}#5#{} или больше {C:attention}Весёлых Джокеров{}",
                    "{C:red}Работает один раз за раунд{}",
                    "{C:inactive}(Сейчас {C:dark_edition}+#3#{}{C:inactive} и #4#){}",
                },
            },
            j_cry_reverse = {
				name = "Карта обратного хода",
				text = {
					"Заполнить все пустые ячейки {C:inactive}(Макс. 100){}",
					"{C:dark_edition}Голографическими{} {C:attention}Весёлыми Джокерами{} если",
					"{C:attention}сброшенная рука{} это {C:attention}#1#{}",
					"{C:red,E:2}самоуничтожается{}",
					"{C:inactive,s:0.8}Ультимативный камбэк{}",
				},
			},
            j_cry_smallestm = {
				name = "Малыш",
				text = {
					"Создаст {C:cry_jolly}Тег двойного М",
					"если {C:attention}покерная рука{}",
					"это {C:attention}#1#{}",
					"{C:inactive,s:0.8}итак, в общем, я очень мелкий.",
				},
			},
            j_cry_demicolon = {
				name = "Демиколон",
				text = {
					"{C:attention}Принудительно активирует{} джокера",
					"справа",
				},
			},
			j_cry_starfruit = {
				name = "Карамбола",
				text = {
					"{X:dark_edition,C:white}^#1#{} Множ.,",
                    "теряет {X:dark_edition,C:white}^#2#{} Множ. за каждый",
                    "{C:attention}переброс{} в магазине",
				},
			},
			j_cry_sundial = {
				name = "Проект Солнечные часы",
                text = {
                    "После розыгрыша #1# рук, {C:attention}продайте этого Джокера",
                    "чтобы уменьшить размер блайнда на #2# процентов",
                    "{C:red,E:1}#3#",
                },
			},
            j_cry_copypaste = {
				name = "Копировать/Вставить",
				text = {
					"{C:green}#1# к #2#{} шанс копировать",
					"использованную {C:cry_code}Карту кода{}",
					"{C:red}Работает один раз за раунд{}",
					"{C:inactive}(Должно быть место)",
				},
			},
            j_cry_copypaste_modest = {
				name = "Копировать/Вставить",
				text = {
					"{C:green}#1# к #2#{} шанс копировать",
					"использованную {C:cry_code}Карту кода{}",
					"{C:inactive}(Должно быть место)",
				},
			},
			j_cry_copypaste_madness = {
				name = "Копировать/Вставить",
				text = {
					"{C:green}#1# к #2#{} шанс копировать",
					"использованную {C:cry_code}Карту кода{}",
					"{C:inactive}(Должно быть место)",
				},
			},
            j_cry_number_blocks = {
                name = "Кубики с числами",
                text = {
                    "Получите {C:money}$#1#{} в конце раунда",
                    "Выплата растёт на {C:money}$#2#{}",
                    "за каждую {C:attention}#3#{} в руке,",
                    "ранг меняется каждый раунд",
                },
            },
            j_cry_oldblueprint = {
                name = "Старый чертеж",
                text = {
                    "Копирует способность {C:attention}джокера{} справа",
                    "{C:green}#1# к #2#{} шанс что",
                    "эта карта уничтожена",
                    "в конце раунда",
                },
            },
            j_cry_oldcandy = {
                name = "Ностальгическая конфета",
                text = {
                    "Продайте эту карту,",
                    "навсегда получить",
                    "{C:attention}+#1#{} размер руки",
                },
            },
            j_cry_oldinvisible = {
                name = "Ностальгический невидимый джокер",
                text = {
                    "{C:attention}Дублировать{} случайного",
                    "{C:attention}Джокера{} за каждые {C:attention}4",
                    "проданных джокеров",
                    "{s:0.8}Ностальгич. невидимый джокер исключён{}",
                    "{C:inactive}(Сейчас #1#/4){}",
                },
            },
            j_cry_panopticon = {
                name = "Паноптикум",
                text = {
                    "Все руки считаются",
                    "{C:attention}последними руками{} каждого раунда",
                },
            },
            j_cry_pickle = {
                name = "Огурчик",
                text = {
                    "Когда {C:attention}блайнд{} пропущен, создает",
                    "{C:attention}#1#{} тегов, уменьшается на",
                    "{C:red}#2#{} когда {C:attention}блайнд{} выбран",
                },
            },
            j_cry_pirate_dagger = {
                name = "Пиратский кинжал",
                text = {
                    "При выборе {C:attention}Блайнда{},",
                    "уничтожить Джокера справа",
                    "и получить {C:attention}четверть{}",
                    "его цены продажи как {X:chips,C:white} XФишек{}",
                    "{C:inactive}(Сейчас {X:chips,C:white} X#1# {C:inactive} Фишек)",
                },
            },
            j_cry_pot_of_jokes = {
                name = "Горшок шуток",
                text = {
                    "{C:attention}#1#{} размер руки,",
                    "увеличивается на {C:blue}#2#{} каждый раунд",
                },
                unlock = {
					"Увеличьте {C:attention}размер руки",
					"до {C:attention}12",
				},
            },
            j_cry_primus = {
                name = "Primus",
                text = {
                    "Этот джокер получает {X:dark_edition,C:white} ^#1# {} Множ.",
                    "если все карты в руке это",
                    "{C:attention}Тузы{}, {C:attention}2{}, {C:attention}3{}, {C:attention}5{} или {C:attention}7{}",
                    "{C:inactive}(Сейчас {X:dark_edition,C:white} ^#2# {C:inactive} Множ.)",
                },
            },
            j_cry_python = {
                name = "Питон",
                text = {
                    "Этот джокер получает",
                    "{X:mult,C:white} X#1# {} Множ. когда",
                    "использована {C:cry_code}Карта кода{}",
                    "{C:inactive}(Сейчас {X:mult,C:white} X#2# {C:inactive} Множ.)",
                },
            },
            j_cry_queens_gambit = {
                name = "Королевский гамбит",
                text = {
                    "Если {C:attention}покерная рука{} это",
                    "{C:attention}Роял Флэш{}, уничтожить засчитанную",
                    "{C:attention}Даму{} и создать",
                    "{C:dark_edition}Негативного {}{C:red}Редкого{}{C:attention} Джокера{}",
                },
            },
            j_cry_redbloon = {
                name = "Красный шар",
                text = {
                    "Получите {C:money}$#1#{} через {C:attention}#2#{} раунда#3#",
                    "{C:red,E:2}самоуничтожается{}",
                },
            },
            j_cry_redeo = {
                name = "Redeo",
                text = {
					"{C:attention}-#1#{} Анте когда",
					"{C:money}$#2#{} {C:inactive}($#3#){} потрачено",
					"{s:0.8}Требование растёт",
					"{C:attention,s:0.8}экспоненциально{s:0.8} за каждое использование",
					"{C:money,s:0.8}Следующее увеличение: {s:1,c:money}$#4#",
				},
            },
            j_cry_scalesword = {
                name = "Весовой меч",
                text = {
                    "Этот джокер получает {X:chips,C:white}X#2#{} Фишек",
                    "если {C:attention}покерная рука{} это {C:attention}#3#{},",
                    "Рука меняется после увеличения",
                    "{C:inactive}(Сейчас{} {X:chips,C:white}X#1#{} {C:inactive}Фишек){}",
                },
            },
            j_cry_speculo = {
                name = "Speculo",
                text = {
                    "Создаёт {C:dark_edition}Негативную{} копию",
                    "случайного {C:attention}Джокера",
                    "в конце {C:attention}магазина",
                    "{C:inactive,s:0.8}Не копирует других Speculo{}",
                },
            },
            j_cry_stardust = {
                name = "Звездная пыль",
                text = { "{C:dark_edition}Полихромные{} карты", "дают {X:mult,C:white}X#1#{} множ." },
            },
            j_cry_stella_mortis = {
                name = "Stella Mortis",
                text = {
                    "Этот джокер уничтожает",
                    "случайную {C:planet}Планетарную{} карту",
                    "и получает {X:dark_edition,C:white} ^#1# {} множ.",
                    "в конце {C:attention}магазина",
                    "{C:inactive}(Сейчас {X:dark_edition,C:white} ^#2# {C:inactive} Множ.)",
                },
            },
            j_cry_supercell = {
                name = "Supercell",
                text = {
                    "{C:chips}+#1#{} Фишек, {C:mult}+#1#{} Множ.,",
                    "{X:chips,C:white}X#2#{} Фишек, {X:mult,C:white}X#2#{} Множ.",
                    "Получите {C:money}$#3#{} в конце раунда",
                },
            },
            j_cry_sus = {
                name = "СУС",
                text = {
                    "В конце раунда, создаёт",
                    "копию случайной карты {C:attention}в руке{},",
                    "уничтожает все остальные",
                    "{C:attention,s:0.8}Короли{s:0.8} {C:hearts,s:0.8}Червей{s:0.8} приоритетны",
                },
            },
            j_cry_sync_catalyst = {
                name = "Катализатор синхронизации",
                text = {
                    "Уравнивает {C:chips}Фишки{} и {C:mult}Множ{}.",
                    "{C:inactive,s:0.8}Эй! Я уже видел это раньше!",
                },
            },
            j_cry_tenebris = {
                name = "Tenebris",
                text = {
                    "{C:dark_edition}+#1#{} слотов для {C:attention}джокеров{}",
                    "Получите {C:money}$#2#{} в конце раунда",
                },
            },
            j_cry_translucent = {
                name = "Полупрозрачный джокер",
                text = {
                    "Продайте эту карту, чтобы создать",
                    "копию {C:attention} с наклейкой банана",
                    "случайного {C:attention}Джокера",
                    "{s:0.8,C:inactive}(Копия обходит совместимость)",
                },
            },
            j_cry_triplet_rhythm = {
                name = "Ритм триплетов",
                text = {
                    "{X:mult,C:white} X#1# {} Множ., если рука",
                    "содержит {C:attention}ровно{} три {C:attention}тройки",
                },
            },
            j_cry_universum = {
                name = "Universum",
                text = {
                    "{C:attention}Покерные руки{} получают",
                    "{X:red,C:white} X#1# {} Множ. и {X:blue,C:white} X#1# {} Фишек",
                    "при повышении уровня",
                },
            },
            j_cry_unjust_dagger = {
                name = "Несправедливый кинжал",
                text = {
                    "При выборе {C:attention}Блайнда{},",
                    "уничтожить Джокера слева",
                    "и получить {C:attention}пятую часть{}",
                    "его цены продажи как {X:mult,C:white} XМнож.{}",
                    "{C:inactive}(Сейчас {X:mult,C:white} X#1# {C:inactive} Множ.)",
                },
            },
            j_cry_verisimile = {
                name = "Verisimile",
                text = {
                    "Когда любая вероятность",
                    "срабатывает {C:green}успешно{},",
                    "этот джокер получает {X:red,C:white}XМнож.{}",
                    "равное заявленным {C:attention}шансам",
                    "{C:inactive}(Сейчас {X:mult,C:white} X#1# {C:inactive} Множ.)",
                },
            },
            j_cry_virgo = {
                name = "Дева",
                text = {
                    "Этот джокер получает {C:money}$#1#{} цены продажи",
                    "если {C:attention}рука{} содержит {C:attention}#2#{}",
                    "Продайте эту карту, чтобы создать",
                    "{C:dark_edition}Полихромного{} {C:attention}Весёлого Джокера{} за",
                    "каждые {C:money}$4{} цены продажи {C:inactive}(мин. 1){}",
                },
            },
            j_cry_waluigi = {
                name = "Валуиджи",
                text = { "Все Джокеры дают", "{X:mult,C:white} X#1# {} Множ." },
            },
            j_cry_wario = {
                name = "Варио",
                text = { "Все Джокеры дают", "{C:money}$#1#{} при срабатывании" },
            },
            j_cry_wee_fib = {
                name = "Вибоначчи",
                text = {
                    "Этот джокер получает",
                    "{C:mult}+#2#{} Множ. за каждую сыгранную",
                    "{C:attention}Туза{}, {C:attention}2{}, {C:attention}3{}, {C:attention}5{} или {C:attention}8{}",
                    "при засчитывании",
                    "{C:inactive}(Сейчас {C:mult}+#1#{C:inactive} Множ.)",
                },
            },
            j_cry_weegaming = {
                name = "2D",
                text = {
                    "Перезапустить каждую сыгранную {C:attention}2{}",
                    "{C:attention:}#1#{} дополнительный(ых) раз(а)",
                    "{C:inactive,s:0.8}Wee Gaming?{}",
                },
            },
            j_cry_wheelhope = {
                name = "Колесо надежды",
                text = {
                    "Этот джокер получает",
                    "{X:mult,C:white} X#1# {} Множ. при неудаче",
                    "на {C:attention}Колесе Фортуны{}",
                    "{C:inactive}(Сейчас {X:mult,C:white} X#2# {C:inactive} Множ.)",
                },
            },
            j_cry_whip = {
                name = "КНУТ",
                text = {
                    "Этот джокер получает {X:mult,C:white} X#1# {} множ.",
                    "если {C:attention}сыгранная рука{} содержит",
                    "{C:attention}2{} и {C:attention}7{} разных мастей",
                    "{C:inactive}(Сейчас {X:mult,C:white} X#2# {C:inactive} Множ.)",
                },
            },
        },

        -- ── ПЛАНЕТЫ ─────────────────────────────────────────
        Planet = {
            -- Объекты с одинаковым шаблоном
            c_cry_asteroidbelt = { name = "Пояс астероидов", text = SPACE_OBJECT_TEXT },
            c_cry_void         = { name = "Вакуум",          text = SPACE_OBJECT_TEXT },
            c_cry_marsmoons    = { name = "Фобос и Деймос",  text = SPACE_OBJECT_TEXT },
            c_cry_nibiru       = { name = "Нибиру",          text = SPACE_OBJECT_TEXT },

			c_cry_universe = {
				name = Cryptid_config.family_mode and "Вселенная" or "Вся Грёбаная Вселенная",
				text = {
					"{S:0.8}({S:0.8,V:1}ур.#1#{S:0.8}){} Повышение уровня",
					"{C:attention}#2#{},",
					"{C:mult}+#3#{} Множ. и",
					"{C:chips}+#4#{} шт. фишек",
				},
			},
            c_cry_nstar = {
                name = "Нейтронная Звезда",
                text = {
                    "Улучшите случайную",
                    "покерную руку на",
                    "{C:attention}1{} уровень за каждую",
                    "{C:attention}Нейтронную Звезду{} использованную",
                    "в этом забеге",
                    "{C:inactive}(Сейчас{C:attention} #1#{C:inactive}){}",
                },
            },
            c_cry_planetlua = {
                name = "Планета.lua",
                text = {
                    "{C:green}#1# к #2#{} шанс",
                    "улучшить каждую",
                    "{C:legendary,E:1}покерную руку{}",
                    "на {C:attention}1{} уровень",
                },
            },
            c_cry_sunplanet = {
				name = "Сонце",
				text = {
					"{S:0.8}({S:0.8,V:1}ур.#1#{S:0.8}){}",
					"Повышение фактора вознесения",
					"{C:attention}Вознесённых{} рук на {X:gold,C:white}#2#{}",
					"{C:inactive}(Сейчас {X:gold,C:white}X#3#{C:inactive} {C:chips}Ф{}+{C:mult}M{C:inactive} Множ.",
					"{C:inactive}За {C:attention}1{C:inactive} силу Вознесения)",
				},
			},
            c_cry_perkele = {
				name = "Перкеле",
				text = {
					"({V:1}ур.#4#{})({V:2}ур.#5#{})({V:3}ур.#6#{})",
					"Повышение уровня",
					"{C:attention}#1#{},",
					"{C:attention}#2#{},",
					"и {C:attention}#3#{}",
					"{C:inactive}(Сейчас {X:gold,C:white}X#7#{C:inactive} {C:chips}Ф{}+{C:mult}M{C:inactive} Множ.",
					"{C:inactive}За {C:attention}1{C:inactive} силу Вознесения)",
				},
			},

            --Тройгые планеты с одинаковым шаблоном
            c_cry_Timantii = { name = "Рууту",    text = TRIO_PLANET_TEXT },
            c_cry_Klubi    = { name = "Ристи",    text = TRIO_PLANET_TEXT },
            c_cry_Lapio    = { name = "Пата",    text = TRIO_PLANET_TEXT },
            c_cry_Sydan    = { name = "Хертта",    text = TRIO_PLANET_TEXT },
            c_cry_Kaikki   = { name = "Каикки", text = TRIO_PLANET_TEXT },
            c_cry_voxel    = { name = "Воксель", text = TRIO_PLANET_TEXT },
        },

        -- ── РУКАВА ──────────────────────────────────────────
        Sleeve = {
			sleeve_cry_ccd_sleeve = {
				name = "CCD Рукав",
				text = {
					"Каждая карта это ещё и",
					"{C:attention}случайный{} расходник",
				},
			},
			sleeve_cry_conveyor_sleeve = {
				name = "Конвейерный рукав",
				text = {
					"Джокеров {C:attention}нельзя{} двигать",
					"в начале раунда,",
					"{C:attention}дублирует{} самого правого джокера",
					"и {C:attention}уничтожает{} самого левого джокера",
				},
			},
			sleeve_cry_critical_sleeve = {
				name = "Критический рукав",
				text = {
					"После каждой сыгранной руки,",
					"{C:green}#1# к #2#{} шанс для {X:dark_edition,C:white} ^2 {} Множ",
					"{C:green}#1# к #3#{} шанс для {X:dark_edition,C:white} ^0.5 {} Множ",
				},
			},
			sleeve_cry_encoded_sleeve = {
				name = "Закодированный рукав",
				text = {
					"Начинаете партию с {C:cry_code,T:j_cry_CodeJoker}Код Джокером{}",
					"и {C:cry_code,T:j_cry_copypaste}Копировать/Вставить{}",
					"Только {C:cry_code}Карты кода{} появляются в магазине",
				},
			},
			sleeve_cry_equilibrium_sleeve = {
				name = "Сбалансированный рукав",
				text = {
					"Все карты имеют",
					"{C:attention}одинаковый шанс{}",
					"Появления в магазинах,",
					"Начинаете партию с",
					"{C:attention,T:v_overstock_plus}Изобилие перебросов",
				},
			},
			sleeve_cry_infinite_sleeve = {
				name = "Безлимитный рукав",
				text = {
					"Вы можете выбрать{C:attention}любое",
					"количество карт",
					"{C:attention}+1{} размер руки",
				},
			},
			sleeve_cry_misprint_sleeve = {
				name = "Рукав с опечатками",
				text = {
					"Числа карт",
					"и покерных рук",
					"{C:attention}случайны",
				},
			},
			sleeve_cry_redeemed_sleeve = {
				name = "Погашенный рукав",
				text = {
					"Когда {C:attention}Ваучер{} куплен,",
					"получаешь {C:attention}все улучш. версии",
				},
			},
			sleeve_cry_wormhole_sleeve = {
				name = "Рукав червоточины",
				text = {
					"Начинаете с {C:cry_exotic}Экзотическим{C:attention} Джокером",
					"Джокеры в {C:attention}20X{} чаще",
					"появляются {C:dark_edition}Негативными",
					"{C:attention}-2{} Слота джокера",
				},
			},
		},

        -- ── СПЕКТРАЛЬНЫЕ КАРТЫ ───────────────────────────────
        Spectral = {
            c_cry_analog = {
                name = "Аналог",
                text = {
                    "Создаёт {C:attention}#1#{} копии",
                    "случайного {C:attention}Джокера{}, уничтожьте",
                    "всех других Джокеров, {C:attention}+#2#{} Анте",
                },
            },
            c_cry_gateway = {
                name = "Врата",
                text = {
                    "Создайте случайного",
                    "{C:cry_exotic,E:1}Экзотического{C:attention} джокера{}, уничтожьте",
                    "всех других джокеров",
                },
            },
            c_cry_hammerspace = {
                name = "Пространство молотка",
                text = {
                    "Применить случайные {C:attention}расходники",
                    "как если бы они были {C:dark_edition}Улучшениями",
                    "к картам в руке",
                },
            },
            c_cry_lock = {
                name = "Замок",
                text = {
                    "Уберите {C:red}все{} наклейки",
                    "со {C:red}всех{} джокеров,",
                    "затем добавьте {C:purple,E:1}Вечную наклейку{}",
                    "случайному {C:attention}джокеру{}",
                },
            },
            c_cry_pointer = {
                name = "POINTER://",
                text = {
                    "Создает карту",
                    "{C:cry_code}вашего выбора",
                    "{C:inactive,s:0.8}(исключая Экзотических джокеров)",
                },
            },
            c_cry_replica = {
                name = "Реплика",
                text = {
                    "Конвертирует все карты в руке",
                    "в {C:attention}случайную{} карту в вашей руке",
                },
            },
            c_cry_ritual = {
				name = "Ритуал",
				text = {
					"Примените {C:dark_edition}Негативный{}, {C:dark_edition}Мозаичный{},",
					"или {C:dark_edition}Астральный{} к {C:attention}#1#{}",
					"выбраной карте в руке",
				},
			},
            c_cry_adversary = {
				name = "Неприятель",
				text = {
					"{C:red}Все{} ваши {C:attention}джокеры{} становятся {C:dark_edition}Негативными{},",
					"{C:red}все{} {C:attention}джокеры{} в магазине стоят",
					"{C:red}в два раза дороже{} до конца забега",
				},
			},
            c_cry_chambered = {
				name = "Камерность",
				text = {
					"Создайте {C:attention}#1#{} {C:dark_edition}Негативные{}",
					"копии",
					"{C:attention}случайного{} расходуемого предмета",
					"во вашем владении",
					"{C:inactive,s:0.8}Не копирует Камерность{}",
				},
			},
            c_cry_conduit = {
				name = "Канал",
				text = {
					"Обменяйте {C:attention}выпуски{}",
					"{C:attention}2{} выбраных игральных карт или {C:attention}джокеров{}",
				},
			},
            c_cry_white_hole2 = {
                name = "Белая дыра",
                text = {
                    "{C:attention}Удалите{} все уровни рук,",
                    "повысьте {C:legendary,E:1}наиболее сыгранную{} покерную руку",
                    "на {C:attention}3{} за каждый убранный уровень",
                },
            },
            c_cry_source = {
                name = "Исходник",
                text = {
                    "Добавьте {C:cry_code}Зеленую печать{}",
                    "на {C:attention}#1#{} выбранную",
                    "карту в вашей руке",
                },
            },
            c_cry_summoning = {
                name = "Призыв",
                text = {
                    "Создайте случайного",
                    "{C:cry_epic}Эпического{} {C:joker}джокера{}, уничтожьте",
                    "одного случайного {C:joker}джокера{}",
                },
            },
            c_cry_trade = {
                name = "Обмен",
                text = {
                    "{C:attention}Потеряйте{} случайный ваучер,",
                    "получите {C:attention}2{} случайных ваучера",
                },
            },
            c_cry_typhoon = {
                name = "Тайфун",
                text = {
                    "Добавляет {C:cry_azure}Лазурную Печать{}",
                    "на {C:attention}#1#{} выбранную",
                    "карту в руке",
                },
            },
            c_cry_meld = {
                name = "Слияние",
                text = {
                    "Выберите {C:attention}Джокера{} или",
                    "{C:attention}игральную карту{}, чтобы",
                    "они стали {C:dark_edition}Двухсторонними",
                },
            },
            c_cry_vacuum = {
                name = "Вакуум",
                text = {
                    "Убирает {C:red}все {C:green}модификации",
                    "со {C:red}всех{} карт в руке,",
                    "Получите {C:money}$#1#{} за каждую убранную {C:green}модификацию",
                    "{C:inactive,s:0.7}(напр. Улучшения, Печати, Выпуски)",
                },
            },
        },

        -- ── СТАВКИ ──────────────────────────────────────────
        Stake = {
            stake_cry_pink     = { name = "Розовая ставка",    colour = "Розовая",    text = { "Требуемые очки растут", "быстрее с каждым {C:attention}Анте" } },
            stake_cry_brown    = { name = "Коричневая ставка", colour = "Коричневая", text = { "Все {C:attention}наклейки{} совместимы", "друг с другом" } },
            stake_cry_yellow   = { name = "Желтая ставка",     colour = "Желтая",     text = { "{C:attention}Наклейки{} могут появляться на", "всех покупаемых предметах" } },
            stake_cry_jade     = { name = "Нефритовая ставка", colour = "Нефрит",     text = { "Карты могут раздаваться {C:attention}рубашкой вверх" } },
            stake_cry_cyan     = { name = "Голубая ставка",    colour = "Голубая",    text = { "{C:green}Необычные{} и {C:red}Редкие{} джокеры", "появляются реже" } },
            stake_cry_gray     = { name = "Серая ставка",      colour = "Серая",      text = { "Стоимость каждого повторного броска увеличивается на {C:attention}$2{}" } },
            stake_cry_crimson  = { name = "Багровая ставка",   colour = "Багровая",   text = { "Ваучеры пополняются на {C:attention}чётных{} Анте" } },
            stake_cry_diamond  = { name = "Алмазная ставка",   colour = "Алмазная",   text = { "Нужно пройти Анте {C:attention}10{} для победы" } },
            stake_cry_amber    = { name = "Янтарная ставка",   colour = "Янтарная",   text = { "{C:attention}-1{} слот бустерного набора" } },
            stake_cry_bronze   = { name = "Бронзовая ставка",  colour = "Бронзовая",  text = { "Ваучеры на {C:attention}50%{} дороже" } },
            stake_cry_quartz   = { name = "Кварцевая ставка",  colour = "Кварцевая",  text = { "Джокеры могут быть {C:attention}Закреплены{}", "{s:0.8,C:inactive}(Остаётся прикреплённым к крайней левой позиции){}" } },
            stake_cry_ruby     = { name = "Рубиновая ставка",  colour = "Рубиновая",  text = { "{C:attention}Большие{} блайнды могут стать", "{C:attention}Босс{} блайндами" } },
            stake_cry_glass    = { name = "Стеклянная ставка", colour = "Стеклянная", text = { "Карты могут {C:attention}разбиться{} при подсчёте" } },
            stake_cry_sapphire = { name = "Сапфировая ставка", colour = "Сапфировая", text = { "Потерять {C:attention}25%{} текущих денег", "в конце Анте", "{s:0.8,C:inactive}(Максимум $10){}" } },
            stake_cry_emerald  = { name = "Изумрудная ставка", colour = "Изумрудная", text = { "Карты, паки и ваучеры", "могут быть {C:attention}рубашкой вверх", "{s:0.8,C:inactive}(Нельзя увидеть до покупки){}" } },
            stake_cry_platinum = { name = "Платиновая ставка", colour = "Платиновая", text = { "Малые блайнды {C:attention}убраны" } },
            stake_cry_twilight = { name = "Сумеречная ставка", colour = "Сумеречная", text = { "Карты могут быть {C:attention}Бананом", "{s:0.8,C:inactive}(1 из 10 шанс уничтожения каждый раунд){}" } },
            stake_cry_verdant  = { name = "Незрелая ставка",   colour = "Незрелая",   text = { "Требуемые очки растут", "быстрее с каждым {C:attention}Анте" } },
            stake_cry_ember    = { name = "Огненная ставка",   colour = "Огненная",   text = { "Все предметы не дают деньги при продаже" } },
            stake_cry_dawn     = { name = "Рассветная ставка", colour = "Рассветная", text = { "Таро и Призраки нацеливают {C:attention}на 1", "карту меньше", "{s:0.8,C:inactive}(Минимум 1){}" } },
            stake_cry_horizon  = { name = "Ставка горизонта",  colour = "Горизонт",   text = { "При выборе блайнда, добавить", "{C:attention}случайную карту{} в колоду" } },
            stake_cry_blossom  = { name = "Цветущая ставка",   colour = "Цветущая",   text = { "{C:attention}Финальные{} Босс-блайнды могут появляться", "в {C:attention}любом{} Анте" } },
            stake_cry_azure    = { name = "Лазурная ставка",   colour = "Лазурная",   text = { "Значения на джокерах уменьшены", "на {C:attention}20%{}" } },
            stake_cry_ascendant = { name = "Вознесённая ставка", colour = "Вознесённая", text = { "{C:attention}-1{} слот магазина" } },
        },

        -- ── ТЕГИ ────────────────────────────────────────────
        Tag = {
            -- Теги «базовый джокер → выпуск» (edition_tag)
            tag_cry_astral   = { name = "Астральный тег",   text = edition_tag("Астральным") },
            tag_cry_blur     = { name = "Размытый тег",     text = edition_tag("Размытым") },
            tag_cry_glass    = { name = "Хрупкий тег",      text = edition_tag("Хрупким") },
            tag_cry_glitched = { name = "Глючный тег",      text = edition_tag("Глючным") },
            tag_cry_gold     = { name = "Золотой тег",      text = edition_tag("Золотым") },
            tag_cry_m        = { name = "Весёлый тег",      text = edition_tag("Весёлым") },
            tag_cry_mosaic   = { name = "Мозаичный тег",    text = edition_tag("Мозаичным") },
            tag_cry_oversat  = { name = "Перенасыщенный тег", text = edition_tag("Перенасыщенным") },

            -- Теги-множители
            tag_cry_triple    = multiplier_tag("Тройной тег",    ""),
            tag_cry_quadruple = multiplier_tag("Четверной тег",  ""),
            tag_cry_quintuple = multiplier_tag("Пятерной тег",   ""),

            tag_cry_banana = {
                name = "Банановый тег",
                text = { "Создаёт {C:attention}#1#", "{C:inactive}(Должно быть место)" },
            },
            tag_cry_bettertop_up = {
                name = "Улучшенный тег пополнения",
                text = { "Создаёт до {C:attention}#1#", "{C:green}Необычных{} джокеров", "{C:inactive}(Должно быть место)" },
            },
            tag_cry_better_voucher = {
                name = "Тег золотого ваучера",
                text = { "Добавляет один Ваучер {C:attention}#1#{} уровня", "в следующий магазин" },
            },
            tag_cry_booster = {
                name = "Тег бустера",
                text = {
                    "Следующий {C:cry_code}Бустерный Пак{} имеет",
                    "{C:attention}вдвое{} больше карт и",
                    "{C:attention}вдвое{} больше выборов",
                },
            },
            tag_cry_bundle = {
                name = "Пакетный тег",
                text = {
                    "Создаёт {C:attention}Стандартный тег{}, {C:tarot}Тег очарования{},",
                    "{C:attention}Тег шута{} и {C:planet} тег метеора",
                },
            },
            tag_cry_cat = {
                name = "Кошачий тег",
                text = { "Мяу.", "{C:inactive}Уровень {C:dark_edition}#1#" },
            },
            tag_cry_console = {
                name = "Консольный тег",
                text = { "Даёт бесплатный", "{C:cry_code}Программный пак" },
            },
            tag_cry_double_m = {
                name = "Тег двойного М",
                text = { "В магазине есть", "{C:dark_edition}Весёлый {C:legendary}М джокер{}" },
            },
            tag_cry_empowered = {
                name = "Усиленный тег",
                text = {
                    "Даёт бесплатный {C:spectral}Призрачный пак",
                    "с {C:legendary,E:1}Душой{} и {C:cry_exotic,E:1}Вратами{}",
                },
            },
            tag_cry_epic = {
                name = "Эпический тег",
                text = { "В магазине есть уценённый", "{C:cry_epic}Эпический Джокер" },
            },
            tag_cry_gambler = {
                name = "Тег игрока",
                text = { "{C:green}#1# к #2#{} шанс создать", "Усиленный тег" },
            },
            tag_cry_gourmand = {
                name = "Гурманский тег",
                text = { "В магазине бесплатный", "{C:attention}Еда-джокер" },
            },
            tag_cry_loss = {
                name = "Потеря",
                text = { "Даёт бесплатный", "{C:cry_ascendant}Мемный пак" },
            },
            tag_cry_memory = {
                name = "Тег памяти",
                text = {
                    "Создаёт {C:attention}#1#{} копии",
                    "последнего использованного {C:attention}Тега",
                    "в этом забеге",
                    "{s:0.8,C:inactive}Копирующие теги исключены",
                    "{s:0.8,C:inactive}Сейчас: {s:0.8,C:attention}#2#",
                },
            },
            tag_cry_rework = {
                name = "Тег доработки",
                text = { "В магазине есть", "{C:dark_edition}#1# {C:cry_code}#2#" },
            },
            tag_cry_schematic = {
                name = "Схематический тег",
                text = { "В магазине есть", "{C:attention}Мозговой штурм" },
            },
            tag_cry_scope = {
                name = "Тег прицела",
                text = { "{C:attention}+#1# {C:blue}рук{} и", "{C:red}сбросов{} в следующем раунде" },
            },
            tag_cry_clone = {
                name = "Тег клонирования",
                text = { "Товары в магазине стоят в {C:attention}1.5", "раза дороже, получите {C:attention}копию", "следующей купленной карты" },
            },
            tag_cry_palette_cleanser = {
                name = "Очищающий тег",
                text = { "Убирает {C:attention}случайную", "наклейку со {C:attention}случайного", "джокера или игральной карты" },
            },
            tag_cry_lens = {
                name = "Тег линзы",
                text = { "Добавляет {C:dark_edition}Негативный", "к {C:attention}2 случайным", "расходникам" },
            },
        },

        -- ── ТАРО ────────────────────────────────────────────
        Tarot = {
            c_cry_automaton = {
                name = "Автоматон",
                text = {
                    "Создаёт до {C:attention}#1#",
                    "случайных {C:cry_code}карт кода",
                    "{C:inactive}(Должно быть место)",
                },
            },
            c_cry_eclipse = {
                name = "Затмение",
                text = { "Улучшает {C:attention}#1#{} выбранную карту", "в: {C:attention}Эхо-Карту" },
            },
            c_cry_theblessing = {
                name = "Благословение",
                text = {
                    "Создаёт {C:attention}1{}",
                    "случайный {C:attention}расходник",
                    "{C:inactive}(Должно быть место)",
                },
            },
			c_cry_seraph = {
				name = "Серафим",
				text = { "Улучшает {C:attention}2{} выбранные карты", "в: {C:attention}Световые Карты" },
			},
			c_cry_instability = {
				name = "Нестабильность",
				text = { "Улучшает {C:attention}#1#{} выбранную карту", "в: {C:attention}Абстрактную Карту" },
			},
        },

        -- ── ВАУЧЕРЫ ─────────────────────────────────────────
        Voucher = {
            v_cry_asteroglyph     = { name = "Астероглиф",                  text = { "Установить Анте на {C:attention}#1#{}" } },
            v_cry_blankcanvas     = { name = "Чистый холст",                text = { "{C:attention}+#1#{} размер руки" } },
            v_cry_rerollexchange  = { name = "Обмен перебросов",            text = { "Все переброски", "стоят {C:attention}$2" } },
            v_cry_fabric          = { name = "Универсальная ткань",         text = { "{C:dark_edition}+#1#{} слот(а) для джокеров" } },
            v_cry_massproduct     = { name = "Массовое производство",       text = { "Все карты и паки", "в магазине стоят {C:attention}$1" } },
            v_cry_quantum_computing = { name = "Квантовые вычисления",      text = { "{C:cry_code}Карты кода{} могут появляться", "с {C:dark_edition}Негативным{} выпуском" } },
            v_cry_double_vision   = { name = "Двойное зрение",              text = { "{C:dark_edition}Двухсторонние{} карты появляются", "в {C:attention}4X{} чаще" } },
            v_cry_ember           = { name = "Огненная ставка",             text = { "Все предметы не дают деньги при продаже" } },

            -- Теги-апгрейды (Double→Triple/Quadruple/Quintuple)
            v_cry_copies       = { name = "Копии",            text = { "Двойные теги становятся", "{C:attention}Тройными тегами{} и",    "в {C:attention}2X{} чаще" } },
            v_cry_tag_printer  = { name = "Принтер тегов",    text = { "Двойные теги становятся", "{C:attention}Четверными тегами{} и",  "в {C:attention}3X{} чаще" } },
            v_cry_clone_machine = { name = "Машина клонирования", text = { "Двойные теги становятся", "{C:attention}Пятерными тегами{} и", "в {C:attention}4X{} чаще" } },

            v_cry_command_prompt = {
                name = "Командная строка",
                text = { "{C:cry_code}Карты кода", "могут появляться", "в {C:attention}магазине" },
            },
            v_cry_curate = {
                name = "Куратор",
                text = { "Все карты", "появляются с", "{C:dark_edition}Выпуском" },
            },
            v_cry_dexterity = {
                name = "Ловкость",
                text = { "Навсегда", "получите {C:blue}+#1#{} рук(у)", "каждый раунд" },
            },
            v_cry_double_down = {
                name = "Удвоение",
                text = {
                    "После каждого раунда,",
                    "{X:dark_edition,C:white} X1.5 {} ко всем значениям",
                    "на обратной стороне",
                    "{C:dark_edition}Двухсторонних{} карт",
                },
            },
            v_cry_double_slit = {
                name = "Двойной разрез",
                text = { "{C:attention}Слияние{} может появляться", "в магазине и", "Паках Арканы" },
            },
            v_cry_moneybean = {
                name = "Денежный боб",
                text = {
                    "Повышает лимит",
                    "заработанных процентов",
                    "в каждом раунде до {C:money}$#1#{}",
                },
            },
            v_cry_overstock_multi = {
                name = "Мультизапас",
                text = {
                    "{C:attention}+#1#{} слот(а) карт и",
                    "{C:attention}+#1#{} слот(а) паков",
                    "в магазине",
                },
            },
            v_cry_pacclimator = {
                name = "Акклиматизатор планет",
                text = {
                    "{C:planet}Планетарные{} карты появляются",
                    "в {C:attention}X#1#{} чаще в магазине",
                    "Все будущие {C:planet}Планетарные карты {C:green}бесплатны",
                },
            },
            v_cry_pairamount_plus = {
                name = "Параманд Плюс",
                text = {
                    "{C:attention}Перезапустить{} всех М Джокеров",
                    "раз за каждую Пару",
                    "{C:attention}содержащуюся{} в сыгранной руке",
                },
            },
            v_cry_pairing = {
                name = "Спаривание",
                text = {
                    "{C:attention}Перезапустить{} всех М Джокеров",
                    "если сыгранная рука это {C:attention}Пара",
                },
            },
            v_cry_repair_man = {
                name = "Ремонтник",
                text = {
                    "{C:attention}Перезапустить{} всех М Джокеров",
                    "если сыгранная рука содержит {C:attention}Пару",
                },
            },
            v_cry_satellite_uplink = {
                name = "Спутниковая связь",
                text = {
                    "{C:cry_code}Карты кода{} могут",
                    "появляться в любом из",
                    "{C:attention}Небесных Паков",
                },
            },
            v_cry_scope = {
                name = "Галактический прицел",
                text = {
                    "Создаёт {C:planet}Планетарную",
                    "карту для сыгранной",
                    "{C:attention}покерной руки",
                    "{C:inactive}(Должно быть место)",
                },
            },
            v_cry_tacclimator = {
                name = "Акклиматизатор таро",
                text = {
                    "{C:tarot}Карты Таро{} появляются",
                    "в {C:attention}X#1#{} чаще в магазине",
                    "Все будущие {C:tarot}карты Таро {C:green}бесплатны",
                },
            },
            v_cry_threers = {
                name = "Расточительность",
                text = { "Навсегда", "получите {C:red}+#1#{} сброс(ов)", "каждый раунд" },
            },
            v_cry_stickyhand = {
                name = "Липкая рука",
                text = { "{C:attention}+#1#{} карта", "лимит выбора" },
            },
            v_cry_grapplinghook = {
                name = "Крюк-кошка",
                text = {
                    "{C:attention}+#1#{} карта",
                    "лимит выбора",
                    "{C:inactive,s:0.7}ЗАМЕТКА: будет доп. функционал{}",
                    "{C:inactive,s:0.7}позже{}",
                },
            },
            v_cry_hyperspacetether = {
                name = "Гиперпространственная привязь",
                text = {
                    "{C:attention}+#1#{} карта",
                    "лимит выбора",
                    "{C:inactive,s:0.7}ЗАМЕТКА: будет доп. функционал{}",
                    "{C:inactive,s:0.7}позже{}",
                },
            },
        },

        -- ── РАЗНОЕ ──────────────────────────────────────────
        Other = {
            alt_wheel_of_fortune = {
                name = "Колесо Фортуны",
                text = {
                    "Шанс {C:green}#1# к #2#{} добавить",
                    "{C:dark_edition}фольговый{}, {C:dark_edition}голографический{} или",
                    "{C:dark_edition}полихромный{} выпуск",
                    "к случайному {C:attention}джокеру",
                },
            },
            cry_absolute = {
				name = "Абсолют",
				text = {
					"Не подлежит продаже",
					"или уничтожению",
					"{C:attention}Несъемный{}",
				},
			},
            banana = {
                name = "Банан",
                text = { "{C:green}#1# к #2#{} шанс", "быть уничтоженным каждый раунд" },
            },
            cry_flickering = {
                name = "Мерцающий",
                text = {
					"Будет уничтожен после",
					"{C:attention}#1#{} срабатываний",
					"{C:inactive}({C:attention}#2#{C:inactive} осталось)",
				},
			},
            cry_rigged = {
                name = "Подкручено",
                text = { "Все {C:cry_code}указанные{} вероятности", "{C:cry_code}гарантированы" },
            },
            cry_function_sticker = {
				name = "Function://",
				text = {
					"Создает {C:cry_code}#1#{}",
					"при использовании",
				},
			},
			cry_function_sticker_desc = {
				name = "Function://",
				text = {
					"Создает следующее",
					"{C:cry_code}Function://{} расходуемое",
					"{C:inactive}Сейчас #1#, #2# and #3#{}",
				},
			},
            cry_hooked_2 = {
                name = "Зацеплено",
                text = { 
                    "Когда этот Джокер {C:cry_code}срабатывает{},", 
                    "запускает {C:cry_code}#1#",
                    "{C:inactive}Не все карты могут быть активированы таким образом{}",
                    "{C:inactive}но все джокеры могут активировать других{}", 
                },
            },
            food_jokers = {
                name = "Еда-джокеры",
                text = {
                    "{s:0.8}Грос Мишель, яйцо, мороженое, Кавендиш,",
                    "{s:0.8}Черепаховый боб, диетическая кола, попкорн, рамен,",
                    "{s:0.8}Газированная вода, соленый огурец, перец чили, карамель,",
                    "{s:0.8}Ностальгические конфеты, фастфуд M и т. д.",
                },
            },
            cry_global_sticker = {
				name = "Глобальный",
				text = {
					"Вытяните эту карту",
					"{C:cry_code}Перед другими картами{},",
					"если возможно",
				},
			},
            cry_https_disabled = {
                name = "M",
                text = { "{C:attention,s:0.7}Updating{s:0.7} is disabled by default ({C:attention,s:0.7}HTTPS Module{s:0.7})" },
            },

            -- Наклейки бустеров (booster_sticker)
            cry_eternal_booster    = booster_sticker("Вечный",         "Вечными"),
            cry_perishable_booster = booster_sticker("Скоропортящийся", "Скоропортящимися"),
            cry_rental_booster     = booster_sticker("Аренда",         "Арендованными"),
            cry_pinned_booster     = booster_sticker("Закреплённый",   "Закреплёнными"),
            cry_banana_booster     = booster_sticker("Банан",          "Бананом"),

            -- Наклейки ваучеров
            cry_eternal_voucher    = { name = "Вечный",         text = { "Нельзя обменять" } },
            cry_perishable_voucher = {
                name = "Скоропортящийся",
                text = { "Ослаблен после", "{C:attention}#1#{} rounds", "{C:inactive}({C:attention}#2#{C:inactive} remaining)" },
            },
            cry_rental_voucher     = { name = "Аренда",         text = { "Потеряйте {C:money}$#1#{} в конце раунда" } },
            cry_pinned_voucher     = { name = "Закреплённый",   text = { "Остаётся в магазине", "до использования" } },
            cry_banana_voucher     = { name = "Банан",          text = { "{C:green}#1# к #2#{} шанс", "не активироваться этот раунд" } },

            -- Наклейки расходников
            cry_perishable_consumeable = { name = "Скоропортящийся", text = { "Ослаблен в", "конце раунда" } },
            cry_rental_consumeable     = { name = "Аренда",          text = { "Потеряйте {C:money}$#1#{} в конце", "раунда и при использовании" } },
            cry_pinned_consumeable     = { name = "Закреплённый",    text = { "Нельзя использовать другие", "не-{C:attention}Закреплённые{} расходники" } },
            cry_banana_consumeable     = { name = "Банан",           text = { "{C:green}#1# к #2#{} шанс", "ничего не сделать при использовании" } },

            -- Наборы
            p_cry_code_normal_1  = { name = "Программный набор",        text = CODE_PACK_TEXT },
            p_cry_code_normal_2  = { name = "Программный набор",        text = CODE_PACK_TEXT },
            p_cry_code_jumbo_1   = { name = "Программный набор Джамбо", text = CODE_PACK_TEXT },
            p_cry_code_mega_1    = { name = "Мегапрограммный набор",   text = CODE_PACK_TEXT },
            p_cry_empowered = {
                name = "Призрачный набор [Усиленный тег]",
                text = {
                    "Выберите {C:attention}#1#{} из",
                    "{C:attention}#2#{C:spectral} призрачных{} карт",
                    "{s:0.8,C:inactive}(Создан Усиленным тегом)",
                },
            },
            p_cry_meme_1     = { name = "Мемный набор", text = { "Выберите {C:attention}#1#{} из", "{C:attention}#2# Мем-джокеров" } },
            p_cry_meme_two   = { name = "Мемный набор", text = { "Выберите {C:attention}#1#{} из", "{C:attention}#2# Мем-джокеров" } },
            p_cry_meme_three = { name = "Мемный набор", text = { "Выберите {C:attention}#1#{} из", "{C:attention}#2# Мем-джокеров" } },

            p_cry_baneful_1 = {
				name = "Злобный набор шута",
				text = {
					"Выберите {C:attention}#1#{} из",
					"{C:attention}#2# {X:cry_cursed,C:white}Проклятых{} Джокеров",
					"При {C:attention}пропуске{} {C:red}изгоняет{}",
					"{C:attention}крайнего правого{} Джокера",
				},
			},
            undiscovered_code = {
                name = "Не обнаружено",
                text = {
                    "Купите или используйте",
                    "эту карту в",
                    "забеге без сида,",
                    "чтобы узнать что она делает",
                },
            },
            cry_green_seal = {
                name = "Зелёная печать",
                text = {
                    "Создаёт {C:cry_code}карту Кода{},",
                    "при игре без подсчёта",
                    "{C:inactive}(Должно быть место)",
                },
            },
            cry_azure_seal = {
                name = "Лазурная печать",
                text = {
                    "Создаёт {C:attention}#1#{} {C:dark_edition}Негативных{}",
                    "{C:planet}Планет{} для сыгранной",
                    "{C:attention}покерной руки{}, затем",
                    "{C:red}уничтожает{} эту карту",
                },
            },
            cry_multiuse = {
				name = "м",
				text = {
					"{C:inactive}Количество использований: ({C:cry_code}#1#{C:inactive} осталось)",
				},
			},
        },
        Unique = {
			c_cry_potion = {
				name = "Зелье",
				text = {
					"Применяет неизвестное",
					"{C:attention}зло{} когда использовано",
					"{C:inactive,s:0.7}Получено из Шоколадного кубика",
				},
			},
		},
    },

    -- ============================================================
    misc = {
        tutorial = {
            cry_intro_1 = {
                "Привет, я {C:attention}Джозеф Дж. Джокер{}!",
                "Добро пожаловать в {C:cry_exotic,E:1}Cryptid{}!",
            },
            cry_intro_2 = {
                "Похоже, ты ещё ни разу не играл",
                "в {C:cry_exotic,E:1}Cryptid{} на этом профиле.",
                "Позволь объяснить как тут всё устроено!",
            },
            cry_intro_3 = {
                "*отращивает руки*",
            },
            cry_intro_4 = {
                "Сложно описать этот мод в паре",
                "предложений, но скажу одно —",
                "тебя ждёт {C:cry_exotic,E:1}безумное{} приключение!",
                "Это не тот {C:attention}Джокер Покер{}, который ты знаешь...",
            },
            cry_intro_5 = {
                "Как ты, наверное, заметил по этим",
                "{C:cry_ascendant}вариантам{}, я люблю букву {C:attention}М{}.",
                "Выбери вариант, и я объясню...",
                "{s:0.8}Примечание: Баланс вариантов в активной разработке.",
                "{s:0.8}Всё может часто меняться!",
            },
            cry_modest_1 = {
                "Хочешь опыт, близкий к ванильному?",
                "Тогда вариант {C:cry_ascendant}Умеренный{} создан для тебя!",
            },
            cry_modest_2 = {
                "Но будь осторожен с фишками, спрятанными",
                "по всему Cryptid! Никогда не знаешь,",
                "что поджидает тебя в следующем раунде...",
            },
            cry_mainline_1 = {
                "Хочешь {E:1,C:attention}сломать{} игру? Хорошие новости —",
                "можно и без того, чтобы совсем слететь с катушек!",
            },
            cry_mainline_2 = {
                "Здесь тоже безумие, но у тебя будет шанс",
                "ощутить систему {C:cry_ascendant}прогрессии{}.",
                "Только не расслабляйся...",
            },
            cry_mainline_3 = {
                "Ты будешь явно сильнее, но я придумал",
                "таких {E:1,C:dark_edition}боссов{}, что ты,",
                "возможно, пожалеешь о выборе этого {C:cry_ascendant}варианта{}...",
            },
            cry_madness_1 = {
                "Хочешь полностью {C:red,E:1}уничтожить{} свой жёсткий диск?",
                "О, как весело! вариант {C:cry_ascendant}Безумие{} говорит:",
                "'Баланс? {E:1,C:red}ЧТО ЭТО ТАКОЕ!?{}'",
            },
            cry_madness_2 = {
                "Я провёл недели за бессонными ночами на {C:green}Маунтин Дью{}",
                "чтобы убедиться, что этот вариант",
                "{C:cry_ascendant}ИДЕАЛЬНО СБАЛАНСИРОВАН{} — специально для тебя!",
            },
            cry_madness_3 = {
                "Ты начнёшь со всем разблокированным, чтобы",
                "{C:red,E:1}высвободить полную мощь{} Cryptid!",
                "Только осторожно — не {C:attention,E:1}крашни{} игру,",
                "это скорее всего случится раньше, чем ты проиграешь...",
            },
        },
        achievement_names = {
            ach_cry_ace_in_crash         = "Туз в рукаве",
            ach_cry_blurred_blurred_joker = "Юридически слеп",
            ach_cry_bullet_hell          = "Адский ливень",
            ach_cry_break_infinity       = "Разрушь бесконечность",
            ach_cry_cryptid_the_cryptid  = "Криптид из Криптида",
            ach_cry_exodia               = "Экзодия",
            ach_cry_freak_house          = "Чудо-дом",
            ach_cry_googol_play_pass     = "Гугол Плей Пасс",
            ach_cry_haxxor               = "Х4кк0р",
            ach_cry_home_realtor         = "Домашний риелтор",
            ach_cry_jokes_on_you         = "Сам попался, приятель!",
            ach_cry_niw_uoy              = "!илидебоп ыВ",
            ach_cry_now_the_fun_begins   = "Вот теперь начинается веселье",
            ach_cry_patience_virtue      = "Терпение — добродетель",
            ach_cry_perfectly_balanced   = "Идеальный баланс",
            ach_cry_pull_request         = "Пулл-реквест",
            ach_cry_traffic_jam          = "Пробка",
            ach_cry_ult_full_skip        = "Победить за 1 раунд",
            ach_cry_used_crash           = "Мы же предупреждали",
            ach_cry_what_have_you_done   = "ЧТО ТЫ НАДЕЛАЛ?!",
        },
        achievement_descriptions = {
            ach_cry_ace_in_crash          = 'check_for_unlock({type = "ace_in_crash"})',
            ach_cry_blurred_blurred_joker = "Получите Размытого Размытого Джокера",
            ach_cry_bullet_hell           = "Имейте 15 AP Джокеров",
            ach_cry_break_infinity        = "Наберите 1.79e308 фишек за одну руку",
            ach_cry_cryptid_the_cryptid   = "Используйте Криптида на Криптиде",
            ach_cry_exodia                = "Имейте 5 Экзотических Джокеров",
            ach_cry_freak_house           = "Сыграйте Флеш-фулл-хаус из шестёрок и девяток Червей, имея Хорошего Джокера",
            ach_cry_googol_play_pass      = "Сделайте Нечестной карту Googol Play",
            ach_cry_haxxor                = "Используйте чит-код",
            ach_cry_home_realtor          = "Активируйте Счастливый дом до 8-го анте (без DoE/Антиматерии)",
            ach_cry_jokes_on_you          = "Активируйте эффект Шутки на 1-м анте и выиграйте забег",
            ach_cry_niw_uoy               = "Достигните Анте -8",
            ach_cry_now_the_fun_begins    = "Получите Холст",
            ach_cry_patience_virtue       = "Прождите Лавандовый круг 2 минуты перед первой рукой и победите в блайнде",
            ach_cry_perfectly_balanced    = "Победите с Очень честной колодой на Восходящей ставке",
            ach_cry_pull_request          = "Заставьте ://COMMIT создать того же Джокера, которого он уничтожил",
            ach_cry_traffic_jam           = "Пройдите все испытания Час пик",
            ach_cry_ult_full_skip         = "Победите за 1 раунд",
            ach_cry_used_crash            = "Используйте ://CRASH",
            ach_cry_what_have_you_done    = "Удалите или пожертвуйте Экзотического Джокера",
        },
        challenge_names = {
            c_cry_ballin          = "Ballin'",
            c_cry_boss_rush       = "Enter the Gungeon",
            c_cry_dagger_war      = "Война Кинжалов",
            c_cry_onlycard        = "Соло Карта",
            c_cry_rng             = "РНГ",
            c_cry_rush_hour       = "Час пик I",
            c_cry_rush_hour_ii    = "Час пик II",
            c_cry_rush_hour_iii   = "Час пик III",
            c_cry_sticker_sheet   = "Набор наклеек",
            c_cry_sticker_sheet_plus = "Набор наклеек+",
        },
        poker_hands = {
			["cry_Bulwark"] = "Бастион",
			["cry_Clusterfuck"] = Cryptid_config.family_mode and "Бардак" or "Полный бардак",
			["cry_UltPair"] = "Ультимативная Пара",
			["cry_WholeDeck"] = Cryptid_config.family_mode and "Вся колода" or "Вся грёбаная колода",
			["cry-Cluster Bulwark"] = "Бардак в Бастионе",
			["cry_None"] = "Пусто",
		},
        poker_hand_descriptions = {
			["cry_Bulwark"] = {
				"5 карт без ранга и масти",
			},
			["cry_Clusterfuck"] = {
				"По крайней мере 8 карт, которые не содержат",
				"пару, флеш или стрит",
			},
			["cry_UltPair"] = {
				"Две две пары, где",
				"в каждой паре одна масть",
				"Сумарно две масти",
			},
			["cry_WholeDeck"] = {
				"Рука, в которой собраны",
				"все карты из колоды в 52 карты",
				"Ты что, с ума сошёл?",
			},
			["cry_None"] = { "Рука содержит 0 карт" },

			["cry_Declare0"] = { "Всегда считается Стритом" },
			["cry_Declare1"] = { "Всегда считается Флешом" },
			["cry_Declare2"] = { "Всегда считается Фулл-хаусом" },

			["cry_Declare0_suitless"] = { "Всегда считается Стритом", "Руки не требуют специальные масти" },
			["cry_Declare1_suitless"] = { "Всегда считается Флешом", "Руки не требуют специальные масти" },
			["cry_Declare2_suitless"] = { "Всегда считается Фулл-хаусом", "Руки не требуют специальные масти" },
		},
        dictionary = {
            -- Меню настроек
            cry_set_features           = "Функции",
            cry_set_music              = "Музыка",
            cry_set_enable_features    = "Выберите функции для включения (применяются при перезапуске игры):",
            cry_feat_spooky            = "Жуткое обновление",
            cry_feat_achievements      = "Достижения",
            ["cry_feat_antimatter deck"] = "Колода антиматерии",
            cry_feat_blinds            = "Блайнды",
            cry_feat_challenges        = "Испытания",
            ["cry_feat_code cards"]    = "Карты кода",
            ["cry_feat_misc. decks"]   = "Проч. Колоды",
            ["cry_feat_https module"]  = "Модуль HTTPS",
            ["cry_feat_timer mechanics"] = "Механика таймера",
            ["cry_feat_enhanced decks"] = "Enhanced Decks",
            ["cry_feat_epic jokers"]   = "Эпические джокеры",
            ["cry_feat_exotic jokers"] = "Экзотические джокеры",
            ["cry_feat_m jokers"]      = "М джокеры",
            cry_feat_menu              = "Новое главное меню",
            cry_family                 = "Семейный режим",
            ["cry_feat_misc."]         = "Проч.",
            ["cry_feat_misc. jokers"]  = "Проч. Джокеры",
            cry_feat_planets           = "Планеты",
            cry_feat_jokerdisplay      = "ПоказДжокера (Ничего не делает)",
            cry_feat_tags              = "Теги",
            cry_feat_sleeves           = "Рукава",
            cry_feat_spectrals         = "Спектры",
            ["cry_feat_more stakes"]   = "Ставки",
            cry_feat_vouchers          = "Ваучеры",
            cry_code_empty     = "[Объявить руку]",
            cry_mus_jimball    = "Джимбол (Funkytown от Lipps Inc. - Copyrighted)",
            cry_mus_code       = "Карты кода (://LETS_BREAK_THE_GAME от HexaCryonic)",
            cry_mus_exotic     = "Экзотические джокеры (Joker in Latin от AlexZGreat)",
            cry_mus_high_score = "Высокий счёт (Final Boss [For Your Computer] от AlexZGreat)",
            rush_hour_reminder = "Включите Часы и Лавандовый круг, для «Час пик»",
            cry_experimental = "Экспериментальный режим",
            cry_force_tooltips = "Принудительно вызывать подсказки",

            k_cry_program_pack = "Програмный набор",
            k_cry_meme_pack    = "Мемный набор",
            k_cry_baneful_pack = "Злобный набор шута",

            cry_critical_hit_ex  = "Критическое Попадание!",
            cry_critical_miss_ex = "Критический Промах!",

            cry_debuff_oldhouse      = "Без фулл-хаусов",
            cry_debuff_oldarm        = "Необходимо сыграть не более 4 карт.",
            cry_debuff_oldpillar     = "Без стритов",
            cry_debuff_oldflint      = "Без флешей",
            cry_debuff_oldmark       = "В руке не должно быть пар",
            cry_debuff_obsidian_orb  = "Применяет способности всех побежденных боссов.",

            k_code      = "Код",
            k_chips     = "шт. фишек",
            b_code_cards = "Карты кода",
            b_pull      = "ТЯНУТЬ",
            cry_hooked_ex = "Зацеплен!",
            k_end_blind = "Конец Блайнда",
            k_planet_universe = Cryptid_config.family_mode and "Вселенная" or "Вся Грёбаная Вселенная",
            k_planet_disc = "Околозвездный диск",
			k_planet_satellite = "Естественные спутники",


            k_content_set = "Тематический набор",
			b_content_sets = "Тематические наборы",

            cry_code_rank              = "ВВЕДИТЕ РАНГ",
            cry_code_enh               = "ВВЕДИТЕ УЛУЧШЕНИЕ",
            cry_code_hand              = "ВВЕДИТЕ ПОКЕРНУЮ РУКУ",
            cry_code_enter_card        = "ВВЕДИТЕ КАРТУ",
            cry_code_apply             = "ПРИМЕНИТЬ",
            cry_code_apply_previous    = "ПРИМЕНИТЬ ПРЕДЫДУЩЕЕ",
            cry_code_exploit           = "ЭКСПОЙТ",
            cry_code_exploit_previous  = "ЭКСПОЙТ ПРЕДЫДУЩЕЕ",
            cry_code_create            = "СОЗДАТЬ",
            cry_code_create_previous   = "СОЗДАТЬ ПРЕДЫДУЩЕЕ",
            cry_code_execute           = "ВЫПОЛНИТЬ",
            cry_code_cancel            = "ОТМЕНА",

            b_flip  = "ПЕРЕВЕРНУТЬ",
            b_merge = "СОЕДИНИТЬ",
            b_store = "СОХРАНИТЬ",

            cry_asc_hands = "Восх. руки",
			cry_p_star = "Звезда",

            cry_hand_bulwark = "Бастион",
			cry_hand_clusterfuck = "Полный бардак",
			cry_hand_ultpair = "Ультимативная Пара",

            cry_gameset_disabled = "Отключён",
			cry_gameset_modest = "Умеренный",
			cry_gameset_mainline = "Основная версия",
			cry_gameset_madness = "Безумие",
			cry_gameset_custom = "Модифицированный",
			cry_gameset_Custom = "Собственный",
			cry_gameset_exp = "Экспериментальный",
			cry_gameset_exp_modest = "Экспериментальный (Умеренный)",
			cry_gameset_exp_mainline = "Экспериментальный (Основная версия)",
			cry_gameset_exp_madness = "Экспериментальный (Безумие)",

            cry_notif_jimball_1        = "Джимбол",
            cry_notif_jimball_2        = "Уведомление об авторских правах",
            cry_notif_jimball_d1       = 'Джимбол воспроизводит песню "Funkytown",',
            cry_notif_jimball_d2       = "которая защищена авторским правом и не может",
            cry_notif_jimball_d3       = "использоваться в стримах и видео.",
            cry_gameset_explanation    = {
                "Выберите конфигурацию набора",
                "для применения к этой карте.",
            },

            k_cry_shiny = "Блестящий",
            k_cry_candy = "Конфета",
            k_cry_cursed = "Проклятый",

            cry_again_q   = "Снова?",
            cry_curse     = "Проклятие",
            cry_curse_ex  = "Проклятие!",
            cry_sobbing   = "Помогите...",
            cry_gaming    = "Гейминг",
            cry_gaming_ex = "Гейминг!",
            cry_sus_ex    = "Самозванец!",
            cry_jolly_ex  = "Весело!",
            cry_m_minus   = "m",
            cry_m         = "M",
            cry_m_ex      = "M!",
            cry_minus_round  = "-1 Раунд",
            cry_plus_cryptid = "+1 Криптид",
            cry_no_triggers  = "Триггеров не осталось!",
            cry_unredeemed   = "Не активировано...",
            cry_active       = "Активен",
            cry_inactive     = "Неактивен",

            k_cry_epic   = "Эпический",
            k_cry_exotic = "Экзотический",

            cry_potion1                = "-1 ко всем уровням рук",
            cry_potion2                = "X1.15 размер блайнда",
            cry_potion3                = "-1 Рука и Сброс",

            b_reset_gameset_modest     = "Сбросить конфиг набора (Умеренный)",
            b_reset_gameset_mainline   = "Сбросить конфиг набора (Основная линия)",
            b_reset_gameset_madness    = "Сбросить конфиг набора (Безумие)",
        },
        labels = {
            food_jokers      = "Еда-джокеры",
            banana           = "Банан",
            code             = "Код",
            pinned           = "Закреплённый",
            cry_absolute     = "Абсолют",
            cry_flickering   = "Мерцающий",
            cry_rigged       = "Подкручено",
            cry_hooked       = "Зацеплено",
            cry_global_sticker = "Глобальный",
            cry_green_seal   = "Зелёная печать",
            cry_azure_seal   = "Лазурная печать",
            cry_astral       = "Астральный",
            cry_blur         = "Размытый",
            cry_double_sided = "Двухсторонний",
            cry_glass        = "Хрупкий",
            cry_glitched     = "Глючный",
            cry_gold         = "Золотой",
            cry_m            = "Весёлый",
            cry_mosaic       = "Мозаичный",
            cry_noisy        = "Шумный",
            cry_oversat      = "Перенасыщенный",
            k_cry_epic       = "Эпический",
            k_cry_exotic     = "Экзотический",
            unique          = "Уникальный",
            cry_possessed   = "Одержимый",
            k_cry_candy     = "Конфета",
            k_cry_cursed    = "Проклятый",
        },

        rnj_loc_txts = {
            stats = {
                plus_mult   = { "{C:red}+#2#{} Множ." },
                plus_chips  = { "{C:blue}+#2#{} Фишки" },
                x_mult      = { "{X:red,C:white} X#2#{} Множ." },
                x_chips     = { "{X:blue,C:white} X#2#{} Фишки" },
                h_size      = { "{C:attention}+#2#{} Размер руки" },
                money       = { "{C:money}+$#2#{} при выплате" },
            },
            stats_inactive = {
                plus_mult   = { "{C:inactive}(Сейчас {C:red}+#1#{C:inactive} Множ.)" },
                plus_chips  = { "{C:inactive}(Сейчас {C:blue}+#1#{C:inactive} Фишки)" },
                x_mult      = { "{C:inactive}(Сейчас {X:red,C:white} X#1# {C:inactive} Множ.)" },
                x_chips     = { "{C:inactive}(Сейчас {X:blue,C:white} X#1# {C:inactive} Фишки)" },
                h_size      = { "{C:inactive}(Сейчас {C:attention}+#1#{C:inactive} Размер руки)" },
                money       = { "{C:inactive}(Сейчас {C:money}+$#1#{C:inactive})" },
            },
            actions = {
                make_joker    = { "Создать {C:attention}#2# Джокер{}" },
                make_tarot    = { "Создать карту {C:attention}#2#{C:tarot} Таро{}" },
                make_planet   = { "Создать карту {C:attention}#2#{C:planet} Планеты{}" },
                make_spectral = { "Создать карту {C:attention}#2#{C:spectral} Спектральную{}" },
                add_dollars   = { "Получить {C:money}$#2#{}" },
            },
            contexts = {
                open_booster         = { "когда {C:attention}Бустерный набор{} открыт" },
                buying_card          = { "когда куплена карта" },
                selling_self         = { "когда эта карта продана" },
                selling_card         = { "когда продана карта" },
                reroll_shop          = { "при обновлении магазина" },
                ending_shop          = { "в конце {C:attention}магазина{}" },
                skip_blind           = { "когда {C:attention}блайнд{} пропущен" },
                skipping_booster     = { "когда любой {C:attention}бустер{} пропущен" },
                playing_card_added   = { "каждый раз при добавлении карты в колоду" },
                first_hand_drawn     = { "в начале раунда" },
                setting_blind        = { "при выборе {C:attention}блайнда{}" },
                remove_playing_cards = { "когда карта уничтожена" },
                using_consumeable    = { "при использовании {C:attention}расходуемой{} карты" },
                debuffed_hand        = { "если сыгранная {C:attention}комбинация{} запрещена" },
                pre_discard          = { "перед каждым сбросом" },
                discard              = { "за каждую сброшенную карту" },
                end_of_round         = { "в конце {C:attention}раунда{}" },
                individual_play      = { "за каждую сыгранную карту" },
                individual_hand_score = { "за каждую карту в руке при подсчёте" },
                individual_hand_end  = { "за каждую карту в руке в конце {C:attention}раунда{}" },
                repetition_play      = { "повторно активирует сыгранные карты" },
                repetition_hand      = { "повторно активирует карты в руке" },
                other_joker          = { "за каждого {C:attention}Джокера{}" },
                before               = { "перед каждой {C:attention}рукой{}" },
                after                = { "после каждой {C:attention}руки{}" },
                joker_main           = {},
            },
            conds = {
                buy_common    = { "если это {C:blue}Обычный{} {C:attention}Джокер{}" },
                buy_uncommon  = { "если это {C:green}Необычный{} {C:attention}Джокер{}" },
                tarot         = { "если карта — {C:tarot}Таро{}" },
                planet        = { "если карта — {C:planet}Планета{}" },
                spectral      = { "если карта — {C:spectral}Спектральная{}" },
                joker         = { "если карта — {C:attention}Джокер{}" },
                suit          = { "если карта масти {V:1}#3#{}" },
                rank          = { "если карта ранга {C:attention}#3#{}" },
                face          = { "если карта — {C:attention}с лицом{}" },
                boss          = { "если {C:attention}блайнд{} — {C:attention}Босс{}" },
                non_boss      = { "если {C:attention}блайнд{} — не босс" },
                small         = { "если {C:attention}блайнд{} — малый" },
                big           = { "если {C:attention}блайнд{} — большой" },
                first         = { "если это первая {C:attention}рука{}" },
                last          = { "если это последняя {C:attention}рука{}" },
                common        = { "если это {C:blue}Обычный{} {C:attention}Джокер{}" },
                uncommon      = { "если это {C:green}Необычный{} {C:attention}Джокер{}" },
                rare          = { "если это {C:red}Редкий{} {C:attention}Джокер{}" },
                poker_hand    = { "если рука — {C:attention}#3#{}" },
                or_more       = { "если рука содержит {C:attention}#3#{} или больше карт" },
                or_less       = { "если рука содержит {C:attention}#3#{} или меньше карт" },
                hands_left    = { "если осталось #3# {C:blue}комбинаций{} в конце раунда" },
                discards_left = { "если осталось #3# {C:red}сбросов{} в конце раунда" },
                first_discard = { "если это первый {C:attention}сброс{}" },
                last_discard  = { "если это последний {C:attention}сброс{}" },
                odds          = { "с шансом {C:green}#4# к {C:green}#3#{}" },
            },
        },

        v_dictionary = {
            a_xchips = "X#1# Фишек",
            a_powmult = "^#1# Множ.",
            a_powchips = "^#1# Фишек",
            a_powmultchips = "^#1# Множ.+Фишек",
            a_round = "+#1# Раунд",
            a_candy = "+#1# Конфета",
            a_xchips_minus = "-X#1# Фишек",
            a_powmult_minus = "-^#1# Множ.",
            a_powchips_minus = "-^#1# Фишек",
            a_powmultchips_minus = "-^#1# Множ.+Фишек",
            a_round_minus = "-#1# Раунд",
            a_tag_minus = "-#1# Тег",
            a_tags_minus = "-#1# Тегов",
            a_tag = "+#1# Тег",
            a_tags = "+#1# Тегов",

            cry_sticker_name = "Стикер #1#",
            cry_sticker_desc = {
                "Использовал этого Джокера",
                "для победы на #2##1#",
                "сложности #2#Ставка#3#",
            },
            tax_hand = "Макс #1#% от требуемых фишек",
            cry_art = "Арт: #1#",
            cry_code = "Код: #1#",
            cry_idea = "Идея: #1#",
            cry_trade_add = "#1# получен через обмен",
            cry_trade_remove = "#1# возвращён через обмен",
},

        v_text = {
            ch_c_cry_all_perishable     = { "Все джокеры {C:eternal}Perishable{}" },
            ch_c_cry_all_rental         = { "Все джокеры {C:eternal}Rental{}" },
            ch_c_cry_all_pinned         = { "Все джокеры {C:eternal}закреплены{}" },
            ch_c_cry_all_banana         = { "Все джокеры {C:eternal}Banana{}" },
            ch_c_all_rnj                = { "Все джокеры {C:attention}RNJoker{}" },
            ch_c_cry_sticker_sheet_plus = { "All purchasable items have all stickers" },
            ch_c_cry_rush_hour          = { "All Boss Blinds are {C:attention}The Clock{} or {C:attention}Lavender Loop" },
            ch_c_cry_rush_hour_ii       = { "All Blinds are {C:attention}Boss Blinds{}" },
            ch_c_cry_rush_hour_iii      = { "{C:attention}Часы{} и {C:attention}Lavender Loop{} scale {C:attention}twice{} as fast" },
            
            ch_c_cry_no_tags            = { "Пропуски {C:attention}отключены{}" },
            ch_c_cry_no_vouchers        = { "В магазине больше не появляются {C:attention}Ваучеры{}" },
			ch_c_cry_no_boosters        = { "В магазине больше не появляются {C:attention}Бустерные наборы{}" },
			ch_c_cry_no_rerolls         = { "Перебросы {C:attention}отключены{}" },
			ch_c_cry_no_consumables     = { "В магазине больше не появляются {C:attention}Расходники{}" },
        },
    },

    -- ============================================================
    -- Шутки для «Очень честной колоды»
    -- Спасибо всем участникам сообщества!
    -- Перечислить всех не представляется возможным, поэтому просто перейдите сюда: https://discord.com/channels/1116389027176787968/1209506360987877408/1237971471146553406
    -- И сюда: https://discord.com/channels/1116389027176787968/1219749193204371456/1240468252325318667
    -- Руский перевод выполнен игроком с именем Wertus
    -- ============================================================

    very_fair_quips = {
        { "Л", "НЕТ ВАУЧЕРОВ", "ДЛЯ ТЕБЯ" },
        { "КЛОУН", "ТЫ ДУМАЛ Я ДАМ ТЕБЕ", "ВАУЧЕР?" },
        { "НЕТ!", "НИКАКИХ ВАУЧЕРОВ!", "(ИЗДАНИЕ НИЩЕБРОДА)" },
        { "СКИЛЛ ИШЬЮ", "ПРЕДСТАВЬ БЫТЬ ДОСТАТОЧНО ХОРОШИМ", "ДЛЯ ВАУЧЕРА" },
        { "ДЖИМБО", "ИЗ МЕНЕДЖМЕНТА", "ЗАБЫЛ ПОПОЛНИТЬ ЗАПАСЫ" },
        { "УПС!", "ВАУЧЕРОВ НЕТ", "" },
        { "ЭЙ ДЖОКЕР,", "ЧТО ТЫ ТУТ ИЩЕШЬ?", "ЛОЛ" },
        { "ВАУЧЕР", "В ДРУГОМ", "ЗАМКЕ" },
        { "$0", "ПУСТОЙ ВАУЧЕР", "(ПОНЯЛ ШУТКУ?)" },
        {  "ОШИБКА", "НЕВОЗМОЖНО ВЫПОЛНИТЬ АРИФМЕТИКУ С NIL", "(tier4vouchers.lua)" },
        { "СКИДКА 100%", "НА ВСЕ ВАУЧЕРЫ", "(КТО-ТО УЖЕ ВСЁ СКУПИЛ)" },
        { "ПОПРОБУЙ ПОЗЖЕ", "ПОДСКАЗКА: ДЕНЕГ", "ВСЁ РАВНО НЕ ХВАТИТ" },
        { "ЧТО?", '"ВАУЧЕР"?', "ЭТО ВООБЩЕ СЛОВО?..." },
        { 'ЗАЖМИ "R"', "ЧТОБЫ ПОПОЛНИТЬ", "ВСЕ ВАУЧЕРЫ" },
        { "ЗНАЛ ЛИ ТЫ?", "ALT+F4 ДАЁТ", "БЕСПЛАТНЫЕ ВАУЧЕРЫ!" },
        { "ИЗВИНИ,", "ВАУЧЕРОВ НЕТ", "ИЗ-ЗА СОКРАЩЕНИЯ БЮДЖЕТА" },
        { "ЗВОНИ 8-800-ДЖИМБО", "ЧТОБЫ ОЦЕНИТЬ", "СВОЙ ОПЫТ С ВАУЧЕРАМИ" },
        { "ПОБЕДИ", "БОСС-БЛАЙНД 39-ГО АНТЕ", "ДЛЯ ПОПОЛНЕНИЯ" },
        { "ФОКУС-ПОКУС", "Я ЗАСТАВИЛ ЭТОТ ВАУЧЕР", "ИСЧЕЗНУТЬ" },
        { "ПОЧЕМУ", "ВАУЧЕР ПОХОЖ НА", "ПИСЬМЕННЫЙ СТОЛ?" },
        { "МЫ ОТОЗВАЛИ", "ТВОИ ВАУЧЕРЫ — ОНИ ЛУЧШЕ", "ПОСЛУЖАТ В ДРУГИХ ЗАБЕГАХ" },
        { "ПОЧЕМУ ЭТО НАЗЫВАЕТСЯ ВАУЧЕР", "КОГДА МНОЖ ИЗ ГОРЯЧЕГО", "В ХОЛОДНОМ ЕШЬ ФИШКУ" },
        { "ИЗВИНИ", "ВАУЧЕРЫ ПЕРЕЖИВАЮТ", "ВАУЧЕФИЮ АБОРТУС" },
        { "К СОЖАЛЕНИЮ", "ОБНОВЛЕНИЕ С ПЕРЕРАБОТКОЙ ВАУЧРХ", "БЫЛО ОТМЕНЕНО" },
        { "ПОБЕДИ", "БОСС БЛАЙНД ЧТОБЫ", "НИЧЕГО НЕ ИЗМЕНИЛОСЬ" },
        { "ПТИЦЫ ПОЮТ", "ЦВЕТЫ ЦВЕТУТ", "ДЕТИ ВРОДЕ ТЕБЯ..." },
        { "К СОЖАЛЕНИЮ СООБЩАЕМ", "ВСЕ ВАУЧЕРЫ ОТОЗВАНЫ", "ИЗ-ЗА САЛЬМОНЕЛЛЫ" },
        { "ВАУЧЕРЫ НЕ ПРИЕХАЛИ", "ИЗ-ЗА ТОГО ЧТО ПЛАНИРОВКА МАГАЗИНА", "НА 200% ПРЕВЫСИЛА БЮДЖЕТ" },
        { "ТЫ ЛЮБИШЬ", "ПОКУПАТЬ ВАУЧЕРЫ, ПРАВДА?", "ТЫ ВАУЧЕРОЛЮБ" },
        { "ВАУЧЕРЫ", "!Е", "ПУЛ ВАУЧЕРОВ" },
        { "НЕТ НИ САНТЫ", "НИ ВАУЧЕРОВ", "" },
        { "", "БЕЗВАУЧЕРНО", "" },
        { "", "VOUCHERN'T", "" },
        { "ТЫ", "ТОЛЬКО ЧТО", "ПРОИГРАЛ ИГРУ" },
        { "МОГУ ЛИ Я ПРЕДЛОЖИТЬ", "ТЕБЕ ХОРОШЕЕ ЯЙЦО", "В ЭТИ НЕПРОСТЫЕ ВРЕМЕНА?" },
        { "ИДИ ПОТРОГАЙ ТРАВУ", "ВМЕСТО ТОГО ЧТОБЫ", "ИГРАТЬ ЭТОЙ КОЛОДОЙ" },
        { "YOU COULD BE", "PLAYING ON BLUE DECK", "RIGHT NOW" },
        { "МОГ БЫ СЕЙЧАС", "ИГРАТЬ С СИНЕЙ КОЛОДОЙ", "" },
        { "БЕСПЛАТНЫЕ ЭКЗОТИКИ", "УСПЕЙ ВЗЯТЬ ПОКА НЕ", "ПОЗДНО (РАСПРОДАНО)" },
        { "ДОКАЖИ ЧТО ОНИ НЕПРАВЫ", "КУПИВ НЕВИДИМЫЙ", "ВАУЧЕР ЗА $10" },
        { "", "без ваучеров?", "" },
        { "ВИДИШЬ ЭТУ РЕКЛАМУ?", "ЕСЛИ ДА — ОНА РАБОТАЕТ", "И ТЫ МОГ БЫ РАЗМЕСТИТЬ СВОЮ" },
        { "ТЫ УПУСКАЕШЬ", "КАК МИНИМУМ 5 ВАУЧЕРОВ ПРЯМО СЕЙЧАС", "тонктонктонктонктонк" },
        { "10", "20 ВАУЧЕРОВ НЕТ XD", "30 GOTO 10" },
        { "ВАУЧЕРЫ —", "ПЛАТНАЯ ФУНКЦИЯ", "РАЗБЛОКИРОВАТЬ ЗА $199.99 ДЖОЛЛАРОВ" },
        { "БЕЗ ВАУЧЕРОВ ПОНАСТОЯЩЕМУ!?!?", "ТОЛЬКО ДЛЯ ВОСХОДЯЩЕЙ СТАВКИ", "ОЧЕНЬ ЧЕСТНАЯ КОЛОДА" },
        { "НРАВИТСЯ ТВОЙ", "ОПЫТ С ВАУЧЕРАМИ? ПОСТАВЬ НАМ", "ПЯТЬ ЗВЁЗД НА ДЖЕСТЕЛП" },
        { "БЕСПЛАТНЫЕ ВАУЧЕРЫ", "ГОРЯЧИЕ ВАУЧЕРЫ РЯДОМ С ТОБОЙ", "ПОЛУЧИ ВАУЧЕР БЫСТРО ОДНИМ ТРЮКОМ" },
        { "ПРЕДСТАВЛЯЕМ", "ПЕРВЫЙ В ИСТОРИИ ВАУЧЕР 0 УРОВНЯ!", "(скоро в Cryptid 1.0)" },
        { "ВАУЧЕР!", "ОН ПРОСТО ВООБРАЖАЕМЫЙ", "МЫ РЕШИЛИ ЧТО ТЫ ЭТОГО ХОТЕЛ" },
        { "ОТКЛЮЧИ АДБЛОК", "БЕЗ РЕКЛАМЫ МЫ НЕ СМОГЛИ БЫ", "ПРОДАТЬ ТЕБЕ ВАУЧЕРЫ" },
        { "ЕСЛИ ЕСТЬ", "ПРЕТЕНЗИИ — ПИШИ НАМ", "НА NORESPONSE@JMAIL.COM" },
        { "ДЕНЕГ НЕ ХВАТИТ", "НА ЭТОТ ВАУЧЕР", "ТАК ЗАЧЕМ МЫ ЕГО СЮДА ПОЛОЖИЛИ?" },
        { "ХОЧЕШЬ ВАУЧЕР?", "ЗАТКНИСЬ", "ВСЁ РАВНО НЕ ДАДИМ ЛОЛ" },
        { "@#$% НЕТ", "ВАУЧЕРОВ @#$% %@#% ДЛЯ", "%@#$% %@#$&% ТЕБЯ" },
        { "ВАУЧЕР (ВЕРЬ)", "|\\/|", "|/\\|" },
        {
            "... --- ...",
            ".--. .-.. .- -.-- . .-. -.. . -.-. --- -.. . -.. -- --- .-. ... .",
            "-.-. --- -.. . - --- ..-. .. -. -.. .- ...- --- ..- -.-. .... . .-.",
        },
        { "ЗАПУСК > НОВЫЙ", "СМОТРИ В ПУСТОТУ", "ЧАСИК-ДРУГОЙ" },
        { "МЫ ОЧЕНЬ СОЖАЛЕЕМ", "ПОСЛЕДНИЙ ЧУВАК В ПАНИКЕ СКУПИЛ", "ВСЕ ВАУЧЕРЫ" },
        { "ВОТ КАК ЧУВСТВУЕШЬ СЕБЯ", "КОГДА ПОКУПАЕШЬ", "НОЛЬ ВАУЧЕРОВ" },
        { "ДЖИМБО ВЫКИНУЛ НАТ 1", "И ВЫБРОСИЛ ВСЕ", "ВАУЧЕРЫ В КАНАВУ" },
        { "ПОПЫТКА ИНДЕКСИРОВАТЬ", "ПОЛЕ 'VOUCHER'", "(NIL ЗНАЧЕНИЕ)" },
        {
            "ТЫ ПРАВДА ДУМАЛ ЧТО, ПРОЧИТАВ ВСЕ ЭТИ СТРОКИ, ПОЛУЧИШЬ СВОИ ВАУЧЕРЫ ОБРАТНО?",
            "СПЕШИМ СООБЩИТЬ: В ЭТОЙ КОЛОДЕ НЕТ ВАУЧЕРОВ КОТОРЫЕ ТЫ ИЩЕШЬ.",
            "ЭТОТ НЕНОРМАЛЬНО ДЛИННЫЙ ТЕКСТ СУЩЕСТВУЕТ ЧТОБЫ ПОТРАТИТЬ ТВОЁ ВРЕМЯ И УСИЛИЯ ПОКА ТЫ ЕГО ЧИТАЕШЬ.",
        },
        { "ПЕРЕЙДИ ПО", "https://www.youtube.com/watch?v=dQw4w9WgXcQ", "ДЛЯ БЕСПЛАТНЫХ ВАУЧЕРОВ" },
    },
}