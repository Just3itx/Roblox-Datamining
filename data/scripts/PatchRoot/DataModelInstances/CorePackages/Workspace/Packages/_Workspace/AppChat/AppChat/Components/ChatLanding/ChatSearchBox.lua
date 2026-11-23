-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)

local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization

local SearchTopBar = require(AppChat.Components.ChatLanding.SearchTopBar)

local tbl1 = {
    paddingTop = 0,
    paddingBottom = 6,
    paddingLeft = 12,
    paddingRight = 12,
    layoutOrder = -1
}

local function cancelCallback() end

return function(tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)
    local var2 = useLocalization({ searchPlaceholderText = "Feature.Chat.Label.SearchWord", cancelText = "Feature.Chat.Action.Cancel" })

    return React.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, var1.height - var1.paddingBottom - var1.paddingTop),
        LayoutOrder = var1.layoutOrder,
        BackgroundTransparency = 1
    }, {
        filterBox = React.createElement(SearchTopBar, {
            initialInputText = var1.initialText or "",
            cancelText = var2.cancelText,
            searchPlaceholderText = var2.searchPlaceholderText,
            shouldShowCancel = false,
            cancelCallback = cancelCallback,
            captureFocusOnMount = false,
            filterBoxPaddingTop = var1.paddingTop,
            filterBoxPaddingBottom = var1.paddingBottom,
            filterBoxPaddingLeft = var1.paddingLeft,
            filterBoxPaddingRight = var1.paddingRight,
            textChangedCallback = var1.onFilter
        }),
        heightFlexOverride = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.None })
    })
end
