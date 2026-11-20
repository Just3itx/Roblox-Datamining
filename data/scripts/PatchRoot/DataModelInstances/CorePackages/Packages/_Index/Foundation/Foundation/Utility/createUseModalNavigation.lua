-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)

local function createUseModalNavigation(arg1)
    return function()
        local var1 = React.useContext(arg1)

        return {
            closeAffordanceRef = var1.closeAffordanceRef,
            setContentStartRef = var1.setContentStartRef
        }
    end
end

return createUseModalNavigation
