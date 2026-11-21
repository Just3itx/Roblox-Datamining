-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:11:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent
local UIBlox = require(AuthCommonParent.UIBlox)
local React = require(AuthCommonParent.React)
local Colors = require(AuthCommonParent.Style).Colors
local FunctionalCountryCodeSelectorButton = require(AuthCommon.Components.FunctionalCountryCodeSelectorButton)
local _Types = require(AuthCommon.Common.Types)
local useStyle = require(AuthCommonParent.UIBlox).Core.Style.useStyle
local GetImageData = require(AuthCommonParent.RobloxAppAssets).GetImageData
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local Graphite = Colors.Graphite

local function CountryCodeDropdownView(tbl1)
    local dropdownVisible = tbl1.dropdownVisible
    local countryCodeList = tbl1.countryCodeList
    local onCountryCodeSelected = tbl1.onCountryCodeSelected
    local position = tbl1.position
    local maxHeight = tbl1.maxHeight
    local var1 = useStyle()
    local uiDefaultColor = var1.Theme.UIDefault.Color
    local uiDefaultTransparency = var1.Theme.UIDefault.Transparency

    local function getListButtons(countryCodeList2)
        local tbl2 = { React.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }), React.createElement("UIPadding", { PaddingLeft = UDim.new(0, 8) }) }

        local num1 = 1

        for _, countryCode in ipairs(countryCodeList2) do
            table.insert(
                tbl2,
                React.createElement(FunctionalCountryCodeSelectorButton, {
                    CountryCode = countryCode,
                    Size = UDim2.new(1, 0, 0, 48),
                    LayoutOrder = num1,
                    ListButtonProps = { TextSize = 14, SelectionCallback = onCountryCodeSelected },
                    BoldPrefixEnabled = true
                })
            )

            local layoutOrder = num1 + 1

            table.insert(
                tbl2,
                React.createElement(
                    "Frame",
                    {
                        Size = UDim2.new(1, 0, 0, 1),
                        BackgroundColor3 = Graphite,
                        LayoutOrder = layoutOrder,
                        BorderSizePixel = 0
                    }
                )
            )

            num1 = layoutOrder + 1
        end

        return tbl2
    end

    local listButtons = getListButtons(countryCodeList)
    local countryCodeListLen = #countryCodeList

    if not dropdownVisible then
        return nil
    end

    return (React.createElement(ImageSetLabel, {
        ZIndex = 2,
        Size = tbl1.size or UDim2.new(1, 0, 0, maxHeight),
        Position = position,
        BackgroundTransparency = 1,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(9, 9, 9, 9),
        Image = GetImageData("LuaApp/buttons/buttonFill"),
        ImageColor3 = var1.Theme.BackgroundUIDefault.Color,
        ImageTransparency = 0
    }, {
        Boundary = React.createElement(ImageSetLabel, {
            ZIndex = 2,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(9, 9, 9, 9),
            Image = GetImageData("LuaApp/buttons/buttonStroke"),
            ImageColor3 = uiDefaultColor,
            ImageTransparency = uiDefaultTransparency
        }),
        ScrollingFrame = React.createElement("ScrollingFrame", {
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
            ScrollBarImageColor3 = Graphite,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            CanvasSize = UDim2.new(1, 0, 0, countryCodeListLen * 49)
        }, {
            ListHolder = React.createElement("Frame", { Size = UDim2.new(1, -8, 1, maxHeight), BackgroundTransparency = 1 }, listButtons)
        })
    }))
end

return CountryCodeDropdownView
