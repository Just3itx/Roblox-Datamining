-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _types = require(AppChat.types)
local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)

local UIBlox = require(AppChatParent.UIBlox)
local useEffect = React.useEffect
local useMemo = React.useMemo
local useStyle = UIBlox.Core.Style.useStyle
local ButtonStack = UIBlox.App.Button.ButtonStack
local enum = UIBlox.App.Button.Enum

local Foundation = require(AppChatParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local useChatPagePadding = require(AppChat.Contexts.ChatPagePadding.useChatPagePadding)
local useIsInExperience = require(AppChat.Hooks.useIsInExperience)

local tbl1 = {
    bodyText = "Placeholder body",
    onHeightChanged = function(_) end,
    onAccepted = nil,
    onDenied = nil
}

local function ConversationModal(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2 = useStyle()
    local var3 = var1.style or var2
    local var4 = useTokens()
    local var5 = useIsInExperience()

    local size1000 = var3.Tokens.Size.Size_1000
    local size500 = var3.Tokens.Size.Size_500
    local var6 = useChatPagePadding()

    useEffect(function()
        return function()
            var1.onHeightChanged(0)
        end
    end, {})

    local buttons = useMemo(function()
        local result = {}
        if var1.denyText then
            table.insert(result, {
                buttonType = enum.ButtonType.Secondary,
                props = {
                    onActivated = var1.onDenied,
                    text = var1.denyText,
                    isDisabled = var1.loading
                }
            })
        end
        if var1.acceptText then
            table.insert(result, {
                buttonType = enum.ButtonType.PrimarySystem,
                props = {
                    onActivated = var1.onAccepted,
                    text = var1.acceptText,
                    isDisabled = var1.loading
                }
            })
        end
        return result
    end, {
        var1.acceptText,
        var1.denyText,
        var1.loading,
        var1.onDenied,
        var1.onAccepted
    })
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        Name = "ConversationModal",
        BackgroundTransparency = if var5 then var4.Color.OverMedia.OverMedia_100.Transparency else var3.Theme.SystemPrimaryContent.Transparency,
        BackgroundColor3 = if var5 then var4.Color.OverMedia.OverMedia_100.Color3 else var3.Theme.SystemPrimaryContent.Color,
        BorderSizePixel = 0,
        LayoutOrder = var1.layoutOrder,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y
    }

    tbl3[React.Change.AbsoluteSize] = function(arg1)
        var1.onHeightChanged(arg1.AbsoluteSize.Y)
    end
    local tbl4 = {
        ContentPadding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, if var1.paddingTop == nil then size500 else var1.paddingTop),
            PaddingBottom = UDim.new(0, if var1.paddingBottom == nil then size500 else var1.paddingBottom),
            PaddingLeft = UDim.new(0, var6.left),
            PaddingRight = UDim.new(0, var6.right)
        }),
        UIListLayout = 0,
        Body = 0,
        Buttons = 0
    }
    local createElement2 = React.createElement
    local str2 = "UIListLayout"
    local tbl5 = {
        FillDirection = Enum.FillDirection.Vertical,
        Padding = 0,
        SortOrder = 0,
        VerticalAlignment = 0
    }
    local new = UDim.new
    local num1 = 0

    if var1.verticalSpacing ~= nil then
        size500 = var1.verticalSpacing
    end

    tbl5.Padding = new(num1, size500)
    tbl5.SortOrder = Enum.SortOrder.LayoutOrder
    tbl5.VerticalAlignment = Enum.VerticalAlignment.Top
    tbl4.UIListLayout = createElement2(str2, tbl5)

    tbl4.Body = React.createElement("TextLabel", {
        BackgroundTransparency = 1,
        TextSize = var3.Tokens.FontSize.FontSize_300,
        FontFace = normalizeFontFace(var4.Typography.BodyLarge.Font),
        LayoutOrder = 1,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Text = var1.bodyText,
        TextWrapped = true,
        TextColor3 = var3.Theme.TextDefault.Color,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    })
    tbl4.Buttons = if #buttons > 0 then React.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            LayoutOrder = 2,
            Size = UDim2.new(1, 0, 0, size1000)
        },
        {
            ButtonStack = React.createElement(ButtonStack, { forcedFillDirection = Enum.FillDirection.Horizontal, buttons = buttons })
        }
    ) else nil
    return createElement(str1, tbl3, tbl4)
end

return ConversationModal
