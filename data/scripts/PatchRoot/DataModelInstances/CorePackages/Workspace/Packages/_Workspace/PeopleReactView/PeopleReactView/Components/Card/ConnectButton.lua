-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:21:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local React = require(PeopleReactViewParent.React)
local SignalsReact = require(PeopleReactViewParent.SignalsReact)

local Foundation = require(PeopleReactViewParent.Foundation)
local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local IconVariant = Foundation.Enums.IconVariant
local InputSize = Foundation.Enums.InputSize
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance
local IconButton = Foundation.IconButton
local View = Foundation.View

local PersonButtonConfigs = require(PeopleReactView.Configs.PersonButtonConfigs)
local useGetPeopleService = require(PeopleReactView.Hooks.useGetPeopleService)

return React.memo(function(tbl1) -- name: ConnectButton
    local var1 = useGetPeopleService("FriendStatusStore")
    local var2 = useGetPeopleService("Constants")

    local var3 = PersonButtonConfigs(tbl1.person.UserId)

    local var4 = React.useMemo(function()
        return var3[var2.PERSON_BUTTONS.ADD_FRIEND]
    end, { var3, var2.PERSON_BUTTONS.ADD_FRIEND })

    local var5 = SignalsReact.useSignalState(var1.getFriendStatus(tbl1.person.UserId))

    local var6 = SignalsReact.useSignalState(var1.getIsFriendButtonGrayedOut(tbl1.person.UserId))

    local icon = React.useMemo(function()
        if var5 then
            return {
                name = IconName.PersonCheck,
                variant = IconVariant.Filled
            }
        end

        if var6 then
            return {
                name = IconName.Clock,
                variant = IconVariant.Filled
            }
        end

        return {
            name = IconName.PersonPlus,
            variant = IconVariant.Regular
        }
    end, { var5, var6 })

    local isDisabled = SignalsReact.useSignalState(var1.getIsFriendButtonDisabled(tbl1.person.UserId))

    local onActivated = React.useCallback(function()
        var4.onActivated(var2.ANALYTICS.ENTRY_POINT.PEOPLE_CARD)
    end, { var4.onActivated, var2.ANALYTICS.ENTRY_POINT.PEOPLE_CARD })

    local createElement = React.createElement
    local var10 = View
    local tbl2 = {
        tag = "auto-xy",
        LayoutOrder = tbl1.layoutOrder,
        stateLayer = {
            affordance = StateLayerAffordance.None
        },
        onStateChanged = tbl1.onStateChanged
    }
    local tbl3 = {
        ConnectButton = React.createElement(IconButton, {
            icon = icon,
            variant = if isDisabled then ButtonVariant.Utility else ButtonVariant.Standard,
            size = tbl1.size or InputSize.Medium,
            isDisabled = isDisabled,
            Visible = var4.shouldShow(),
            onActivated = onActivated
        })
    }
    return createElement(var10, tbl2, tbl3)
end)
