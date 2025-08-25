local TOCNAME, GBB = GroupBulletinBoard_Loader.Main()
local ChannelIDs
local ChkBox_FilterDungeon
--Options
-------------------------------------------------------------------------------------

local function CheckBox( Var, Init )
  return GBB.Options.AddCheckBox( GBB.DB, Var, Init, GBB.L[ "Cbox" .. Var ] )
end
local function CheckBoxChar( Var, Init )
  return GBB.Options.AddCheckBox( GBB.DBChar, Var, Init, GBB.L[ "CboxChar" .. Var ] )
end
local function CheckBoxFilter( Dungeon, Init )
  return GBB.Options.AddCheckBox( GBB.DBChar, "FilterDungeon" .. Dungeon, Init,
    GBB.dungeonNames[ Dungeon ] .. " " .. GBB.LevelRange( Dungeon, true ) )
end
local function CreateEditBoxNumber( Var, Init, width, width2 )
  return GBB.Options.AddEditBox( GBB.DB, Var, Init, GBB.L[ "Edit" .. Var ], width, width2, true )
end
local function CreateEditBox( Var, Init, width, width2 )
  return GBB.Options.AddEditBox( GBB.DB, Var, Init, GBB.L[ "Edit" .. Var ], width, width2, false )
end

local function CreateEditBoxDungeon( Dungeon, Init, width, width2 )
  -- delete old settings
  if GBB.DB[ "Custom_" .. Dungeon ] ~= nil then
    GBB.DB.Custom[ Dungeon ] = GBB.DB[ "Custom_" .. Dungeon ]
    GBB.DB[ "Custom_" .. Dungeon ] = nil
  end
  if GBB.dungeonNames[ Dungeon ] then
    GBB.Options.AddEditBox( GBB.DB.Custom, Dungeon, Init,
      GBB.dungeonNames[ Dungeon ] .. " " .. GBB.LevelRange( Dungeon, true ),
      width, width2, false, nil, GBB.Tool.Combine( GBB.dungeonTagsLoc[ "enGB" ][ Dungeon ] ) )
  else
    local txt = ""
    if Dungeon == "Search" then
      txt = GBB.Tool.Combine( GBB.searchTagsLoc[ "enGB" ] )
    elseif Dungeon == "Bad" then
      txt = GBB.Tool.Combine( GBB.badTagsLoc[ "enGB" ] )
    elseif Dungeon == "Suffix" then
      txt = GBB.Tool.Combine( GBB.suffixTagsLoc[ "enGB" ] )
    elseif Dungeon == "Heroic" then
      txt = GBB.Tool.Combine( GBB.heroicTagsLoc[ "enGB" ] )
    end

    GBB.Options.AddEditBox( GBB.DB.Custom, Dungeon, Init, GBB.L[ "EditCustom_" .. Dungeon ], width, width2, false, nil,
      txt )
  end
end


local function FixFilters()
  for ip, p in pairs( GBB.dungeonSecondTags ) do
    if ip ~= "DEATHMINES" then
      GBB.DBChar[ "FilterDungeon" .. ip ] = false
      for is, subDungeon in pairs( p ) do
        GBB.DBChar[ "FilterDungeon" .. ip ] = GBB.DBChar[ "FilterDungeon" .. ip ] or
            GBB.DBChar[ "FilterDungeon" .. subDungeon ]
      end
    end
  end

  for eventName, eventData in pairs( GBB.Seasonal ) do
    if GBB.Tool.InDateRange( eventData.startDate, eventData.endDate ) == false then
      GBB.DBChar[ "FilterDungeon" .. eventName ] = false
    end
  end
end

local isChat = false
function GBB.OptionsUpdate()
  FixFilters()

  if GBB.DB.ChatStyle and GBB.DB.CompactStyle then
    if isChat then
      GBB.DB.ChatStyle = false
    else
      GBB.DB.CompactStyle = false
    end
  end

  if GBB.DB.EnableGroup then
    GBB.Tool.TabShow( GroupBulletinBoardFrame )
  else
    GBB.Tool.SelectTab( GroupBulletinBoardFrame, 1 )
    GBB.Tool.TabHide( GroupBulletinBoardFrame )
  end

  GBB.CreateTagList()
  do
    local button = GBB.MinimapButton
    if button.db.visible then
      button.Show()
    else
      button.Hide()
    end
  end
  
  GBB.ClearNeeded = true

  isChat = GBB.DB.ChatStyle
end

local DoSelectFilter = function( state, ChkBox, Start, Max )
  for index = Start, Max do ---trade -misc
    ChkBox[ index ]:SetChecked( state )
  end
end

local DoRightClick = function( self )
  DoSelectFilter( false )
  self:SetChecked( true )
end

function GBB.Options.PopulateChannelNames()
  local t = GBB.PhraseChannelList( GetChannelList() )
  for i = 1, 20 do
    if i < 20 then
      _G[ ChannelIDs[ i ]:GetName() .. "Text" ]:SetText( i .. ". " .. (t[ i ] and t[ i ].name or "") )
    else
      _G[ ChannelIDs[ i ]:GetName() .. "Text" ]:SetText( (t[ i ] and t[ i ].name or "") )
    end
  end
end

function SetChatOption()
  GBB.Options.AddCategory( GBB.L[ "HeaderChannel" ] )
  GBB.Options.Indent( 10 )

  ChannelIDs = {}
  for i = 1, 10 do
    GBB.Options.InLine()
    ChannelIDs[ i ] = GBB.Options.AddCheckBox( GBB.DBChar.channel, i, true, i .. ". ", 125 )
    ChannelIDs[ i + 10 ] = GBB.Options.AddCheckBox( GBB.DBChar.channel, i + 10, true, (i + 10) .. ". ", 125 )

    GBB.Options.EndInLine()
  end

  GBB.Options.Indent( -10 )
  GBB.Options.PopulateChannelNames()
end

function GBB.OptionsInit()
  GBB.Options.Init(
    function() -- ok button			
      GBB.Options.DoOk()
      if GBB.DB.TimeOut < 60 then GBB.DB.TimeOut = 60 end
      GBB.OptionsUpdate()
    end,
    function() -- Cancel/init button
      GBB.Options.PopulateChannelNames()
      GBB.Options.DoRefresh()
    end,
    function() -- default button
      GBB.Options.DoDefault()
      GBB.DB.MinimapButton.position = 40
      GBB.ResetWindow()
      GBB.OptionsUpdate()
      GBB.Options.PopulateChannelNames()
    end
  )

  GBB.Options.SetScale( 0.85 )

  -- First panel - Settings
  GBB.Options.AddPanel( GBB.Title, false, true )

  --GBB.Options.AddVersion('|cff00c0ff' .. GBB.Version .. '|r')

  GBB.Options.AddCategory( GBB.L[ "HeaderSettings" ] )
  GBB.Options.Indent( 10 )

  GBB.Options.AddCheckBox( GBB.DB.MinimapButton, "visible", true, GBB.L[ "Cboxshowminimapbutton" ] )
  GBB.Options.AddCheckBox( GBB.DB.MinimapButton, "lock", false, GBB.L[ "CboxLockMinimapButton" ] )
  GBB.Options.AddCheckBox( GBB.DB.MinimapButton, "lockDistance", true, GBB.L[ "CboxLockMinimapButtonDistance" ] )
  GBB.Options.AddSpace()
  CheckBox( "ShowTotalTime", false )
  CheckBox( "OrderNewTop", true )
  GBB.Options.AddSpace()
  GBB.Options.AddText( GBB.L[ "msgFontSize" ], -20 )
  GBB.Options.AddDrop( GBB.DB, "FontSize", "GameFontNormal",
    { "GameFontNormalSmall", "GameFontNormal", "GameFontNormalLarge" } )

  CheckBox( "CombineSubDungeons", false )
  GBB.Options.AddSpace()
  CheckBox( "NotifySound", false )
  CheckBox( "NotifyChat", false )
  GBB.Options.Indent( 20 )
  CheckBox( "NotfiyInnone", true )
  CheckBox( "NotfiyInpvp", false )
  CheckBox( "NotfiyInparty", true )
  CheckBox( "NotfiyInraid", false )
  CheckBox( "OneLineNotification", false )
  GBB.Options.AddColorButton( GBB.DB, "NotifyColor", { r = 1, g = 1, b = 1, a = 1 }, GBB.L[ "BtnNotifyColor" ], 150 )
  GBB.Options.Indent( -20 )
  GBB.Options.AddSpace()
  CheckBox( "ColorOnLevel", true )
  CheckBox( "UseAllInLFG", true )
  CheckBox( "EscapeQuit", true )
  CheckBox( "DisplayLFG", true )
  GBB.Options.AddSpace()
  GBB.Options.InLine()
  CheckBox( "ColorByClass", true )
  CheckBox( "ShowClassIcon", true )
  GBB.Options.EndInLine()
  CheckBox( "RemoveRaidSymbols", true )
  CheckBox( "FilterNonAsciiMessages", false )
  CheckBox( "ChatStyle", false )
  CheckBox( "CompactStyle", false )
  CheckBox( "DontTrunicate", false )
  CheckBox( "EnableShowOnly", false )
  GBB.Options.Indent( 20 )
  CreateEditBoxNumber( "ShowOnlyNb", 4, 50 )
  GBB.Options.AddColorButton( GBB.DB, "EntryColor", { r = 1, g = 1, b = 1, a = 1 }, GBB.L[ "BtnEntryColor" ], 150 )
  GBB.Options.AddColorButton( GBB.DB, "HeroicDungeonColor", { r = 1, g = 0, b = 0, a = 1 }, GBB.L
    [ "BtnHeroicDungeonColor" ], 150 )
  GBB.Options.AddColorButton( GBB.DB, "NormalDungeonColor", { r = 0, g = 1, b = 0, a = 1 }, GBB.L
    [ "BtnNormalDungeonColor" ], 150 )
  GBB.Options.AddColorButton( GBB.DB, "TimeColor", { r = 1, g = 1, b = 1, a = 1 }, GBB.L[ "BtnTimeColor" ], 150 )
  GBB.Options.Indent( -20 )
  GBB.Options.AddSpace()
  CreateEditBoxNumber( "TimeOut", 150, 50 )

  GBB.Options.AddSpace()
  CheckBox( "AdditionalInfo", false )
  CheckBox( "EnableGroup", false )
  GBB.Options.Indent( 18 )
  GBB.Options.AddColorButton( GBB.DB, "PlayerNoteColor", { r = 1, g = 0.8, b = 0.2, a = 1 },
    GBB.L[ "BtnPlayerNoteColor" ], 150 )
  GBB.Options.Indent( -21 )
  GBB.Options.AddSpace()

  CheckBox( "EnableGuild", false )
  GBB.Options.Indent( 20 )
  GBB.Options.AddColorButton( GBB.DB, "ColorGuild", { a = 1, r = .2, g = 1, b = .2 }, GBB.L[ "BtnColorGuild" ], 150 )
  GBB.Options.Indent( -23 )
  GBB.Options.AddSpace()
  CheckBox( "OnDebug", false )

  -- Main Filter panel
  GBB.Options.AddPanel( GBB.L[ "PanelFilter" ] )
  GBB.Options.AddCategory( GBB.L[ "HeaderDungeon" ] )
  GBB.Options.Indent( 10 )

  local defaultChecked = false

  ChkBox_FilterDungeon = {}
  for index = 1, GBB.DUNGEONBREAK do
    ChkBox_FilterDungeon[ index ] = CheckBoxFilter( GBB.dungeonSort[ index ], defaultChecked )
  end

  GBB.Options.SetRightSide()
  --GBB.Options.AddCategory("")
  GBB.Options.Indent( 10 )
  for index = GBB.DUNGEONBREAK + 1, GBB.MAXDUNGEON do
    ChkBox_FilterDungeon[ index ] = CheckBoxFilter( GBB.dungeonSort[ index ], defaultChecked )
  end

  --GBB.Options.AddSpace()
  CheckBoxChar( "FilterLevel", false )
  CheckBoxChar( "DontFilterOwn", false )

  -- CheckBoxChar( "HeroicOnly", false )
  -- CheckBoxChar( "NormalOnly", false )

  --GBB.Options.AddSpace()

  GBB.Options.InLine()
  GBB.Options.AddButton( GBB.L[ "BtnSelectAll" ], function()
    DoSelectFilter( true, ChkBox_FilterDungeon, 1, GBB.MAXDUNGEON )
  end )
  GBB.Options.AddButton( GBB.L[ "BtnUnselectAll" ], function()
    DoSelectFilter( false, ChkBox_FilterDungeon, 1, GBB.MAXDUNGEON )
  end )
  GBB.Options.EndInLine()

  GBB.Options.Indent( -10 )

  --GBB.Options.AddSpace()
  SetChatOption()

  -- Tags
  GBB.Options.AddPanel( GBB.L[ "PanelTags" ], false, true )

  GBB.Options.AddCategory( GBB.L[ "HeaderTags" ] )
  GBB.Options.Indent( 10 )
  GBB.Options.InLine()
  local locale = GetLocale()
  CheckBox( "TagsEnglish", locale == "enUS" or locale == "enGB" )
  CheckBox( "TagsGerman", locale == "deDE" )
  CheckBox( "TagsRussian", locale == "ruRU" )
  CheckBox( "TagsFrench", locale == "frFR" )
  CheckBox( "TagsZhtw", locale == "zhTW" )

  CheckBox( "TagsCustom", true )
  GBB.Options.EndInLine()
  GBB.Options.Indent( -10 )

  GBB.Options.AddCategory( GBB.L[ "HeaderTagsCustom" ] )
  GBB.Options.Indent( 10 )
  GBB.Options.AddText( GBB.L[ "msgCustomList" ], 450 + 200 )
  GBB.Options.AddSpace()
  CreateEditBoxDungeon( "Search", "", 450, 200 )
  CreateEditBoxDungeon( "Bad", "", 450, 200 )
  CreateEditBoxDungeon( "Suffix", "", 450, 200 )
  CreateEditBoxDungeon( "Heroic", "", 450, 200 )

  GBB.Options.AddSpace()
  for index = 1, GBB.MAXDUNGEON do
    CreateEditBoxDungeon( GBB.dungeonSort[ index ], "", 445, 200 )
  end
  GBB.Options.AddSpace()
  CreateEditBoxDungeon( "SM2", "", 445, 200 )
  CreateEditBoxDungeon( "DM2", "", 445, 200 )
  CreateEditBoxDungeon( "DEADMINES", "", 445, 200 )
  GBB.Options.Indent( -10 )

  -- localization
  GBB.Options.AddPanel( GBB.L[ "PanelLocales" ], false, true )
  GBB.Options.AddText( GBB.L[ "msgLocalRestart" ] )
  GBB.Options.AddSpace()
  local locales = GBB.locales.enGB
  local t = {}
  for key, value in pairs( locales ) do
    table.insert( t, key )
  end
  table.sort( t )
  for _, key in ipairs( t ) do
    local col = GBB.L[ key ] ~= nil and "|cffffffff" or "|cffff4040"
    local txt = GBB.L[ key .. "_org" ] ~= "[" .. key .. "_org]" and GBB.L[ key .. "_org" ] or GBB.L[ key ]

    GBB.Options.AddEditBox( GBB.DB.CustomLocales, key, "", col .. "[" .. key .. "]", 450, 200, false, locales[ key ], txt )
  end
  --locales dungeons
  GBB.Options.AddSpace()
  locales = getmetatable( GBB.dungeonNames ).__index
  for i = 1, GBB.MAXDUNGEON do
    local key = GBB.dungeonSort[ i ]

    local col = GBB.dungeonNames[ key ] ~= locales[ key ] and "|cffffffff" or "|cffff4040"

    local txt = GBB.dungeonNames[ key .. "_org" ] ~= nil and GBB.dungeonNames[ key .. "_org" ] or GBB.dungeonNames
        [ key ]

    GBB.Options.AddEditBox( GBB.DB.CustomLocalesDungeon, key, "", col .. locales[ key ], 450, 200, false, locales[ key ],
      txt )
  end
  -- About
  local function SlashText( txt )
    GBB.Options.AddText( txt )
  end

  local about_panel = GBB.Options.AddPanel( GBB.L[ "PanelAbout" ] )

  GBB.Options.AddCategory( "|cFF209FF9" ..
    GetAddOnMetadata( TOCNAME, "Title" ) ..
    " " .. GetAddOnMetadata( TOCNAME, "Version" ) )
  GBB.Options.Indent( 7 )
  local hl = GBB.colors.highlight
  local author = GetAddOnMetadata( TOCNAME, "Author" )
  local portedBy = "Ported from Classic by Obszczymucha (aka Ohhaimark) for"
    .. " Stormforge Netherwing, then ported to WotLK by fondlez."
  GBB.Options.AddText( portedBy, -30, nil, true)
  GBB.Options.Indent( -7 )

  GBB.Options.AddCategory( GBB.L[ "HeaderSlashCommand" ] )
  GBB.Options.Indent( 10 )
  GBB.Options.AddText( GBB.L[ "AboutSlashCommand" ], -20 )
  GBB.Tool.PrintSlashCommand( nil, nil, SlashText )
  GBB.Options.Indent( -10 )

  GBB.Options.AddCategory( GBB.L[ "HeaderCredits" ] )
  GBB.Options.Indent( 10 )
  GBB.Options.AddText( GBB.L[ "AboutCredits" ], -20 )
  GBB.Options.AddText( GBB.L[ "AboutCreditsClassic" ], -20 )
  GBB.Options.Indent( -10 )

  FixFilters()
end
