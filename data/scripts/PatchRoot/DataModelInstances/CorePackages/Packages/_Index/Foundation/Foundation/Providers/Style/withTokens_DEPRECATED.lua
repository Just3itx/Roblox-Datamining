-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)

local _Tokens = require(scriptParent.Tokens)
local TokensContext = require(scriptParent.TokensContext)

local function withTokens_DEPRECATED(render: (...any) -> (...any))
    return React.createElement(TokensContext.Consumer, { render = render })
end

return withTokens_DEPRECATED
