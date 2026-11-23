-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local useSignalState = require(AppChatParent.SignalsReact).useSignalState
local getDeepValue = require(AppChat.Utils.getDeepValue)
local GetAppLoadedStore = require(AppChat.Stores.GetAppLoadedStore)

local FFlagAppChatUseSignalsForAppLoaded = require(AppChat.Flags.FFlagAppChatUseSignalsForAppLoaded)

return function()
    if FFlagAppChatUseSignalsForAppLoaded then
        return useSignalState(GetAppLoadedStore(false).getAppLoaded)
    end

    return useSelector(function(arg1)
        return getDeepValue(arg1, "ChatAppReducer.AppLoaded") or false
    end)
end
