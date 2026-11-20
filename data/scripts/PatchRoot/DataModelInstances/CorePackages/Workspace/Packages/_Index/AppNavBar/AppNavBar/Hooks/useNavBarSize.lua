-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local useStyle = require(scriptParentParentParent.UIBlox).Core.Style.useStyle

local FFlagIncreaseAppNavbarWidth = require(scriptParentParent.Flags.FFlagIncreaseAppNavbarWidth)

local function useNavBarSize()
    local tokens = useStyle().Tokens
    return if FFlagIncreaseAppNavbarWidth then tokens.Size.Size_1800 else tokens.Size.Size_1600
end

return useNavBarSize
