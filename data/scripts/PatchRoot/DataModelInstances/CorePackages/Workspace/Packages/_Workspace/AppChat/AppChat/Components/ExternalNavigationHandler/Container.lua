-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local RoactRodux = require(AppChatParent.RoactRodux)
local ExternalNavigationHandler = require(script.Parent.ExternalNavigationHandler)
local mapStateToProps = require(script.Parent.mapStateToProps)
local mapDispatchToProps = require(script.Parent.mapDispatchToProps)

local FFlagAppChatUseSignalsForExternalNavigationRequest = require(AppChat.Flags.FFlagAppChatUseSignalsForExternalNavigationRequest)
local useSignalState = if FFlagAppChatUseSignalsForExternalNavigationRequest then require(AppChatParent.SignalsReact).useSignalState else nil
local GetExternalNavigationRequestStore = if FFlagAppChatUseSignalsForExternalNavigationRequest then require(AppChat.Stores.GetExternalNavigationRequestStore) else nil

local var1 = React.memo(function(arg1)
    local externalNavigationRequestStore = GetExternalNavigationRequestStore(false)
    local var1 = useSignalState(externalNavigationRequestStore.getRequest)

    return React.createElement(
        ExternalNavigationHandler,
        Cryo.Dictionary.join(
            arg1,
            var1,
            {
                completeExternalNavigation = externalNavigationRequestStore.completeExternalNavigation
            }
        )
    )
end)
if FFlagAppChatUseSignalsForExternalNavigationRequest then
    return var1
end

return (RoactRodux.connect(mapStateToProps, mapDispatchToProps)(ExternalNavigationHandler))
