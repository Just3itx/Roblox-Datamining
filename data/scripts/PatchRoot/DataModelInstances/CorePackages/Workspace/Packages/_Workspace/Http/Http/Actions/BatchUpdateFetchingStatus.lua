-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:40:41Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local HttpParent = script:FindFirstAncestor("Http").Parent

return require(HttpParent.Rodux).makeActionCreator(script.Name, function(fetchingStatuses, shouldImmediatelyDispatch: boolean?)
    return {
        fetchingStatuses = fetchingStatuses,
        shouldImmediatelyDispatch = shouldImmediatelyDispatch or false
    }
end)
