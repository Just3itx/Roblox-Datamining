-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:41:03Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)

local RadioGroupContext = require(script.Parent.RadioGroupContext)

return function()
    return React.useContext(RadioGroupContext)
end
