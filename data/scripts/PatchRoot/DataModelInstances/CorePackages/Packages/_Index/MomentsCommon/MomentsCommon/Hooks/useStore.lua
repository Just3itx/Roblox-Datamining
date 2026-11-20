-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommonParent = script:FindFirstAncestor("MomentsCommon").Parent

local React = require(MomentsCommonParent.React)
local StoreContext = require(MomentsCommonParent.RoactRodux).StoreContext

local function useStore()
    local var1 = React.useContext(StoreContext)
    assert(var1, "useDispatch and useSelector can only be called from a descendant of the Rodux Store Provider")
    return var1
end

return useStore
