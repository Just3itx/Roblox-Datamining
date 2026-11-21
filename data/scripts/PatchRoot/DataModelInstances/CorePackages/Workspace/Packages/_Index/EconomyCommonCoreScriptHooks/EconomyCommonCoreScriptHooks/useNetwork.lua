-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EconomyCommonCoreScriptHooksParent = script:FindFirstAncestor("EconomyCommonCoreScriptHooks").Parent
local React = require(EconomyCommonCoreScriptHooksParent.React)

local NetworkContext = require(script.Parent.NetworkContext)

local function useNetwork()
    return React.useContext(NetworkContext)
end

return useNetwork
