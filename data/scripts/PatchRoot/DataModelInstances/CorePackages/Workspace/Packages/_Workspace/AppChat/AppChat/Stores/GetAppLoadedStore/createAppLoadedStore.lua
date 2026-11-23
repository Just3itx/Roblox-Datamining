-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local _Signals = require(AppChatParent.Signals)
local createSessionScopedSignal = require(AppChatParent.SignalsUtils).createSessionScopedSignal

local function createAppLoadedStore()
    local getAppLoaded, var2 = createSessionScopedSignal(false)

    return {
        getAppLoaded = getAppLoaded,
        setAppLoaded = function(bool1: boolean)
            var2(bool1)
        end
    }
end
return createAppLoadedStore
