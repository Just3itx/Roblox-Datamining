-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:01:17Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local _Tokens = require(scriptParent.Tokens)
local TokensContext = require(scriptParent.TokensContext)

local React = require(FoundationParent.React)

local function useTokens()
    return (React.useContext(TokensContext))
end

return useTokens
