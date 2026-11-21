-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceStoreServerDrivenUiParent = script:FindFirstAncestor("ExperienceStoreServerDrivenUi").Parent

local React = require(ExperienceStoreServerDrivenUiParent.React)
local FFlagSduiLocalFeedFilter = require(ExperienceStoreServerDrivenUiParent.SharedFlags).FFlagSduiLocalFeedFilter
local Foundation = require(ExperienceStoreServerDrivenUiParent.Foundation)
local Chip = Foundation.Chip
local ScrollView = Foundation.ScrollView
local View = Foundation.View
local ChipSize = Foundation.Enums.ChipSize
local Visibility = Foundation.Enums.Visibility

local scroll = {
    AutomaticCanvasSize = Enum.AutomaticSize.X,
    AutomaticSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.fromScale(0, 0),
    ScrollingDirection = Enum.ScrollingDirection.X,
    scrollBarVisibility = Visibility.None
}

local selection = { Selectable = false }

local var1 = React.memo(function(tbl3) -- name: PillTab
    local optionId = tbl3.optionId
    local onSelect = tbl3.onSelect

    local onActivated = React.useCallback(function()
        onSelect(optionId)
    end, { onSelect, optionId })

    return React.createElement(Chip, {
        text = tbl3.displayName,
        isChecked = tbl3.isChecked,
        size = tbl3.chipSize,
        LayoutOrder = tbl3.layoutOrder,
        onActivated = onActivated
    })
end)

return React.memo(function(tbl3) -- name: SduiPillTabsCarousel
    local options = tbl3.options
    local onOptionActivated = tbl3.onOptionActivated
    local chipSize = tbl3.chipSize or ChipSize.Medium

    local selectedOption = tbl3.selectedOption
    if FFlagSduiLocalFeedFilter then
        if selectedOption == nil or selectedOption == "" then
            selectedOption = tbl3.defaultOption
        end
    else
        selectedOption = if selectedOption == nil or selectedOption == "" then "all" else selectedOption
    end

    local var3 = React.useRef(onOptionActivated)
    React.useEffect(function()
        var3.current = onOptionActivated
    end, { onOptionActivated })

    React.useEffect(function()
        local defaultOption = tbl3.defaultOption

        if not FFlagSduiLocalFeedFilter
            or tbl3.selectedOption ~= nil and tbl3.selectedOption ~= ""
            or defaultOption == nil
            or defaultOption == ""
        then
            return
        end

        local current = var3.current
        if current then
            current(nil, nil, { selectedCategoryId = defaultOption })
        end
    end, { tbl3.defaultOption, tbl3.selectedOption })

    local onSelect = React.useCallback(function(selectedCategoryId: string)
        local current = var3.current
        if current then
            current(nil, nil, { selectedCategoryId = selectedCategoryId })
        end
    end, {})

    local var5 = React.useMemo(function()
        local result = ({})
        if not options then
            return result
        end
        for layoutOrder, option in options do
            local optionId = option.optionId
            local var5 = "Pill_" .. optionId
            result[var5] = React.createElement(var1, {
                optionId = optionId,
                displayName = option.displayName,
                isChecked = optionId == selectedOption,
                chipSize = chipSize,
                layoutOrder = layoutOrder,
                onSelect = onSelect
            })
        end
        return result
    end, {
        options,
        selectedOption,
        onSelect,
        chipSize
    })
    local tag = React.useMemo(function()
        local tbl4 = { ["size-full-0 auto-y"] = true }
        if tbl3.tag then
            tbl4[tbl3.tag] = true
        end
        return tbl4
    end, { tbl3.tag })

    if not options or #options == 0 then
        return nil
    end

    return React.createElement(
        ScrollView,
        {
            LayoutOrder = tbl3.layoutOrder,
            tag = tag,
            scroll = scroll,
            selection = selection
        },
        {
            Row = React.createElement(View, { tag = "row gap-small auto-xy" }, var5)
        }
    )
end)
