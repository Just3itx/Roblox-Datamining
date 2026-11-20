-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
local scriptParentParentParentParentParent = script.Parent.Parent.Parent.Parent.Parent

local React = require(scriptParentParentParentParentParent.React)
local useEffect = React.useEffect
local useRef = React.useRef

function module.useAfterFastRefresh(callback: (...any) -> (...any))
    if not _G.__DEV__ then
        return
    end

    local var1 = useRef(false)
    useEffect(function()
        return function()
            var1.current = true
        end
    end, {})
    useEffect(function()
        if var1.current == true then
            var1.current = false
            callback()
        end
    end, {})
end
return module
