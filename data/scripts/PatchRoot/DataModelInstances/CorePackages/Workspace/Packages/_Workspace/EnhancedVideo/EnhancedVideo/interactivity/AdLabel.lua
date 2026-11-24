-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:11:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local React = require(scriptParentParentParent.React)
local AdLabel = require(scriptParentParentParent.AdLabel).AdLabel

local EnhancedVideoStore = require(scriptParent.Parent.EnhancedVideoStore)
local useSignalState = require(scriptParentParentParent.SignalsReact).useSignalState

return React.memo(function(tbl1) -- name: AdLabelContainer
    local var1 = EnhancedVideoStore(false)
    local adDisclosureText = useSignalState(var1.getAdDisclosureText)
    local showAdPreferencesUrl = useSignalState(var1.getShowAdPreferencesUrl)
    return React.createElement(AdLabel, {
        sendPauseEvent = tbl1.sendPauseEvent,
        adDisclosureText = adDisclosureText,
        showAdPreferencesUrl = showAdPreferencesUrl
    })
end)
