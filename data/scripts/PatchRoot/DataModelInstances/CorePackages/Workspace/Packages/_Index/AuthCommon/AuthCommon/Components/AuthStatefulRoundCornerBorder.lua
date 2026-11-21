-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local Roact = require(AuthCommonParent.Roact)

local UIBlox = require(AuthCommonParent.UIBlox)
local withStyle = UIBlox.Style.withStyle

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local GetImageData = require(AuthCommonParent.RobloxAppAssets).GetImageData

local BorderState = { Hover = "Hover", Focused = "Focused", Error = "Error", Default = "Default" }

local var1 = Roact.PureComponent:extend("AuthStatefulRoundCornerBorder")

var1.defaultProps = {
    borderState = BorderState.Default
}

function var1.render(arg1)
    return withStyle(function(arg2)
        local size = arg1.props.size
        local borderState = arg1.props.borderState
        local layoutOrder = arg1.props.layoutOrder

        local prop = arg1.props[Roact.Children] or {}

        local uiDefaultColor = arg2.Theme.UIDefault.Color
        local uiDefaultTransparency = arg2.Theme.UIDefault.Transparency

        if borderState == BorderState.Focused then
            uiDefaultColor = arg2.Theme.IconEmphasis.Color
            uiDefaultTransparency = arg2.Theme.IconEmphasis.Transparency
        elseif borderState == BorderState.Hover then
            uiDefaultColor = arg2.Theme.IconDefault.Color
            uiDefaultTransparency = arg2.Theme.IconDefault.Transparency
        elseif borderState == BorderState.Error then
            uiDefaultColor = arg2.Theme.Alert.Color
            uiDefaultTransparency = arg2.Theme.Alert.Transparency
        end

        if arg1.props.borderColorOverride ~= nil then
            uiDefaultColor = arg1.props.borderColorOverride
        end
        if arg1.props.borderTransparencyOverride ~= nil then
            uiDefaultTransparency = arg1.props.borderTransparencyOverride
        end

        return Roact.createElement(
            "Frame",
            {
                Size = size,
                LayoutOrder = layoutOrder,
                BackgroundTransparency = 1,
                ClipsDescendants = true
            },
            {
                Boundary = Roact.createElement(ImageSetLabel, {
                    ZIndex = 2,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    ScaleType = Enum.ScaleType.Slice,
                    SliceCenter = Rect.new(9, 9, 9, 9),
                    Image = GetImageData("LuaApp/buttons/buttonStroke") or "LuaApp/buttons/buttonStroke",
                    ImageColor3 = uiDefaultColor,
                    ImageTransparency = uiDefaultTransparency
                }),
                ContentWrapper = Roact.createElement("Frame", { ZIndex = 1, Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1 }, prop)
            }
        )
    end)
end

var1.BorderState = BorderState

return var1
