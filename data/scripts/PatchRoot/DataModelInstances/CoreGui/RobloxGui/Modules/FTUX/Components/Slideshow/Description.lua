-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)
local UIBlox = require(CorePackages.Packages.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle

local scriptParentParentParent = script.Parent.Parent.Parent
local FTUXSlideshowData = require(scriptParentParentParent.Resources.FTUXSlideshowData)
local LuauPolyfill = require(CorePackages.Packages.LuauPolyfill)
local _PlatformEnum = require(scriptParentParentParent.Enums.PlatformEnum)
local withLocalization = require(CorePackages.Workspace.Packages.Localization).withLocalization

local function Description(tbl1)
    local var1 = useStyle()

    local theme = var1.Theme
    local font = var1.Font

    local text = FTUXSlideshowData[tbl1.platform][tbl1.currentIndex].text

    return withLocalization(text)(function(arg1)
        return React.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0.4, 0),
                Position = UDim2.new(0, 0, 0, 0),
                LayoutOrder = 2,
                BackgroundTransparency = 1
            },
            React.createElement("UIListLayout", {
                Padding = UDim.new(0, 0),
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            LuauPolyfill.Array.map(text, function(_, layoutOrder)
                return (React.createElement(UIBlox.App.Text.StyledTextLabel, {
                    text = arg1[layoutOrder],
                    fontStyle = font.CaptionBody,
                    colorStyle = theme.TextDefault,
                    textXAlignment = Enum.TextXAlignment.Left,
                    size = UDim2.new(1, 0, 1 / #text, 0),
                    layoutOrder = layoutOrder
                }))
            end)
        )
    end)
end

return Description
