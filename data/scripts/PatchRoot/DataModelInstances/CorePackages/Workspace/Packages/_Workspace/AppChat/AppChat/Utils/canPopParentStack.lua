-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function canPopParentStack(arg1): boolean
    if not (arg1 and arg1._dangerouslyGetParent) then
        return false
    end
    local var1 = arg1._dangerouslyGetParent()
    local state = var1 and var1.state
    return if state and state.routes then #state.routes > 1 else false
end

return canPopParentStack
