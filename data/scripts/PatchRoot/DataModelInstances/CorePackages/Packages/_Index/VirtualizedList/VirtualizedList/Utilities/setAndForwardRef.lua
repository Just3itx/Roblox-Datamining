-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:00:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _React = require(scriptParentParentParent.React)

local function setAndForwardRef(arg1)
    local getForwardedRef = arg1.getForwardedRef
    local setLocalRef = arg1.setLocalRef
    return function(current)
        local forwardedRef = getForwardedRef()
        setLocalRef(current)

        if typeof(forwardedRef) == "function" then
            forwardedRef(current)
        elseif typeof(forwardedRef) == "table" then
            forwardedRef.current = current
        end
    end
end

return setAndForwardRef
