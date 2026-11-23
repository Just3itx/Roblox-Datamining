-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _types = require(AppChat.types)
local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local useTelemetry = require(AppChat.Telemetry.useTelemetry)
local ChatDetailsTelemetryEvents = require(AppChat.Components.ChatDetails.ChatDetailsTelemetryEvents)
local ChatDetailsTelemetryLayer = require(AppChat.Telemetry.Layers.ChatDetailsTelemetryLayer)
local useEffectOnMount = require(AppChatParent.RoactUtils).Hooks.useEffectOnMount

local useStyle = require(AppChatParent.UIBlox).Core.Style.useStyle

local FlexIconWithTextCell = require(AppChat.Components.Cells.FlexIconWithTextCell)

local useTokens = require(AppChatParent.Foundation).Hooks.useTokens

local useIsInExperience = require(AppChat.Hooks.useIsInExperience)

local tbl1 = {
    bodyText = "Placeholder body",
    subTitleText = "Placeholder subtitle",
    iconImage = nil,
    cellHeight = 48,
    onActivated = function() end
}

local function CreateUnfilteredChatCell(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2 = useStyle()
    local style = var1.style or var2
    local var4 = useTokens()
    local var5 = useIsInExperience()
    local var6 = useTelemetry(ChatDetailsTelemetryLayer.Context)

    useEffectOnMount(function()
        var6.emit(ChatDetailsTelemetryEvents.ChatDetailsCreateUnfilteredChatCellRendered, {})
    end)

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = var1.layoutOrder,
        Size = UDim2.fromScale(1, 0)
    }
    local tbl4 = {
        CreateUnfilteredChatRow = React.createElement(FlexIconWithTextCell, {
            LayoutOrder = var1.layoutOrder,
            onActivated = var1.onActivated,
            primaryIcon = var1.iconImage,
            showDivider = false,
            Size = UDim2.new(1, 0, 0, var1.cellHeight),
            style = style,
            Text = var1.bodyText,
            SubTitleText = var1.subTitleText,
            isDisabled = var1.isLoading,
            BackgroundTransparency = if var5 then var4.Color.None.Transparency else nil
        })
    }
    return createElement(str1, tbl3, tbl4)
end

return CreateUnfilteredChatCell
