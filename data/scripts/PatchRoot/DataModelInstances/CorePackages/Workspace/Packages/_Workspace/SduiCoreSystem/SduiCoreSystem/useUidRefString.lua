-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local SduiCoreSystemParent = script:FindFirstAncestor("SduiCoreSystem").Parent

local React = require(SduiCoreSystemParent.React)

local num1 = 0

local function getNextUidKey(): string -- Luacid: Inlined by compiler; 1 call site recovered
    num1 += 1
    return tostring(num1)
end

local function useUidRefString()
    local var1 = React.useRef(nil)
    if var1.current == nil then
        var1.current = getNextUidKey()
    end
    return var1
end

return useUidRefString
