-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local FFlagAppChatUseProfileFrameThumbnail = require(AppChat.Flags.FFlagAppChatUseProfileFrameThumbnail)

local React = require(AppChatParent.React)
local Foundation = require(AppChatParent.Foundation)
local SignalsReact = require(AppChatParent.SignalsReact)
local GetTextSize = require(AppChatParent.Style).GetTextSize

local useSignalState = SignalsReact.useSignalState

local GetSelectedUsersStore = require(AppChat.Stores.GetSelectedUsersStore)
local useUserData = require(AppChat.Hooks.useUserData)

local FFlagEnableBlackbirdCheck = require(AppChatParent.SharedFlags).FFlagEnableBlackbirdCheck
local useIsRobloxSubscriber = require(AppChatParent.UserProfiles).Hooks.useIsRobloxSubscriber
local FFlagDebugAppChatEnableDomLocators = require(AppChat.Flags.FFlagDebugAppChatEnableDomLocators)
local DomLocators = require(AppChat.Utils.DomLocators)

local function noOp() end

local str1 = string.rep("W", 20)

return React.memo(function(tbl1)
    local var1 = useUserData(tbl1.userId)
    local var2 = Foundation.Hooks.useTokens()

    local var3 = useIsRobloxSubscriber(if FFlagEnableBlackbirdCheck then tbl1.userId else nil)

    local selectedUsersStore = GetSelectedUsersStore(false)
    local isChecked = useSignalState(selectedUsersStore.getIsUserSelected(tbl1.userId))

    local onActivated = React.useCallback(function()
        selectedUsersStore.toggleUserId(tbl1.userId)
    end, { tbl1.userId })

    local var6 = React.useMemo(function(): UDim2
        local textSize = GetTextSize(str1, var2.Typography.TitleLarge.FontSize, var2.Typography.TitleLarge.Font, Vector2.zero)

        return UDim2.fromOffset(textSize.X, textSize.Y)
    end, { var2.Typography.TitleLarge.Font, var2.Typography.TitleLarge.FontSize })

    local var7 = React.useMemo(function(): UDim2
        local textSize = GetTextSize("Roblox Studio", var2.Typography.CaptionMedium.FontSize, var2.Typography.CaptionMedium.Font, Vector2.zero)

        return UDim2.fromOffset(textSize.X, textSize.Y)
    end, { var2.Typography.CaptionMedium.Font, var2.Typography.CaptionMedium.FontSize })

    local var8 = nil
    local var9 = nil
    if FFlagDebugAppChatEnableDomLocators then
        local var10
        var8, var10 = React.useState("")
        var9 = var10
        React.__subscribeToBinding(var1.username, function(arg1)
            var9(arg1)
        end)
    end

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = "row size-full-0 auto-y stroke-muted stroke-thin gap-medium padding-x-medium padding-y-small align-y-center",
        onActivated = onActivated,
        testId = if FFlagDebugAppChatEnableDomLocators then DomLocators.selectChatMembersUserCellWithCheckbox(var8, isChecked) else nil
    }

    local tbl3 = {
        Avatar = React.createElement(Foundation.Avatar, {
            userId = var1.id,
            userPresence = var1.presence,
            size = Foundation.Enums.InputSize.Medium,
            backgroundStyle = var2.Color.Shift.Shift_300,
            includeProfileFrame = FFlagAppChatUseProfileFrameThumbnail,
            LayoutOrder = 1
        }),
        UserInfo = 0,
        CheckboxContainer = 0
    }

    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = { tag = "col fill auto-y clip", LayoutOrder = 2 }

    local tbl5 = {
        UserDataSkeleton = React.createElement(
            Foundation.Skeleton,
            {
                Size = UDim2.new(var6.X, var6.Y + var7.Y),
                Visible = var1.isLoading,
                LayoutOrder = 1
            }
        ),
        DisplayNameRow = 0,
        DisplayName = 0,
        PresenceText = 0
    }
    local var10

    if FFlagEnableBlackbirdCheck then
        local createElement3 = React.createElement
        local view3 = Foundation.View

        local tbl6 = {
            tag = "row auto-xy align-y-center gap-xsmall",
            LayoutOrder = 1,
            Visible = var1.isLoading:map(function(arg1): boolean
                return not arg1
            end)
        }

        var10 = createElement3(view3, tbl6, {
            DisplayName = React.createElement(
                Foundation.Text,
                {
                    tag = "auto-xy text-title-large text-truncate-end content-emphasis",
                    Text = var1.combinedName,
                    LayoutOrder = 1
                }
            ),
            SubscriptionBadge = if var3 then React.createElement(Foundation.Icon, {
                LayoutOrder = 2,
                name = Foundation.Enums.IconName.RobloxPlus,
                size = Foundation.Enums.IconSize.Small,
                style = var2.Color.Content.Emphasis
            }) else nil
        })
    else
        var10 = nil
    end

    tbl5.DisplayNameRow = var10

    tbl5.DisplayName = if FFlagEnableBlackbirdCheck then nil else React.createElement(Foundation.Text, {
        tag = "auto-xy text-title-large text-truncate-end content-emphasis",
        Text = var1.combinedName,
        LayoutOrder = 1,
        Visible = var1.isLoading:map(function(arg1): boolean
            return not arg1
        end)
    })

    tbl5.PresenceText = React.createElement(Foundation.Text, {
        tag = "auto-xy text-caption-medium text-truncate-end content-muted",
        Text = var1.presenceText,
        LayoutOrder = 3,
        Visible = var1.isLoading:map(function(arg1): boolean
            return not arg1
        end)
    })

    tbl3.UserInfo = createElement2(view2, tbl4, tbl5)

    tbl3.CheckboxContainer = React.createElement(Foundation.View, {
        tag = "auto-xy padding-x-medium",
        onActivated = noOp,
        isDisabled = true,
        LayoutOrder = 3,
        selection = { Selectable = false }
    }, {
        checkbox = React.createElement(
            Foundation.Checkbox,
            {
                label = "",
                isChecked = isChecked,
                size = Foundation.Enums.InputSize.XSmall,
                onActivated = noOp,
                Selectable = false
            }
        )
    })
    return createElement(view, tbl2, tbl3)
end)
