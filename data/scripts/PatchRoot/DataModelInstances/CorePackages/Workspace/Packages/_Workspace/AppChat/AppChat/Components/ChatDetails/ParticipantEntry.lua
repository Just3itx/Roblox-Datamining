-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local FFlagAppChatUseProfileFrameThumbnail = require(AppChat.Flags.FFlagAppChatUseProfileFrameThumbnail)

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local Foundation = require(AppChatParent.Foundation)
local GetTextSize = require(AppChatParent.Style).GetTextSize

local useUserData = require(AppChat.Hooks.useUserData)
local useTokens = Foundation.Hooks.useTokens
local FFlagEnableBlackbirdCheck = require(AppChatParent.SharedFlags).FFlagEnableBlackbirdCheck
local useIsRobloxSubscriber = require(AppChatParent.UserProfiles).Hooks.useIsRobloxSubscriber

local str1 = string.rep("W", 20)

local tbl1 = { showDivider = true }

return React.memo(function(tbl2) -- name: ParticipantEntry
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)
    local var2 = useUserData(var1.userId)
    local var3 = useTokens()

    local var4 = useIsRobloxSubscriber(if FFlagEnableBlackbirdCheck then var1.userId else nil)

    local var5 = React.useCallback(function()
        if var1.onActivated then
            var1.onActivated()
        end
    end, { var1.onActivated })

    local var6 = React.useMemo(function(): UDim2
        local textSize = GetTextSize(str1, var3.Typography.TitleLarge.FontSize, var3.Typography.TitleLarge.Font, Vector2.zero)

        return UDim2.fromOffset(textSize.X, textSize.Y)
    end, { var3.Typography.TitleLarge.Font, var3.Typography.TitleLarge.FontSize })

    local var7 = React.useMemo(function(): UDim2
        local textSize = GetTextSize("Roblox Studio", var3.Typography.CaptionMedium.FontSize, var3.Typography.CaptionMedium.Font, Vector2.zero)

        return UDim2.fromOffset(textSize.X, textSize.Y)
    end, { var3.Typography.CaptionMedium.Font, var3.Typography.CaptionMedium.FontSize })

    local createElement = React.createElement
    local view = Foundation.View
    local tbl3 = {
        Name = "ParticipantEntryContainer",
        tag = {
            ["row align-y-center gap-medium size-full padding-x-medium"] = true,
            ["stroke-thin stroke-muted"] = var1.showDivider
        },
        onActivated = 0
    }
    if not var1.onActivated then
        var5 = nil
    end

    tbl3.onActivated = var5
    local tbl4 = {
        Avatar = React.createElement(Foundation.Avatar, {
            userId = var2.id,
            userPresence = var2.presence,
            size = Foundation.Enums.InputSize.Medium,
            backgroundStyle = var3.Color.Shift.Shift_300,
            includeProfileFrame = FFlagAppChatUseProfileFrameThumbnail,
            LayoutOrder = 1
        }),
        UserInfo = 0,
        ChildrenContainer = 0
    }

    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl5 = { tag = "col fill auto-y clip", LayoutOrder = 2 }

    local tbl6 = {
        UserDataSkeleton = React.createElement(
            Foundation.Skeleton,
            {
                Size = UDim2.new(var6.X, var6.Y + var7.Y),
                Visible = var2.isLoading,
                LayoutOrder = 1
            }
        ),
        DisplayName = 0,
        PresenceText = 0
    }
    local element

    if FFlagEnableBlackbirdCheck and var4 then
        element = React.createElement(Foundation.View, {
            tag = "row align-y-center gap-xxsmall auto-xy",
            LayoutOrder = 1,
            Visible = var2.isLoading:map(function(arg1): boolean
                return not arg1
            end)
        }, {
            NameText = React.createElement(Foundation.Text, {
                tag = "shrink auto-xy text-title-large text-truncate-end content-emphasis",
                Text = var2.combinedName,
                LayoutOrder = 1
            }),
            SubscriptionBadge = React.createElement(Foundation.Icon, {
                LayoutOrder = 2,
                name = Foundation.Enums.IconName.RobloxPlus,
                size = Foundation.Enums.IconSize.Small,
                style = var3.Color.Content.Emphasis
            })
        })
    else
        element = React.createElement(Foundation.Text, {
            tag = "auto-xy text-title-large text-truncate-end content-emphasis",
            Text = var2.combinedName,
            LayoutOrder = 1,
            Visible = var2.isLoading:map(function(arg1): boolean
                return not arg1
            end)
        })
    end

    tbl6.DisplayName = element

    tbl6.PresenceText = React.createElement(Foundation.Text, {
        tag = "auto-xy text-caption-medium text-truncate-end content-muted",
        Text = if var1.statusText then var2.presenceText:map(function(str2: string)
            return str2 .. " . " .. var1.statusText
        end) else var2.presenceText,
        LayoutOrder = 3,
        Visible = var2.isLoading:map(function(arg1): boolean
            return not arg1
        end)
    })

    tbl4.UserInfo = createElement2(view2, tbl5, tbl6)

    tbl4.ChildrenContainer = if var1.children then React.createElement(Foundation.View, {
        tag = "row align-x-right align-y-center auto-y",
        LayoutOrder = 3,
        selection = { Selectable = false },
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        }
    }, var1.children) else nil
    return createElement(view, tbl3, tbl4)
end)
