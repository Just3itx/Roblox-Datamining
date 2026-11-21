-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EconomyCommonCoreScriptHooksParent = script:FindFirstAncestor("EconomyCommonCoreScriptHooks").Parent
local React = require(EconomyCommonCoreScriptHooksParent.React)

local ScreenSizeContext = require(script.Parent.ScreenSizeContext)

local function useScreenSize()
    return React.useContext(ScreenSizeContext)
end

return useScreenSize
