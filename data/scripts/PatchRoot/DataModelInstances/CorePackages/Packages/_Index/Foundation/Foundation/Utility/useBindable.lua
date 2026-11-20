-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)
local ReactIs = require(FoundationParent.ReactIs)

local _Types = require(Foundation.Components.Types)

local function useBindable(arg1)
    local var1, var2 = React.useBinding(nil)

    if ReactIs.isBinding(arg1) then
        return arg1
    end
    var2(arg1)
    return var1
end

return useBindable
