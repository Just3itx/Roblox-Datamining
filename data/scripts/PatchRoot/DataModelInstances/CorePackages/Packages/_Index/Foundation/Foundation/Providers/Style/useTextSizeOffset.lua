-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local FoundationParent = script:FindFirstAncestor("Foundation").Parent
local TextSizeOffsetContext = require(scriptParent.TextSizeOffsetContext)

local React = require(FoundationParent.React)

local function useTextSizeOffset()
    return React.useContext(TextSizeOffsetContext)
end

return useTextSizeOffset
