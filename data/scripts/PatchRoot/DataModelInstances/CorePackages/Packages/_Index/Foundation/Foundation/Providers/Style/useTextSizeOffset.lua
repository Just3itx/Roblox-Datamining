-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:01:16Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local FoundationParent = script:FindFirstAncestor("Foundation").Parent
local TextSizeOffsetContext = require(scriptParent.TextSizeOffsetContext)

local React = require(FoundationParent.React)

local function useTextSizeOffset()
    return React.useContext(TextSizeOffsetContext)
end

return useTextSizeOffset
