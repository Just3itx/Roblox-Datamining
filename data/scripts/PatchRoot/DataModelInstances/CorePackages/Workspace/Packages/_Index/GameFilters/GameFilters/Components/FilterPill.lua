-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameFilters = script:FindFirstAncestor("GameFilters")

local GameFiltersParent = GameFilters.Parent
local _DiscoveryTypes = require(GameFiltersParent.DiscoveryTypes)
local Foundation = require(GameFiltersParent.Foundation)
local IconPosition = Foundation.Enums.IconPosition
local ImpressionsTagUtility = require(GameFiltersParent.Impressions).ImpressionsTagUtility
local CentralOverlayType = require(GameFiltersParent.RobloxAppEnums).CentralOverlayType
local Chip = Foundation.Chip
local React = require(GameFiltersParent.React)

local SetCentralOverlay = require(GameFiltersParent.CentralOverlay).Actions.SetCentralOverlay

local useDispatch = require(GameFiltersParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useTokens = Foundation.Hooks.useTokens

local FilterClickButtonName = require(GameFilters.Analytics.FilterClickButtonName)
local _FilterMenuDropdown = require(GameFilters.Components.Menu.FilterMenuDropdown)
local OpenFilterMenuPeekView = require(GameFilters.OpenFilterMenuPeekView)
local shouldUsePeekView = require(GameFilters.Components.Menu.shouldUsePeekView)
local getOptionContextTag = require(GameFilters.Analytics.getOptionContextTag)

local FFlagLuaAppChartsFilterOptionTextTag = require(GameFiltersParent.SharedFlags).FFlagLuaAppChartsFilterOptionTextTag
local _FilterCallbackTypes = require(GameFilters.FilterCallbackTypes)

return React.memo(function(tbl1)
    local var1, var2 = React.useState(false)
    local var3 = var2

    local ref = React.useRef(nil)

    local var5 = useDispatch()
    local var6 = useTokens()

    local isChecked = React.useMemo(function(): boolean
        return not (tbl1.filter.inactiveOptionIds == nil or tbl1.filter.selectedOptionId == nil)
            and not tbl1.filter.inactiveOptionIds[tbl1.filter.selectedOptionId]
    end, { tbl1.filter.selectedOptionId, tbl1.filter.inactiveOptionIds }) or var1
    React.useEffect(function()
        local connection = if ref.current then ref.current:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            tbl1.onAbsoluteSizeChanged(ref.current)
        end) else nil

        return function()
            if connection then
                connection:Disconnect()
            end
        end
    end, { tbl1.onAbsoluteSizeChanged })

    React.useEffect(function()
        ImpressionsTagUtility.AddTag(ref, tbl1.impressionsTag, tbl1.index)

        return function()
            ImpressionsTagUtility.RemoveTag(ref, tbl1.impressionsTag, tbl1.index)
        end
    end, { tbl1.impressionsTag, tbl1.index })

    local sendFilterClick = React.useCallback(function(str1: string, str2: string, str3: string?, str4: string?, str5: string?, bool1: boolean?)
        tbl1.sendFilterClick(str1, tbl1.filter.filterId, str2, str3, str4, str5, bool1)
    end, { tbl1.sendFilterClick, tbl1.filter.filterId })

    local var9 = shouldUsePeekView()
    local onFilterMenuClosed = React.useCallback(function()
        var3(false)
    end, {})

    local onActivated = React.useCallback(function()
        local optionContextTag = if FFlagLuaAppChartsFilterOptionTextTag then getOptionContextTag(tbl1.filter, tbl1.filter.selectedOptionId) else nil

        if var9 then
            var5(OpenFilterMenuPeekView(tbl1.filter, tbl1.onFilterApplied, onFilterMenuClosed, sendFilterClick))

            local var11 = sendFilterClick
            local openPeekView = FilterClickButtonName.OpenPeekView
            local selectedOptionId = tbl1.filter.selectedOptionId
            local var12 = nil
            if not FFlagLuaAppChartsFilterOptionTextTag then
                optionContextTag = nil
            end

            var11(openPeekView, selectedOptionId, var12, optionContextTag, nil, isChecked)
        else
            local tbl2 = {
                openPosition = if ref.current then Vector2.new(
                    ref.current.AbsolutePosition.X,
                    ref.current.AbsolutePosition.Y + ref.current.AbsoluteSize.Y + var6.Gap.Small
                ) else nil,
                filter = tbl1.filter,
                onFilterApplied = tbl1.onFilterApplied,
                onFilterMenuClosed = onFilterMenuClosed,
                sendFilterClick = sendFilterClick
            }
            var5(SetCentralOverlay(CentralOverlayType.GameFilterMenuDropdown, tbl2))

            local var11 = sendFilterClick
            local openDropdown = FilterClickButtonName.OpenDropdown
            local selectedOptionId = tbl1.filter.selectedOptionId
            local var12 = nil
            if not FFlagLuaAppChartsFilterOptionTextTag then
                optionContextTag = nil
            end

            var11(openDropdown, selectedOptionId, var12, optionContextTag, nil, isChecked)
        end

        var3(true)
    end, {
        tbl1.filter,
        tbl1.onFilterApplied,
        onFilterMenuClosed,
        sendFilterClick,
        var9,
        isChecked
    })

    return React.createElement(Chip, {
        icon = {
            name = "icons/actions/truncationExpand_small",
            position = IconPosition.Right
        },
        text = tbl1.filter.selectedOptionDisplayName,
        isChecked = isChecked,
        onActivated = onActivated,
        ref = ref
    })
end)
