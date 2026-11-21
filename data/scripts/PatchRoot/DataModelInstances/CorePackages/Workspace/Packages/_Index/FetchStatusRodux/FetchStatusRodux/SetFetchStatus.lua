-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:30:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FetchStatusRoduxParent = script:FindFirstAncestor("FetchStatusRodux").Parent

return require(FetchStatusRoduxParent.Rodux).makeActionCreator(script.Name, function(fetchNamespace, fetchKey, fetchStatus)
    return { fetchNamespace = fetchNamespace, fetchKey = fetchKey, fetchStatus = fetchStatus }
end)
