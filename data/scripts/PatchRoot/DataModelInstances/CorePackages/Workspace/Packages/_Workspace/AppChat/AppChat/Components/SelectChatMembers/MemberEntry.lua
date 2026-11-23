-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local FFlagAppChatUseProfileFrameThumbnail = require(AppChat.Flags.FFlagAppChatUseProfileFrameThumbnail)

local React = require(AppChatParent.React)
local Foundation = require(AppChatParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local useSignalState = require(AppChatParent.SignalsReact).useSignalState

local GetSelectedUsersStore = require(AppChat.Stores.GetSelectedUsersStore)
local useUserData = require(AppChat.Hooks.useUserData)

return React.memo(function(tbl1) -- name: MemberEntry
    local var1 = useTokens()
    local selectedUsersStore = GetSelectedUsersStore(false)
    local var2 = useSignalState(selectedUsersStore.getSelectedUserIdAtIndex(tbl1.index))

    local var3 = useUserData(var2 or "")

    local var4 = React.useCallback(function()
        if var2 then
            selectedUsersStore.removeUserId(var2)
        end
    end, { var2 })

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = { tag = "auto-xy", onActivated = 0, stateLayer = 0, LayoutOrder = 0 }

    if not var2 then
        var4 = nil
    end

    tbl2.onActivated = var4
    tbl2.stateLayer = {
        affordance = Foundation.Enums.StateLayerAffordance.None
    }
    tbl2.LayoutOrder = tbl1.index
    local tbl3 = { UserContainer = 0, RemoveIcon = 0 }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = { tag = "col size-0-full auto-x flex-x-fill align-x-center gap-xsmall" }

    local tbl5 = { Avatar = 0, Label = 0 }
    local element

    if var2 then
        element = React.createElement(Foundation.Avatar, {
            userId = var3.id,
            userPresence = var3.presence,
            size = Foundation.Enums.InputSize.Large,
            backgroundStyle = var1.Color.Shift.Shift_300,
            includeProfileFrame = FFlagAppChatUseProfileFrameThumbnail,
            LayoutOrder = 1
        })
    else
        element = React.createElement(Foundation.Image, {
            tag = "content-emphasis",
            Image = "rbxasset://textures/ui/LuaChatV2/ic-friend-empty-border.png",
            aspectRatio = {
                AspectRatio = 1,
                AspectType = Enum.AspectType.FitWithinMaxSize,
                DominantAxis = Enum.DominantAxis.Height
            },
            Size = UDim2.fromOffset(var1.Size.Size_1200, var1.Size.Size_1200),
            LayoutOrder = 1
        })
    end

    tbl5.Avatar = element

    tbl5.Label = React.createElement(Foundation.Text, {
        tag = "auto-y text-truncate-end text-caption-small",
        Text = var3.combinedName,
        textStyle = var1.Color.Content.Default,
        fontStyle = var1.Typography.CaptionSmall,
        LayoutOrder = 2
    })
    tbl3.UserContainer = createElement2(view2, tbl4, tbl5)
    local element2

    if var2 then
        element2 = React.createElement(
            Foundation.View,
            {
                tag = "auto-xy position-top-right anchor-top-right bg-over-media-0 radius-circle",
                ZIndex = 2
            },
            {
                Icon = React.createElement(Foundation.Icon, {
                    style = var1.Color.Content.Emphasis,
                    name = Foundation.Enums.IconName.CircleX,
                    variant = Foundation.Enums.IconVariant.Filled,
                    size = Foundation.Enums.IconSize.Small,
                    ZIndex = 2
                })
            }
        )
    else
        element2 = nil
    end

    tbl3.RemoveIcon = element2
    return createElement(view, tbl2, tbl3)
end)
