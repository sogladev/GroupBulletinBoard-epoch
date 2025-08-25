local _, GBB = GroupBulletinBoard_Loader.Main()

local function getSeasonalDungeons()
  local events = {}

  for eventName, eventData in pairs( GBB.Seasonal ) do
    table.insert( events, eventName )
    if GBB.Tool.InDateRange( eventData.startDate, eventData.endDate ) then
      GBB.SeasonalActiveEvents[ eventName ] = true
    end
  end
  return events
end

function GBB.GetDungeonNames()
  local DefaultEnGB = {
    [ "RFC" ] = "Ragefire Chasm",
    [ "DM" ] = "The Deadmines",
    [ "WC" ] = "Wailing Caverns",
    [ "SFK" ] = "Shadowfang Keep",
    [ "STOCKS" ] = "The Stockade",
    [ "BFD" ] = "Blackfathom Deeps",
    [ "GNOMER" ] = "Gnomeregan",
    [ "RFK" ] = "Razorfen Kraul",
    [ "SM2" ] = "Scarlet Monastery",
    [ "GY" ] = "Scarlet Monastery: Graveyard",
    [ "LIB" ] = "Scarlet Monastery: Library",
    [ "ARMS" ] = "Scarlet Monastery: Armory",
    [ "CATH" ] = "Scarlet Monastery: Cathedral",
    [ "RFD" ] = "Razorfen Downs",
    [ "ULDA" ] = "Uldaman",
    [ "ZF" ] = "Zul'Farrak",
    [ "MARA" ] = "Maraudon",
    [ "ST" ] = "The Sunken Temple",
    [ "BRD" ] = "Blackrock Depths",
    [ "DM2" ] = "Dire Maul",
    [ "DME" ] = "Dire Maul: East",
    [ "DMN" ] = "Dire Maul: North",
    [ "DMW" ] = "Dire Maul: West",
    [ "STRAT" ] = "Stratholme",
    [ "SCHOLO" ] = "Scholomance",
    [ "LBRS" ] = "Lower Blackrock Spire",
    [ "UBRS" ] = "Upper Blackrock Spire (10)",
    [ "RAMPS" ] = "Hellfire Citadel: Ramparts",
    [ "BF" ] = "Hellfire Citadel: Blood Furnace",
    [ "SP" ] = "Coilfang Reservoir: Slave Pens",
    [ "UB" ] = "Coilfang Reservoir: Underbog",
    [ "MT" ] = "Auchindoun: Mana Tombs",
    [ "AC" ] = "Auchindoun: Auchenai Crypts",
    [ "SH" ] = "Auchindoun: Sethekk Halls",
    [ "OHF" ] = "Caverns of Time: Old Hillsbrad",
    [ "MECHA" ] = "Tempest Keep: The Mechanar",
    [ "BM" ] = "Caverns of Time: Black Morass",
    [ "MGT" ] = "Magisters' Terrace",
    [ "SHH" ] = "Hellfire Citadel: Shattered Halls",
    [ "BOTA" ] = "Tempest Keep: Botanica",
    [ "SL" ] = "Auchindoun: Shadow Labyrinth",
    [ "SV" ] = "Coilfang Reservoir: Steamvault",
    [ "ARCA" ] = "Tempest Keep: The Arcatraz",
    [ "KARA" ] = "Karazhan",
    [ "GRUULS" ] = "Gruul's Lair",
    [ "MAGS" ] = "Hellfire Citadel: Magtheridon's Lair",
    [ "SSC" ] = "Coilfang Reservoir: Serpentshrine Cavern",
    [ "EYE" ] = "Tempest Keep: The Eye",
    [ "ZA" ] = "Zul-Aman",
    [ "HYJAL" ] = "The Battle For Mount Hyjal",
    [ "BT" ] = "Black Temple",
    [ "SWP" ] = "Sunwell Plateau",
    [ "ONY" ] = "Onyxia's Lair (25)",
    [ "MC" ] = "Molten Core (25)",
    [ "ZG" ] = "Zul'Gurub (10)",
    [ "AQ20" ] = "Ruins of Ahn'Qiraj (10)",
    [ "BWL" ] = "Blackwing Lair (25)",
    [ "AQ40" ] = "Temple of Ahn'Qiraj (25)",
    [ "NAXX" ] = "Naxxramas (25)",
    [ "WSG" ] = "Warsong Gulch (PvP)",
    [ "AB" ] = "Arathi Basin (PvP)",
    [ "AV" ] = "Alterac Valley (PvP)",
    [ "EOTS" ] = "Eye of the Storm (PvP)",
    [ "ARENA" ] = "Arena (PvP)",
    [ "MISC" ] = "Miscellaneous",
    [ "TRADE" ] = "Trade",
    [ "DEBUG" ] = "DEBUG INFO",
    [ "BAD" ] = "DEBUG BAD WORDS - REJECTED",
    [ "BREW" ] = "Brewfest - Coren Direbrew",
    [ "HOLLOW" ] = "Hallow's End - Headless Horseman",
    [ "GM" ] = "Glittermurk Mines",
    [ "BH" ] = "Baradin Hold",
    [ "SC" ] = "Stonetalon Caverns",
    [ "ULDUM" ] = "Uldum (25)",
  }

  local dungeonNamesLocales = {
    deDE = {
      [ "RFC" ] = "Flammenschlund",
      [ "DM" ] = "Die Todesminen",
      [ "WC" ] = "Die Höhlen des Wehklagens",
      [ "SFK" ] = "Burg Schattenfang",
      [ "STOCKS" ] = "Das Verlies",
      [ "BFD" ] = "Die Tiefschwarze Grotte",
      [ "GNOMER" ] = "Gnomeregan",
      [ "RFK" ] = "Kral der Klingenhauer",
      [ "SM2" ] = "Scharlachrotes Kloster",
      [ "GY" ] = "Scharlachrotes Kloster: Friedhof",
      [ "LIB" ] = "Scharlachrotes Kloster: Bibliothek",
      [ "ARMS" ] = "Scharlachrotes Kloster: Waffenkammer",
      [ "CATH" ] = "Scharlachrotes Kloster: Kathedrale",
      [ "RFD" ] = "Hügel der Klingenhauer",
      [ "ULDA" ] = "Uldaman",
      [ "ZF" ] = "Zul'Farrak",
      [ "MARA" ] = "Maraudon",
      [ "ST" ] = "Der Tempel von Atal'Hakkar",
      [ "BRD" ] = "Die Schwarzfels-Tiefen",
      [ "DM2" ] = "Düsterbruch",
      [ "DME" ] = "Düsterbruch: Ost",
      [ "DMN" ] = "Düsterbruch: Nord",
      [ "DMW" ] = "Düsterbruch: West",
      [ "STRAT" ] = "Stratholme",
      [ "SCHOLO" ] = "Scholomance",
      [ "LBRS" ] = "Die Untere Schwarzfelsspitze",
      [ "UBRS" ] = "Obere Schwarzfelsspitze (10)",
      [ "RAMPS" ] = "Höllenfeuerzitadelle: Höllenfeuerbollwerk",
      [ "BF" ] = "Höllenfeuerzitadelle: Der Blutkessel",
      [ "SP" ] = "Echsenkessel: Die Sklavenunterkünfte",
      [ "UB" ] = "Echsenkessel: Der Tiefensumpf",
      [ "MT" ] = "Auchindoun: Die Managruft",
      [ "AC" ] = "Auchindoun: Die Auchenaikrypta",
      [ "SH" ] = "Auchindoun: Sethekkhallen",
      [ "OHF" ] = "Höhlen der Zeit: Flucht von Durnholde",
      [ "MECHA" ] = "Festung der Stürme: Die Mechanar",
      [ "BM" ] = "Höhlen der Zeit: Der Schwarze Morast",
      [ "MGT" ] = "Die Terrasse der Magister",
      [ "SHH" ] = "Höllenfeuerzitadelle: Die Zerschmetterten Hallen",
      [ "BOTA" ] = "Festung der Stürme: Botanica",
      [ "SL" ] = "Auchindoun: Schattenlabyrinth",
      [ "SV" ] = "Echsenkessel: Die Dampfkammer",
      [ "ARCA" ] = "Festung der Stürme: Die Arcatraz",
      [ "KARA" ] = "Karazhan",
      [ "GRUULS" ] = "Gruuls Unterschlupf",
      [ "MAGS" ] = "Höllenfeuerzitadelle: Magtheridons Kammer",
      [ "SSC" ] = "Echsenkessel: Höhle des Schlangenschreins",
      [ "EYE" ] = "Das Auge des Sturms",
      [ "ZA" ] = "Zul-Aman",
      [ "HYJAL" ] = "Schlacht um den Berg Hyjal",
      [ "BT" ] = "Der Schwarze Tempel",
      [ "SWP" ] = "Sonnenbrunnenplateau",
      [ "ONY" ] = "Onyxias Hort (25)",
      [ "MC" ] = "Geschmolzener Kern (25)",
      [ "ZG" ] = "Zul'Gurub (10)",
      [ "AQ20" ] = "Ruinen von Ahn'Qiraj (10)",
      [ "BWL" ] = "Pechschwingenhort (25)",
      [ "AQ40" ] = "Tempel von Ahn'Qiraj (25)",
      [ "NAXX" ] = "Naxxramas (25)",
      [ "WSG" ] = "Warsongschlucht (PVP)",
      [ "AV" ] = "Alteractal (PVP)",
      [ "AB" ] = "Arathibecken (PVP)",
      [ "EOTS" ] = "Auge des Sturms (PvP)",
      [ "ARENA" ] = "Arena (PvP)",
      [ "MISC" ] = "Verschiedenes",
      [ "TRADE" ] = "Handel",
      [ "GM" ] = "Glittermurk Mines",
      [ "BH" ] = "Baradin Hold",
      [ "SC" ] = "Stonetalon Caverns",
      [ "ULDUM" ] = "Uldum (25)",

    },
    frFR = {
      [ "RFC" ] = "Gouffre de Ragefeu",
      [ "DM" ] = "Les Mortemines",
      [ "WC" ] = "Cavernes des lamentations",
      [ "SFK" ] = "Donjon d'Ombrecroc",
      [ "STOCKS" ] = "La Prison",
      [ "BFD" ] = "Profondeurs de Brassenoire",
      [ "GNOMER" ] = "Gnomeregan",
      [ "RFK" ] = "Kraal de Tranchebauge",
      [ "SM2" ] = "Monastère écarlate",
      [ "GY" ] = "Monastère écarlate: Cimetière",
      [ "LIB" ] = "Monastère écarlate: Bibliothèque",
      [ "ARMS" ] = "Monastère écarlate: Armurerie",
      [ "CATH" ] = "Monastère écarlate: Cathédrale",
      [ "RFD" ] = "Souilles de Tranchebauge",
      [ "ULDA" ] = "Uldaman",
      [ "ZF" ] = "Zul'Farrak",
      [ "MARA" ] = "Maraudon",
      [ "ST" ] = "Le temple d'Atal'Hakkar",
      [ "BRD" ] = "Profondeurs de Blackrock",
      [ "DM2" ] = "Hache-tripes",
      [ "DME" ] = "Hache-tripes: Est",
      [ "DMN" ] = "Hache-tripes: Nord",
      [ "DMW" ] = "Hache-tripes: Ouest",
      [ "STRAT" ] = "Stratholme",
      [ "SCHOLO" ] = "Scholomance",
      [ "LBRS" ] = "Pic Blackrock",
      [ "UBRS" ] = "Pic Blackrock (10)",
      [ "RAMPS" ] = "Citadelle des Flammes Infernales: Remparts des Flammes infernales",
      [ "BF" ] = "Citadelle des Flammes Infernales: La Fournaise du sang",
      [ "SP" ] = "Réservoir de Glissecroc : Les enclos aux esclaves",
      [ "UB" ] = "Réservoir de Glissecroc : La Basse-tourbière",
      [ "MT" ] = "Auchindoun: Tombes-mana",
      [ "AC" ] = "Auchindoun: Cryptes Auchenaï",
      [ "SH" ] = "Auchindoun: Les salles des Sethekk",
      [ "OHF" ] = "Grottes du Temps: Contreforts de Hautebrande d'antan",
      [ "MECHA" ] = "Donjon de la Tempête: Le Méchanar",
      [ "BM" ] = "Grottes du Temps: Le Noir Marécage",
      [ "MGT" ] = "Terrasse des Magistères",
      [ "SHH" ] = "Citadelle des Flammes Infernales: Les Salles brisées",
      [ "BOTA" ] = "Donjon de la Tempête: Botanica",
      [ "SL" ] = "Auchindoun: Labyrinthe des ombres",
      [ "SV" ] = "Réservoir de Glissecroc : Le Caveau de la vapeur",
      [ "ARCA" ] = "Donjon de la Tempête: L'Arcatraz",
      [ "KARA" ] = "Karazhan",
      [ "GRUULS" ] = "Repaire de Gruul",
      [ "MAGS" ] = "Citadelle des Flammes Infernales: Le repaire de Magtheridon",
      [ "SSC" ] = "Réservoir de Glissecroc : Caverne du sanctuaire du Serpent",
      [ "EYE" ] = "L'Œil du cyclone",
      [ "ZA" ] = "Zul-Aman",
      [ "HYJAL" ] = "Sommet d'Hyjal",
      [ "BT" ] = "Temple noir",
      [ "SWP" ] = "Plateau du Puits de soleil",
      [ "ONY" ] = "Repaire d'Onyxia (25)",
      [ "MC" ] = "Cœur du Magma (25)",
      [ "ZG" ] = "Zul'Gurub (10)",
      [ "AQ20" ] = "Ruines d'Ahn'Qiraj (10)",
      [ "BWL" ] = "Repaire de l'Aile noire (25)",
      [ "AQ40" ] = "Ahn'Qiraj (25)",
      [ "NAXX" ] = "Naxxramas (25)",
      [ "ARENA" ] = "Arena (PvP)",
      [ "GM" ] = "Glittermurk Mines",
      [ "BH" ] = "Baradin Hold",
      [ "SC" ] = "Stonetalon Caverns",
      [ "ULDUM" ] = "Uldum (25)",
    },
    esMX = {
      [ "RFC" ] = "Sima Ígnea",
      [ "DM" ] = "Las Minas de la Muerte",
      [ "WC" ] = "Cuevas de los Lamentos",
      [ "SFK" ] = "Castillo de Colmillo Oscuro",
      [ "STOCKS" ] = "Las Mazmorras",
      [ "BFD" ] = "Cavernas de Brazanegra",
      [ "GNOMER" ] = "Gnomeregan",
      [ "RFK" ] = "Horado Rajacieno",
      [ "SM2" ] = "Monasterio Escarlata",
      [ "GY" ] = "Monasterio Escarlata: Friedhof",
      [ "LIB" ] = "Monasterio Escarlata: Bibliothek",
      [ "ARMS" ] = "Monasterio Escarlata: Waffenkammer",
      [ "CATH" ] = "Monasterio Escarlata: Kathedrale",
      [ "RFD" ] = "Zahúrda Rojocieno",
      [ "ULDA" ] = "Uldaman",
      [ "ZF" ] = "Zul'Farrak",
      [ "MARA" ] = "Maraudon",
      [ "ST" ] = "El Templo de Atal'Hakkar",
      [ "BRD" ] = "Profundidades de Roca Negra	",
      [ "DM2" ] = "La Masacre",
      [ "DME" ] = "La Masacre: Ost",
      [ "DMN" ] = "La Masacre: Nord",
      [ "DMW" ] = "La Masacre: West",
      [ "STRAT" ] = "Stratholme",
      [ "SCHOLO" ] = "Scholomance",
      [ "LBRS" ] = "Cumbre de Roca Negra",
      [ "UBRS" ] = "Cumbre de Roca Negra (10)",
      [ "RAMPS" ] = "Hellfire Citadel: Ramparts",
      [ "BF" ] = "Hellfire Citadel: Blood Furnace",
      [ "SP" ] = "Coilfang Reservoir: Slave Pens",
      [ "UB" ] = "Coilfang Reservoir: Underbog",
      [ "MT" ] = "Auchindoun: Mana Tombs",
      [ "AC" ] = "Auchindoun: Auchenai Crypts",
      [ "SH" ] = "Auchindoun: Sethekk Halls",
      [ "OHF" ] = "Caverns of Time: Old Hillsbrad",
      [ "MECHA" ] = "Tempest Keep: The Mechanar",
      [ "BM" ] = "Caverns of Time: Black Morass",
      [ "MGT" ] = "Magisters' Terrace",
      [ "SHH" ] = "Hellfire Citadel: Shattered Halls",
      [ "BOTA" ] = "Tempest Keep: Botanica",
      [ "SL" ] = "Auchindoun: Shadow Labyrinth",
      [ "SV" ] = "Coilfang Reservoir: Steamvault",
      [ "ARCA" ] = "Tempest Keep: The Arcatraz",
      [ "KARA" ] = "Karazhan",
      [ "GRUULS" ] = "Gruul's Lair",
      [ "MAGS" ] = "Hellfire Citadel: Magtheridon's Lair",
      [ "SSC" ] = "Coilfang Reservoir: Serpentshrine Cavern",
      [ "EYE" ] = "The Eye",
      [ "ZA" ] = "Zul-Aman",
      [ "HYJAL" ] = "The Battle For Mount Hyjal",
      [ "BT" ] = "Black Temple",
      [ "SWP" ] = "Sunwell Plateau",
      [ "ONY" ] = "Guarida de Onyxia (25)",
      [ "MC" ] = "Núcleo de Magma (25)",
      [ "ZG" ] = "Zul'Gurub (10)",
      [ "AQ20" ] = "Ruinas de Ahn'Qiraj (10)",
      [ "BWL" ] = "Guarida Alanegra (25)",
      [ "AQ40" ] = "Ahn'Qiraj (25)",
      [ "NAXX" ] = "Naxxramas (25)",
      [ "ARENA" ] = "Arena (PvP)",
      [ "GM" ] = "Glittermurk Mines",
      [ "BH" ] = "Baradin Hold",
      [ "SC" ] = "Stonetalon Caverns",
      [ "ULDUM" ] = "Uldum (25)",

    },
    ruRU = {
      [ "AB" ] = "Низина Арати (PvP)",
      [ "AQ20" ] = "Руины Ан'Киража (10)",
      [ "AQ40" ] = "Ан'Кираж (25)",
      [ "AV" ] = "Альтеракская Долина (PvP)",
      [ "BAD" ] = "ОТЛАДКА ПЛОХИЕ СЛОВА - ОТКЛОНЕН",
      [ "BFD" ] = "Непроглядная Пучина",
      [ "BRD" ] = "Глубины Черной горы",
      [ "BWL" ] = "Логово Крыла Тьмы (25)",
      [ "DEBUG" ] = "ИНФОРМАЦИЯ О ОТЛАДКАХ",
      [ "DM" ] = "Мертвые копи",
      [ "DM2" ] = "Забытый Город",
      [ "DME" ] = "Забытый Город: Восток",
      [ "DMN" ] = "Забытый Город: Север",
      [ "DMW" ] = "Забытый Город: Запад",
      [ "GNOMER" ] = "Гномреган",
      [ "LBRS" ] = "Низ Вершины Черной горы",
      [ "MARA" ] = "Мародон",
      [ "MC" ] = "Огненные Недра (25)",
      [ "MISC" ] = "Прочее",
      [ "NAXX" ] = "Наксрамас (25)",
      [ "RAMPS" ] = "Цитадель Адского Пламени: Бастионы",
      [ "BF" ] = "Цитадель Адского Пламени: Кузня Крови",
      [ "SP" ] = "Резервуар Кривого Клыка: Узилище",
      [ "UB" ] = "Резервуар Кривого Клыка: Нижетопь",
      [ "MT" ] = "Аукиндон: Гробницы Маны",
      [ "AC" ] = "Аукиндон: Аукенайские гробницы",
      [ "SH" ] = "Аукиндон: Сетеккские залы",
      [ "OHF" ] = "Пещеры Времени: Старые предгорья Хилсбрада",
      [ "MECHA" ] = "Крепость Бурь: Механар",
      [ "BM" ] = "Пещеры Времени: Черные топи",
      [ "MGT" ] = "Терраса магистров",
      [ "SHH" ] = "Цитадель Адского Пламени: Разрушенные залы",
      [ "BOTA" ] = "Крепость Бурь: Ботаника",
      [ "SL" ] = "Аукиндон: Темный лабиринт",
      [ "SV" ] = "Резервуар Кривого Клыка: Паровое подземелье",
      [ "ARCA" ] = "Крепость Бурь: Аркатрац",
      [ "KARA" ] = "Каражан",
      [ "GRUULS" ] = "Логово Груула",
      [ "MAGS" ] = "Цитадель Адского Пламени: Логово Магтеридона",
      [ "SSC" ] = "Резервуар Кривого Клыка: Змеиное святилище",
      [ "EYE" ] = "Крепость Бурь: Око",
      [ "ZA" ] = "Зул'Аман",
      [ "HYJAL" ] = "Пещеры Времени: Вершина Хиджала",
      [ "BT" ] = "Черный Храм",
      [ "SWP" ] = "Плато Солнечного Колодца",
      [ "ONY" ] = "Логово Ониксии (25)",
      [ "RFC" ] = "Огненная пропасть",
      [ "RFD" ] = "Курганы Иглошкурых",
      [ "RFK" ] = "Лабиринты Иглошкурых",
      [ "SCHOLO" ] = "Некроситет",
      [ "SFK" ] = "Крепость Темного Клыка",
      [ "SM2" ] = "Монастырь Алого ордена",
      [ "ARMS" ] = "Монастырь Алого ордена: Оружейная",
      [ "CATH" ] = "Монастырь Алого ордена: Собор",
      [ "GY" ] = "Монастырь Алого ордена: Кладбище",
      [ "LIB" ] = "Монастырь Алого ордена: Библиотека",
      [ "ST" ] = "Затонувший Храм",
      [ "STOCKS" ] = "Тюрьма",
      [ "STRAT" ] = "Стратхольм",
      [ "TRADE" ] = "Торговля",
      [ "UBRS" ] = "Верх Вершины Черной горы (10)",
      [ "ULDA" ] = "Ульдаман",
      [ "WC" ] = "Пещеры Стенаний",
      [ "WSG" ] = "Ущелье Песни Войны (PvP)",
      [ "EOTS" ] = "Око Бури (PvP)",
      [ "ARENA" ] = "Arena (PvP)",
      [ "ZF" ] = "Зул'Фаррак",
      [ "ZG" ] = "Зул'Гуруб (10)",
      [ "GM" ] = "Glittermurk Mines",
      [ "BH" ] = "Baradin Hold",
      [ "SC" ] = "Stonetalon Caverns",
      [ "ULDUM" ] = "Uldum (25)",
    },
    zhTW = {
      [ "RFC" ] = "怒焰裂谷",
      [ "DM" ] = "死亡礦坑",
      [ "WC" ] = "哀嚎洞穴",
      [ "SFK" ] = "影牙城堡",
      [ "STOCKS" ] = "監獄",
      [ "BFD" ] = "黑暗深淵",
      [ "GNOMER" ] = "諾姆瑞根",
      [ "RFK" ] = "剃刀沼澤",
      [ "SM2" ] = "血色修道院",
      [ "GY" ] = "血色修道院: 墓地",
      [ "LIB" ] = "血色修道院: 圖書館",
      [ "ARMS" ] = "血色修道院: 軍械庫",
      [ "CATH" ] = "血色修道院: 大教堂",
      [ "RFD" ] = "剃刀高地",
      [ "ULDA" ] = "奧達曼",
      [ "ZF" ] = "祖爾法拉克",
      [ "MARA" ] = "瑪拉頓",
      [ "ST" ] = "阿塔哈卡神廟",
      [ "BRD" ] = "黑石深淵",
      [ "DM2" ] = "厄運之槌",
      [ "DME" ] = "厄運之槌: 東",
      [ "DMN" ] = "厄運之槌: 北",
      [ "DMW" ] = "厄運之槌: 西",
      [ "STRAT" ] = "斯坦索姆",
      [ "SCHOLO" ] = "通靈學院",
      [ "LBRS" ] = "黑石塔下層",
      [ "UBRS" ] = "黑石塔上層 (10)",
      [ "RAMPS" ] = "地獄火壁壘",
      [ "BF" ] = "血熔爐",
      [ "SP" ] = "奴隸監獄",
      [ "UB" ] = "深幽泥沼",
      [ "MT" ] = "法力墓地",
      [ "AC" ] = "奧奇奈地穴",
      [ "SH" ] = "塞司克大廳",
      [ "OHF" ] = "希爾斯布萊德丘陵舊址",
      [ "MECHA" ] = "麥克納爾",
      [ "BM" ] = "黑色沼澤",
      [ "MGT" ] = "博學者殿堂",
      [ "SHH" ] = "破碎大廳",
      [ "BOTA" ] = "波塔尼卡",
      [ "SL" ] = "暗影迷宮",
      [ "SV" ] = "蒸氣洞穴",
      [ "ARCA" ] = "亞克崔茲",
      [ "KARA" ] = "卡拉贊 (10)",
      [ "GRUULS" ] = "戈魯爾之巢 (25)",
      [ "MAGS" ] = "瑪瑟里頓的巢穴 (25)",
      [ "SSC" ] = "毒蛇神殿洞穴 (25)",
      [ "EYE" ] = "風暴要塞 (25)",
      [ "ZA" ] = "祖阿曼 (10)",
      [ "HYJAL" ] = "海加爾山 (25)",
      [ "BT" ] = "黑暗神廟 (25)",
      [ "SWP" ] = "太陽之井高地 (25)",
      [ "ONY" ] = "奧妮克希亞的巢穴 (25)",
      [ "MC" ] = "熔火之心 (25)",
      [ "ZG" ] = "祖爾格拉布 (10)",
      [ "AQ20" ] = "安其拉廢墟 (10)",
      [ "BWL" ] = "黑翼之巢 (25)",
      [ "AQ40" ] = "安其拉 (25)",
      [ "NAXX" ] = "納克薩瑪斯 (25)",
      [ "WSG" ] = "戰歌峽谷 (PvP)",
      [ "AB" ] = "阿拉希盆地 (PvP)",
      [ "AV" ] = "奧特蘭克山谷 (PvP)",
      [ "EOTS" ] = "暴風之眼 (PvP)",
      [ "MISC" ] = "未分類",
      [ "TRADE" ] = "交易",
      [ "GM" ] = "Glittermurk Mines",
      [ "BH" ] = "Baradin Hold",
      [ "SC" ] = "Stonetalon Caverns",
      [ "ULDUM" ] = "Uldum (25)",
    },
  }



  local dungeonNames = dungeonNamesLocales[ GetLocale() ] or {}

  if GroupBulletinBoardDB and GroupBulletinBoardDB.CustomLocalesDungeon and type( GroupBulletinBoardDB.CustomLocalesDungeon ) == "table" then
    for key, value in pairs( GroupBulletinBoardDB.CustomLocalesDungeon ) do
      if value ~= nil and value ~= "" then
        dungeonNames[ key .. "_org" ] = dungeonNames[ key ] or DefaultEnGB[ key ]
        dungeonNames[ key ] = value
      end
    end
  end


  setmetatable( dungeonNames, { __index = DefaultEnGB } )

  dungeonNames[ "DEADMINES" ] = dungeonNames[ "DM" ]

  return dungeonNames
end

local function Union( a, b )
  local result = {}
  for k, v in pairs( a ) do
    result[ k ] = v
  end
  for k, v in pairs( b ) do
    result[ k ] = v
  end
  return result
end

GBB.VanillaDungeonLevels = {
  [ "RFC" ] = { 13, 18 },
  [ "DM" ] = { 18, 23 },
  [ "WC" ] = { 15, 25 },
  [ "SFK" ] = { 22, 30 },
  [ "STOCKS" ] = { 22, 30 },
  [ "BFD" ] = { 24, 32 },
  [ "GNOMER" ] = { 29, 38 },
  [ "RFK" ] = { 30, 40 },
  [ "GY" ] = { 28, 38 },
  [ "LIB" ] = { 29, 39 },
  [ "ARMS" ] = { 32, 42 },
  [ "CATH" ] = { 35, 45 },
  [ "RFD" ] = { 40, 50 },
  [ "ULDA" ] = { 42, 52 },
  [ "ZF" ] = { 44, 54 },
  [ "MARA" ] = { 46, 55 },
  [ "ST" ] = { 50, 60 },
  [ "BRD" ] = { 52, 60 },
  [ "LBRS" ] = { 55, 60 },
  [ "DME" ] = { 58, 60 },
  [ "DMN" ] = { 58, 60 },
  [ "DMW" ] = { 58, 60 },
  [ "STRAT" ] = { 58, 60 },
  [ "SCHOLO" ] = { 58, 60 },
  [ "UBRS" ] = { 58, 60 },
  [ "ONY" ] = { 60, 60 },
  [ "MC" ] = { 60, 60 },
  [ "ZG" ] = { 60, 60 },
  [ "AQ20" ] = { 60, 60 },
  [ "BWL" ] = { 60, 60 },
  [ "AQ40" ] = { 60, 60 },
  [ "NAXX" ] = { 60, 60 },
  [ "WSG" ] = { 10, 70 },
  [ "AB" ] = { 20, 70 },
  [ "AV" ] = { 51, 70 },
  [ "MISC" ] = { 0, 100 },
  [ "DEBUG" ] = { 0, 100 },
  [ "BAD" ] = { 0, 100 },
  [ "TRADE" ] = { 0, 100 },
  [ "SM2" ] = { 28, 42 },
  [ "DM2" ] = { 58, 60 },
  [ "DEADMINES" ] = { 18, 23 },
  [ "GM" ] = { 39, 44 },
  [ "BH" ] = { 57, 60 },
  [ "SC" ] = { 57, 60 },
  [ "ULDUM" ] = { 60, 60 },
}

GBB.PostTbcDungeonLevels = {
  [ "RFC" ] = { 13, 20 },
  [ "DM" ] = { 16, 24 },
  [ "WC" ] = { 16, 24 },
  [ "SFK" ] = { 17, 25 },
  [ "STOCKS" ] = { 21, 29 },
  [ "BFD" ] = { 20, 28 },
  [ "GNOMER" ] = { 24, 40 },
  [ "RFK" ] = { 23, 31 },
  [ "GY" ] = { 28, 34 },
  [ "LIB" ] = { 30, 38 },
  [ "ARMS" ] = { 32, 42 },
  [ "CATH" ] = { 35, 44 },
  [ "RFD" ] = { 33, 41 },
  [ "ULDA" ] = { 36, 44 },
  [ "ZF" ] = { 42, 50 },
  [ "MARA" ] = { 40, 52 },
  [ "ST" ] = { 45, 54 },
  [ "BRD" ] = { 48, 60 },
  [ "LBRS" ] = { 54, 60 },
  [ "DME" ] = { 54, 61 },
  [ "DMN" ] = { 54, 61 },
  [ "DMW" ] = { 54, 61 },
  [ "STRAT" ] = { 56, 61 },
  [ "SCHOLO" ] = { 56, 61 },
  [ "UBRS" ] = { 53, 61 },
  [ "ONY" ] = { 60, 60 },
  [ "MC" ] = { 60, 60 },
  [ "ZG" ] = { 60, 60 },
  [ "AQ20" ] = { 60, 60 },
  [ "BWL" ] = { 60, 60 },
  [ "AQ40" ] = { 60, 60 },
  [ "NAXX" ] = { 60, 60 },
  [ "WSG" ] = { 10, 70 },
  [ "AB" ] = { 20, 70 },
  [ "AV" ] = { 51, 70 },
  [ "MISC" ] = { 0, 100 },
  [ "DEBUG" ] = { 0, 100 },
  [ "BAD" ] = { 0, 100 },
  [ "TRADE" ] = { 0, 100 },
  [ "SM2" ] = { 28, 42 },
  [ "DM2" ] = { 58, 60 },
  [ "DEADMINES" ] = { 16, 24 },
  [ "GM" ] = { 39, 44 },
  [ "BH" ] = { 57, 60 },
  [ "SC" ] = { 57, 60 },
  [ "ULDUM" ] = { 60, 60 },
}

GBB.TbcDungeonLevels     = {
  [ "RAMPS" ] = { 60, 62 },
  [ "BF" ] = { 61, 63 },
  [ "SP" ] = { 62, 64 },
  [ "UB" ] = { 63, 65 },
  [ "MT" ] = { 64, 66 },
  [ "AC" ] = { 65, 67 },
  [ "SH" ] = { 67, 69 },
  [ "OHF" ] = { 66, 68 },
  [ "MECHA" ] = { 69, 70 },
  [ "BM" ] = { 69, 70 },
  [ "MGT" ] = { 70, 70 },
  [ "SHH" ] = { 70, 70 },
  [ "BOTA" ] = { 70, 70 },
  [ "SL" ] = { 70, 70 },
  [ "SV" ] = { 70, 70 },
  [ "ARCA" ] = { 70, 70 },
  [ "KARA" ] = { 70, 70 },
  [ "GRUULS" ] = { 70, 70 },
  [ "MAGS" ] = { 70, 70 },
  [ "SSC" ] = { 70, 70 },
  [ "EYE" ] = { 70, 70 },
  [ "ZA" ] = { 70, 70 },
  [ "HYJAL" ] = { 70, 70 },
  [ "BT" ] = { 70, 70 },
  [ "SWP" ] = { 70, 70 },
  [ "EOTS" ] = { 15, 70 },
  [ "ARENA" ] = { 70, 70 },
  [ "BREW" ] = { 65, 70 },
  [ "HOLLOW" ] = { 65, 70 },
}

GBB.TbcDungeonNames      = {
  "RAMPS", "BF", "SHH", "MAGS", "SP", "UB", "SV", "SSC", "MT", "AC",
  "SH", "SL", "OHF", "BM", "MECHA", "BOTA", "ARCA", "EYE", "MGT", "KARA",
  "GRUULS", "ZA", "HYJAL", "BT", "SWP",
}

GBB.VanillDungeonNames   = {
  "RFC", "WC", "DM", "SFK", "STOCKS", "BFD", "GNOMER",
  "RFK", "GY", "LIB", "ARMS", "CATH", "RFD", "ULDA",
  "GM",
  "ZF", "MARA", "ST", "BRD", "LBRS",
  "UBRS",
  "DME", "DMN", "DMW",
  "STRAT", "SCHOLO",
  "SC",
  "ONY", "MC",
  "ULDUM",
  "BH", "BWL",
  "ZG",
  "AQ20",  "AQ40",
  "NAXX",
}


GBB.PvpNames = {
  "WSG", "AB", "AV", "EOTS", "ARENA",
}

GBB.Misc = { "MISC", "TRADE", }

GBB.DebugNames = {
  "DEBUG", "BAD", "NIL",
}

GBB.Raids = {
  "ONY", "MC", "ZG", "AQ20", "BWL", "AQ40", "NAXX",
  "KARA", "GRUULS", "MAGS", "SSC", "EYE", "ZA", "HYJAL",
  "BT", "SWP", "ARENA", "WSG", "AV", "AB", "EOTS",
  "BREW", "HOLLOW",
}

GBB.Seasonal = {
  [ "BREW" ] = { startDate = "09/19", endDate = "10/07" },
  [ "HOLLOW" ] = { startDate = "10/16", endDate = "11/01" }
}

GBB.SeasonalActiveEvents = {}
GBB.Events = getSeasonalDungeons()

function GBB.GetRaids()
  local arr = {}
  for _, v in pairs( GBB.Raids ) do
    arr[ v ] = 1
  end
  return arr
end

-- Needed because Lua sucks, Blizzard switch to Python please <- LMFAO
-- Takes in a list of dungeon lists, it will then concatenate the lists into a single list
-- it will put the dungeons in an order and give them a value incremental value that can be used for sorting later
-- ie one list "Foo" which contains "Bar" and "FooBar" and a second list "BarFoo" which contains "BarBar"
-- the output would be single list with "Bar" = 1, "FooBar" = 2, "BarFoo" = 3, "BarBar" = 4
local function ConcatenateLists( Names )
  local result = {}
  local index = 1
  for k, nameLists in pairs( Names ) do
    for _, v in pairs( nameLists ) do
      result[ v ] = index
      index = index + 1
    end
  end
  return result, index
end

function GBB.GetDungeonSort()
  for eventName, eventData in pairs( GBB.Seasonal ) do
    if GBB.Tool.InDateRange( eventData.startDate, eventData.endDate ) then
      table.insert( GBB.TbcDungeonNames, 1, eventName )
    else
      table.insert( GBB.DebugNames, 1, eventName )
    end
  end

  local dungeonOrder = { GBB.VanillDungeonNames, GBB.TbcDungeonNames, GBB.PvpNames, GBB.Misc, GBB.DebugNames }

  -- Why does Lua not having a fucking size function
  local vanillaDungeonSize = 0
  for _, _ in pairs( GBB.VanillDungeonNames ) do
    vanillaDungeonSize = vanillaDungeonSize + 1
  end

  local debugSize = 0
  for _, _ in pairs( GBB.DebugNames ) do
    debugSize = debugSize + 1
  end

  GBB.TBCDUNGEONSTART = vanillaDungeonSize + 1
  GBB.MAXDUNGEON = vanillaDungeonSize

  local tmp_dsort, concatenatedSize = ConcatenateLists( dungeonOrder )
  local dungeonSort = {}

  GBB.TBCMAXDUNGEON = concatenatedSize - debugSize - 1

  for dungeon, nb in pairs( tmp_dsort ) do
    dungeonSort[ nb ] = dungeon
    dungeonSort[ dungeon ] = nb
  end

  -- Need to do this because I don't know I am too lazy to debug the use of SM2, DM2, and DEADMINES
  dungeonSort[ "SM2" ] = 10.5
  dungeonSort[ "DM2" ] = 19.5
  dungeonSort[ "DEADMINES" ] = 99

  return dungeonSort
end

local function DetermineVanillDungeonRange()
  return GBB.PostTbcDungeonLevels
end

GBB.dungeonLevel = Union( DetermineVanillDungeonRange(), GBB.TbcDungeonLevels )
