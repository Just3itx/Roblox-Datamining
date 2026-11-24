-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChatService = game:GetService("TextChatService")

local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)
local useCursor = require(ExpChatParent.UIBlox).App.SelectionCursor.useCursor

local Localization = require(ExpChat.Localization)
local Config = require(ExpChat.Config)
local useInterpolatedClientSettings = require(ExpChat.ClientSettings.useInterpolatedClientSettings)

local engineFeature = game:GetEngineFeature("EnableChatButtonTelemetryEnabled")

local FFlagExpChatNewInputBar = require(ExpChat.Flags.FFlagExpChatNewInputBar)

local function setTransparency(arg1, transparencyValue) -- Luacid: Inlined by compiler; 3 call sites recovered
    return transparencyValue:map(function(num1: number): number
        return arg1 + num1 * (1 - arg1)
    end)
end

return Localization.connect(function()
    return { EnableChatButtonText = "CoreScripts.TextChat.EnableChatButton.Label.UnlockChat" }
end)(function(tbl1) -- name: EnableChatButton
    local selectionImageObject = useCursor()

    local isSpatialUiEnabled = tbl1.isSpatialUIEnabled
    local chatWindowSettings = tbl1.chatWindowSettings

    local backgroundTransparency = useInterpolatedClientSettings(chatWindowSettings).BackgroundTransparency
    local backgroundColor3 = useInterpolatedClientSettings(chatWindowSettings).BackgroundColor3

    React.useEffect(function()
        if engineFeature and tbl1.visible then
            TextChatService:SendEnableChatButtonShown()
        end
    end, { tbl1.visible })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = backgroundColor3,
        BackgroundTransparency = if FFlagExpChatNewInputBar then 1 else setTransparency(backgroundTransparency, tbl1.transparencyValue),
        BorderSizePixel = 0,
        LayoutOrder = tbl1.LayoutOrder,
        Size = UDim2.fromScale(1, 0),
        Visible = tbl1.visible,
        ZIndex = 2,
        [React.Event.MouseEnter] = tbl1.onHovered,
        [React.Event.MouseLeave] = tbl1.onUnhovered
    }
    local tbl3 = {
        UIPadding = React.createElement("UIPadding", {
            PaddingLeft = if FFlagExpChatNewInputBar then nil else UDim.new(0, 8),
            PaddingRight = if FFlagExpChatNewInputBar then nil else UDim.new(0, 8),
            PaddingTop = tbl1.addTopPadding and UDim.new(0, 8) or UDim.new(0, 0),
            PaddingBottom = UDim.new(0, 1)
        }),
        EnableChatButton = 0
    }
    local createElement2 = React.createElement
    local str2 = "TextButton"
    local tbl4 = {
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundColor3 = Config.EnableChatButtonBackgroundColor,
        BackgroundTransparency = setTransparency(Config.EnableChatButtonBackgroundTransparency, tbl1.transparencyValue),
        Size = UDim2.fromScale(1, 0),
        FontFace = Config.EnableChatButtonFontFace,
        Selectable = true,
        SelectionImageObject = selectionImageObject,
        Text = if tbl1.EnableChatButtonText == nil then "Unlock chat" elseif tbl1.EnableChatButtonText == "" then "Unlock chat" else tbl1.EnableChatButtonText,
        TextColor3 = Config.ChatInputBarTextColor3,
        TextSize = if isSpatialUiEnabled then Config.ChatInputBarSpatialPanelTextSize else Config.ChatInputBarTextSize,
        TextTransparency = setTransparency(0, tbl1.transparencyValue),
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
        ZIndex = 2
    }

    tbl4[React.Event.Activated] = function()
        if engineFeature then
            TextChatService:SendEnableChatButtonClicked()
        end
        tbl1.onActivated()
    end

    tbl3.EnableChatButton = createElement2(str2, tbl4, {
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),
        UIPadding = React.createElement("UIPadding", {
            PaddingBottom = UDim.new(0, 10),
            PaddingLeft = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10),
            PaddingTop = UDim.new(0, 10)
        })
    })
    return createElement(str1, tbl2, tbl3)
end)
