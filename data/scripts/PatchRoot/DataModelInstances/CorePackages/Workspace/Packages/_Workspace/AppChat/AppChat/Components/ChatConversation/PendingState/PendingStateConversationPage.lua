-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _types = require(AppChat.types)
local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local memo = React.memo
local useCallback = React.useCallback
local useEffect = React.useEffect
local useRef = React.useRef
local useState = React.useState

local useStyle = require(AppChatParent.UIBlox).Core.Style.useStyle

local ConversationExitType = require(AppChat.Analytics.Enums.ConversationExitType)

local PendingStateIndicator = require(script.Parent.PendingStateIndicator)
local PendingStateModalContainer = require(script.Parent.PendingStateModalContainer)

local tbl1 = {
    topBarHeight = 0,
    networkErrorText = "PLACEHOLDER There was a network error, please try again later",
    onConversationUnmount = function(_) end,
    navigateToToast = function(_) end,
    navigateBack = function() end,
    shouldShowPhoneVerificationUpsell = false,
    shouldShowIneligibleModal = false
}

return memo(function(tbl2) -- name: PendingStateConversationPage
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2 = useStyle()
    local var3 = var1.style or var2

    local var4, var5 = useState(0)
    local onHeightChanged = useCallback(function(arg1)
        var5(arg1)
    end, { var5 })

    local showNetworkErrorToast = useCallback(function()
        var1.navigateToToast({ toastProps = { toastContent = { toastTitle = var1.networkErrorText } } })
    end, { var1.navigateToToast, var1.networkErrorText })

    local var8 = useRef(ConversationExitType.Default)

    local var9 = useCallback(function(_, swipeDirection, arg1)
        if not var1.wideMode and swipeDirection == Enum.SwipeDirection.Right and arg1 == 1 then
            var8.current = ConversationExitType.SwipedRight
            var1.navigateBack()
        end
    end, { var1.wideMode, var1.navigateBack })

    useEffect(function()
        return function()
            var1.onConversationUnmount(var8.current)

            var8.current = ConversationExitType.Default
        end
    end, {})

    return React.createElement("TextButton", {
        BackgroundColor3 = var3.Theme.BackgroundDefault.Color,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        Transparency = var3.Tokens.Color.None.Transparency,
        Text = "",
        LayoutOrder = var1.layoutOrder,
        [React.Event.TouchSwipe] = var9
    }, {
        UIListLayout = React.createElement(
            "UIListLayout",
            {
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        ),
        PendingStateIndicator = React.createElement(PendingStateIndicator, { layoutOrder = 1, size = UDim2.new(1, 0, 1, -var4) }),
        ConversationBottomModal = React.createElement(PendingStateModalContainer, {
            conversationId = var1.conversationId,
            showNetworkErrorToast = showNetworkErrorToast,
            layoutOrder = 2,
            onHeightChanged = onHeightChanged
        })
    })
end)
