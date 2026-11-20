-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local React = require(scriptParentParentParent.React)
local PresenceContext = require(script.Parent.PresenceContext)

local function isPresent(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1 == nil or arg1.isPresent
end

return {
    useIsPresent = function()
        return isPresent((React.useContext(PresenceContext)))
    end,
    isPresent = isPresent
}
