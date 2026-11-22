-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppNavigationParent = script:FindFirstAncestor("RobloxAppNavigation").Parent

local useNavigation = require(RobloxAppNavigationParent.Navigation).useNavigation

local _types = require(script.Parent.types)

local function useNavigationProps(arg1)
    local var1 = useNavigation()
    return arg1(var1.getParam("detail"), var1.getParam("extraProps", {}), var1)
end

return useNavigationProps
