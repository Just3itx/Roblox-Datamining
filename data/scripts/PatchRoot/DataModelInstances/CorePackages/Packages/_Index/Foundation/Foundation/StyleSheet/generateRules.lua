-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local Dash = require(FoundationParent.Dash)
local _Tokens = require(Foundation.Providers.Style.Tokens)
local _Types = require(script.Parent.Rules.Types)
local formatTokens = require(script.Parent.formatTokens)

local function generateRules(arg1, arg2)
    local var1, var2, var3, var4 = arg2(arg1, (formatTokens(arg1)))
    return Dash.joinArrays(var1, var2, var3), var1, var2, var3, var4
end

return generateRules
