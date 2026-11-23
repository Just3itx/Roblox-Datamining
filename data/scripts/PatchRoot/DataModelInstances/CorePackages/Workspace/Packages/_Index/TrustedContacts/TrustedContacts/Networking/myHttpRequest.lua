-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:01:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TrustedContactsParent = script:FindFirstAncestor("TrustedContacts").Parent
local httpRequest = require(TrustedContactsParent.LuaSocialLibrariesDeps).httpRequest
local maxRetryCount = game:DefineFastInt("TrustedContactsHttpRetryCount", 3)

return (httpRequest.config({
    requestFunction = function(arg1, arg2, arg3)
        return httpRequest.requestFunctions.RequestInternal(arg1, arg2, arg3)
    end,
    maxRetryCount = maxRetryCount
}))
