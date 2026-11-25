-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)
local SignalsReact = require(scriptParentParentParent.SignalsReact)
local Display = require(scriptParentParentParent.Display)
local Cryo = require(scriptParentParentParent.Cryo)

local Foundation = require(scriptParentParentParent.Foundation)
local useScaledValue = Foundation.Hooks.useScaledValue
local useTokens = Foundation.Hooks.useTokens

local LayoutValuesContext = require(script.Parent.LayoutValuesContext)

local FFlagEnableMobilePlayerListOnConsole = require(scriptParentParent.Flags.FFlagEnableMobilePlayerListOnConsole)
local FFlagPlayerListDropDownShowPlatformName = require(scriptParentParent.Flags.FFlagPlayerListDropDownShowPlatformName)

local function useLayoutValues()
    local var1 = React.useContext(LayoutValuesContext)

    local var2 = useTokens()
    local var3 = if FFlagEnableMobilePlayerListOnConsole then useScaledValue(var1.PlayerDropDownSizeX * 10) / 10 else nil
    local var4 = if FFlagEnableMobilePlayerListOnConsole then useScaledValue((var1.EntryBaseSizeX or 150) * 10) / 10 else nil
    local var5 = if FFlagEnableMobilePlayerListOnConsole then useScaledValue(var1.PlayerDropDownSizeXMobile * 10) / 10 else nil
    local var6 = if FFlagEnableMobilePlayerListOnConsole then useScaledValue(var1.PlayerNameSizeXMobile * 10) / 10 else nil
    local playerListSizeMin = if FFlagEnableMobilePlayerListOnConsole then useScaledValue(500) else nil
    local playerListSizeMax = if FFlagEnableMobilePlayerListOnConsole then useScaledValue(600) else nil
    local var9 = if FFlagEnableMobilePlayerListOnConsole then nil else SignalsReact.useSignalState(Display.GetDisplayStore)
    local var10 = if FFlagEnableMobilePlayerListOnConsole then nil else SignalsReact.useSignalState(var9.getUIScale)
    local size100 = var2.Size.Size_100

    local tbl1 = {
        PlayerListSizeMin = playerListSizeMin,
        PlayerListSizeMax = playerListSizeMax,
        ContainerPadding = size100,
        ContainerPosition = UDim2.new(1, -size100, 0, size100),
        ExtraContainerPadding = var2.Size.Size_400
    }
    if not FFlagEnableMobilePlayerListOnConsole then
        var3 = var1.PlayerDropDownSizeX * var10
    end

    tbl1.PlayerDropDownSizeX = var3

    tbl1.PlayerDropDownOffset = var2.Size.Size_100

    if var1.EntryBaseSizeX then
        if not FFlagEnableMobilePlayerListOnConsole then
            var4 = var1.EntryBaseSizeX * var10
        end
    else
        var4 = nil
    end

    tbl1.EntryBaseSizeX = var4

    tbl1.EntrySizeIncreasePerStat = var2.Size.Size_300
    tbl1.PlayerEntrySizeY = var2.Size.Size_1000
    tbl1.TeamEntrySizeY = var2.Size.Size_600
    tbl1.TeamNameTextSize = if FFlagEnableMobilePlayerListOnConsole then var2.FontSize.FontSize_300 else nil

    tbl1.StatEntrySizeX = var2.Size.Size_1600
    tbl1.TitleBarTextSize = if FFlagEnableMobilePlayerListOnConsole then var2.FontSize.FontSize_250 else nil

    tbl1.TitleBarSizeY = var2.Size.Size_500

    tbl1.PlayerIconSize = UDim2.new(0, var2.Size.Size_400, 0, var2.Size.Size_400)
    tbl1.InitalPlayerEntryPadding = var2.Size.Size_300
    tbl1.PlayerEntryPadding = var2.Size.Size_300
    tbl1.PlayerEntryNamePadding = var2.Size.Size_100
    tbl1.StatTextPadding = var2.Size.Size_100

    tbl1.PlayerNameSize = UDim2.new(1, -var2.Size.Size_900, 1, 0)
    tbl1.PlayerNameTextSize = var2.FontSize.FontSize_300
    tbl1.StatTextSize = var2.FontSize.FontSize_300

    tbl1.ScrollBarOffset = var2.Size.Size_100
    tbl1.ScrollBarSize = var2.Size.Size_200

    if not FFlagEnableMobilePlayerListOnConsole then
        var5 = var1.PlayerDropDownSizeXMobile * var10
    end

    tbl1.PlayerDropDownSizeXMobile = var5

    tbl1.ScrollBarSizeMobile = var2.Size.Size_50
    if not FFlagEnableMobilePlayerListOnConsole then
        var6 = var1.PlayerNameSizeXMobile * var10
    end

    tbl1.PlayerNameSizeXMobile = var6

    tbl1.PlayerIconSizeMobile = UDim2.fromOffset(var2.Size.Size_500, var2.Size.Size_500)
    tbl1.PlayerNameTextSizeMobile = var2.FontSize.FontSize_350
    tbl1.StatTextSizeMobile = var2.FontSize.FontSize_350
    tbl1.PlayerNamePaddingXMobile = var2.Size.Size_350
    tbl1.TeamEntryTextPadding = var2.Size.Size_400
    tbl1.TeamEntryTextPaddingMobile = var2.Size.Size_350

    tbl1.PlayerIconBackgroundSize = UDim2.new(0, 66, 0, 66)

    tbl1.DropDownButtonSizeY = var2.Size.Size_1400
    tbl1.DropDownButtonTextSize = if FFlagEnableMobilePlayerListOnConsole then var2.FontSize.FontSize_400 else nil

    tbl1.DropDownPadding = var2.Size.Size_250
    tbl1.DropDownRightOptionSize = var2.Size.Size_1400
    tbl1.DropDownIconSize = var2.Size.Size_900
    tbl1.DropDownHeaderSizeY = var2.Size.Size_2000
    tbl1.DropDownHeaderBackgroundSize = if FFlagPlayerListDropDownShowPlatformName then var2.Size.Size_1800 else var2.Size.Size_1600

    tbl1.DropDownHeaderDisplayNameTextSize = if FFlagEnableMobilePlayerListOnConsole then var2.FontSize.FontSize_400 else nil

    tbl1.DropDownHeaderPlayerNameTextSize = if FFlagEnableMobilePlayerListOnConsole then var2.FontSize.FontSize_300 else nil

    tbl1.DropDownScreenSidePadding = size100

    tbl1.PlayerScrollListSizeTwoTabsOnLegacy = UDim2.new(1, 0, 1, -var2.Size.Size_1100)

    return Cryo.Dictionary.join(var1, tbl1)
end

return useLayoutValues
