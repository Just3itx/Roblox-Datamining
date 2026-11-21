-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfileBackground = script:FindFirstAncestor("EditProfileBackground")
local EditProfileBackgroundParent = EditProfileBackground.Parent
local React = require(EditProfileBackgroundParent.React)
local View = require(EditProfileBackgroundParent.Foundation).View
local ProfileBackgroundButton = require(EditProfileBackground.Components.ProfileBackgroundButton)
local Constants = require(EditProfileBackground.Common.Constants)

local function SelectionCarousel(tbl1)
    local var1, var2 = React.useState(tbl1.currentBackgroundId or Constants.BACKGROUND_ASSET_IDS[1])

    React.useEffect(function()
        if tbl1.currentBackgroundId then
            var2(tbl1.currentBackgroundId)
        end
    end, { tbl1.currentBackgroundId })

    local backgroundAssetIds = Constants.BACKGROUND_ASSET_IDS
    local buttonsPerRow = tbl1.buttonsPerRow
    local numRows = tbl1.numRows
    local buttonSize = tbl1.buttonSize

    local onActivated = React.useCallback(function(num1: number)
        var2(num1)

        task.delay(0.1, function()
            if tbl1.onBackgroundSelected then
                tbl1.onBackgroundSelected(num1)
            end
        end)
    end, { tbl1.onBackgroundSelected })

    local function renderRow(layoutOrder: number, num1: number, buttonsPerRow2: number)
        local tbl2 = {}

        table.insert(
            tbl2,
            React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 16)
            })
        )

        table.insert(tbl2, React.createElement("UIPadding", { PaddingLeft = UDim.new(0, 0), PaddingRight = UDim.new(0, 0) }))

        for i = num1, num1 + buttonsPerRow2 - 1 do
            local profileBackgroundId = backgroundAssetIds[i]
            local selected = var1 == profileBackgroundId

            table.insert(
                tbl2,
                React.createElement(ProfileBackgroundButton, {
                    LayoutOrder = i,
                    profileBackgroundId = profileBackgroundId,
                    selected = selected,
                    onActivated = onActivated,
                    buttonSize = buttonSize
                })
            )
        end

        return React.createElement(View, { LayoutOrder = layoutOrder, Size = UDim2.new(1, -32, 0, buttonSize) }, tbl2)
    end

    local var4 = React.useMemo(function()
        local result = {}

        table.insert(
            result,
            React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 16)
            })
        )

        table.insert(result, React.createElement(View, { LayoutOrder = 0, Size = UDim2.new(1, 0, 0, 0) }))

        local num1 = 1
        for i = 1, numRows do
            table.insert(result, renderRow(i, num1, buttonsPerRow))
            num1 += buttonsPerRow
        end

        return result
    end, { var1 })

    return React.createElement(View, { tag = "bg-surface-0", Size = UDim2.new(1, 0, 0, tbl1.height) }, var4)
end

return SelectionCarousel
