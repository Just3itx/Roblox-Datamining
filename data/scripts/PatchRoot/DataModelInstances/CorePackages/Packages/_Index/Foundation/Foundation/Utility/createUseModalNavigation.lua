-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:10:50Z
-- Luau bytecode version: 9 | Luau type version: 3
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
