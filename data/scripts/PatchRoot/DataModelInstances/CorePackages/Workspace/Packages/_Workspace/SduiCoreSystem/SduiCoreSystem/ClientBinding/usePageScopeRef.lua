-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:51:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent

local React = require(SduiCoreSystemParent.React)
local getSduiClientPageScope = require(SduiCoreSystem.ClientBinding.getSduiClientPageScope)

local function usePageScopeRef(str1: string?)
    local var1 = React.useRef(nil)
    if str1 and var1.current == nil then
        var1.current = getSduiClientPageScope(str1)
    end

    return var1.current
end

return usePageScopeRef
