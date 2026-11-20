-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:30:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)

local RadioGroupContext = require(script.Parent.RadioGroupContext)

return function()
    return React.useContext(RadioGroupContext)
end
