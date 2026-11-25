-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:31:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactUtilsParent = script:FindFirstAncestor("RoactUtils").Parent
local React = require(RoactUtilsParent.React)

local StoreContext = require(RoactUtilsParent.RoactRodux).StoreContext

local function useStore()
    local var1 = React.useContext(StoreContext)
    assert(var1, "useDispatch and useSelector can only be called from a descendant of the Rodux Store Provider")
    return var1
end

return useStore
