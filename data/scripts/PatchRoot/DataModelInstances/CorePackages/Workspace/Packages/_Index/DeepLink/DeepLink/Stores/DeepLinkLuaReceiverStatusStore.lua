-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DeepLink = script:FindFirstAncestor("DeepLink")
local DeepLinkParent = DeepLink.Parent

local Signals = require(DeepLinkParent.Signals)
local DeepLinkLuaPostAuthReceiverStatus = require(DeepLink.Enums.DeepLinkLuaPostAuthReceiverStatus)

return Signals.createComputed(function() -- name: createDeepLinkConnectionStore
    local getLastDetectedPostAuthUrl, setLastDetectedPostAuthUrl = Signals.createSignal(nil)
    local getDeepLinkLuaPostAuthReceiverStatus, var4 = Signals.createSignal(DeepLinkLuaPostAuthReceiverStatus.Disconnected)

    return {
        setDeepLinkLuaPostAuthReceiverStatus = function(ready, str1: string?)
            if ready ~= DeepLinkLuaPostAuthReceiverStatus.Ready then
                setLastDetectedPostAuthUrl(nil)
            elseif str1 then
                setLastDetectedPostAuthUrl(str1)
            end
            var4(ready)
        end,
        getDeepLinkLuaPostAuthReceiverStatus = getDeepLinkLuaPostAuthReceiverStatus,
        setLastDetectedPostAuthUrl = setLastDetectedPostAuthUrl,
        getLastDetectedPostAuthUrl = getLastDetectedPostAuthUrl
    }
end)
