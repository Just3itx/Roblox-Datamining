-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:51:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local ContextActionService = game:GetService("ContextActionService")

local React = require(PurchasePromptParent.React)
local useLocalization = require(PurchasePromptParent.Localization).Hooks.useLocalization

local _VIPServerJoinView = require(script.Parent.VIPServerJoinView)
local _types = require(PurchasePrompt.types)

local tbl1 = { event_type = "show", component = "join_private_server_modal" }

local tbl2 = {
    event_type = "click",
    component = "private_server_config",
    subcomponent = "join_now_btn"
}
local tbl3 = {
    event_type = "click",
    component = "private_server_config",
    subcomponent = "not_now_btn"
}

local function useVIPServerJoinViewModel(tbl4)
    local locales = useLocalization({
        title = "Feature.PrivateServers.Label.YourPrivateServerIsReadyToJoin",
        join = "Common.VisitGame.Label.Play",
        somethingWentWrong = "CommonUI.Messages.Response.SomethingWentWrong"
    })

    local isJoining, var3 = React.useState(false)
    local hasError, var5 = React.useState(false)

    local var6 = React.useRef(false)
    local var7 = React.useRef(nil)

    React.useEffect(function()
        tbl4.logEvent(tbl1)
    end, {})

    React.useEffect(function()
        return function()
            if var7.current then
                var7.current()
            end
        end
    end, {})

    local onJoin = React.useCallback(function()
        if var6.current then
            return
        end
        var6.current = true
        var3(true)
        var5(false)
        tbl4.logEvent(tbl2)

        var7.current = tbl4.teleport(tbl4.vipServerAccessCode, function()
            var6.current = false
            var3(false)
            var5(true)
        end)
    end, { tbl4.teleport, tbl4.vipServerAccessCode, tbl4.logEvent })

    local var9 = React.useCallback(function()
        tbl4.logEvent(tbl3)
        tbl4.onClose()
    end, { tbl4.onClose, tbl4.logEvent })

    local var10 = React.useRef(var9)
    var10.current = var9

    React.useEffect(function()
        ContextActionService:BindCoreAction("VIPServerJoinCloseButtonBind", function(_, userInputState)
            if userInputState == Enum.UserInputState.Begin then
                var10.current()
            end
        end, false, Enum.KeyCode.ButtonB)
        return function()
            ContextActionService:UnbindCoreAction("VIPServerJoinCloseButtonBind")
        end
    end, {})

    return {
        locales = locales,
        serverName = tbl4.serverName,
        gameName = tbl4.gameName,
        thumbnailUrl = tbl4.thumbnailUrl,
        hasError = hasError,
        isJoining = isJoining,
        onJoin = onJoin,
        onClose = var9,
        focusRootRef = tbl4.focusRootRef,
        joinButtonRef = tbl4.joinButtonRef
    }
end

return useVIPServerJoinViewModel
