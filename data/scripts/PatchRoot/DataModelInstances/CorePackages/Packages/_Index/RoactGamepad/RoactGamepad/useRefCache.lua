-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)

local createRefCache = require(script.Parent.createRefCache)

local function useRefCache()
    local var1 = React.useRef(nil)
    if var1.current == nil then
        var1.current = createRefCache()
    end
    return var1.current
end

return useRefCache
