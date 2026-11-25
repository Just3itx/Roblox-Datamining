-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local StandardBreakpoints = require(scriptParent.CommonConfigs.StandardBreakpoints)
local InputMode = require(scriptParent.InputMode)

return function(vector2: Vector2, touch: string?): boolean
    local maxWidth = StandardBreakpoints.sizes[StandardBreakpoints.Enum.Small].maxWidth
    local bool1 = vector2.X < vector2.Y
    return vector2.X <= maxWidth and bool1 and touch == InputMode.Enum.Touch
end
