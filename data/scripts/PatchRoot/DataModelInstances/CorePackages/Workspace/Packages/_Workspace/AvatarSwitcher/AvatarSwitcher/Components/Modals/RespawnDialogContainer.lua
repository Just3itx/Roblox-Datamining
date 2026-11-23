-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarSwitcher = script:FindFirstAncestor("AvatarSwitcher")
local AvatarSwitcherParent = AvatarSwitcher.Parent

local React = require(AvatarSwitcherParent.React)
local SignalsReact = require(AvatarSwitcherParent.SignalsReact)
local useEventConnection = require(AvatarSwitcherParent.ReactUtils).useEventConnection
local sendAXCounterV2 = require(AvatarSwitcherParent.AvatarExperienceAnalytics).sendAXCounterV2

local RespawnChoiceDialog = require(AvatarSwitcher.Components.Modals.RespawnChoiceDialog)
local RespawnLaterDialog = require(AvatarSwitcher.Components.Modals.RespawnLaterDialog)
local getAvatarSwitcherStore = require(AvatarSwitcher.Stores.getAvatarSwitcherStore)
local respawnAvatar = require(AvatarSwitcher.Utils.respawnAvatar)
local Constants = require(AvatarSwitcher.Constants)

local FFlagAvatarSwitcherCounters = require(AvatarSwitcherParent.AvatarExperienceFlags).FFlagAvatarSwitcherCounters

local function RespawnDialogContainer(tbl1)
    local var1 = SignalsReact.useSignalState(getAvatarSwitcherStore)
    local var2 = SignalsReact.useSignalState(var1.getRespawnPromptShown)

    local var3, var4 = React.useState(function()
        local var3, _ = tbl1.getRespawnBehaviour()
        return var3
    end)
    useEventConnection(tbl1.respawnBehaviorChangedEvent.Event, var4, {})

    local onConfirm = React.useCallback(function()
        var1.toggleRespawnPrompt(false)
        tbl1.toggleWindow()
        if FFlagAvatarSwitcherCounters then
            sendAXCounterV2(Constants.Counters.ConfirmRespawn)
        end
        var1.switchAvatar()
        respawnAvatar(tbl1.getRespawnBehaviour)
    end, { tbl1.getRespawnBehaviour, tbl1.toggleWindow })

    local onDefer = React.useCallback(function()
        var1.toggleRespawnPrompt(false)
        tbl1.toggleWindow()
        if FFlagAvatarSwitcherCounters then
            sendAXCounterV2(Constants.Counters.DeferRespawn, { respawnEnabled = tostring(var3) })
        end
        var1.switchAvatar()
    end, { tbl1.toggleWindow })

    local onClose = React.useCallback(function()
        if FFlagAvatarSwitcherCounters then
            sendAXCounterV2(Constants.Counters.CancelSwitchAvatar)
        end
        var1.toggleRespawnPrompt(false)
    end, {})

    return React.createElement(React.Fragment, nil, {
        RespawnChoiceDialog = var2
            and var3
            and React.createElement(RespawnChoiceDialog, { onConfirm = onConfirm, onDefer = onDefer, onClose = onClose }),
        RespawnLaterDialog = var2 and not var3 and React.createElement(RespawnLaterDialog, { onDefer = onDefer, onClose = onClose })
    })
end

return RespawnDialogContainer
