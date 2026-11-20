-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)
local _Types = require(Foundation.Components.Types)

local useBindable = require(Foundation.Utility.useBindable)

local function useCumulativeBackground(arg1, arg2)
    local var1 = useBindable(arg1)
    local var2 = useBindable(arg2)

    return React.joinBindings({ var1, var2 }):map(function(arg3)
        return {
            Color3 = arg3[2].Color3:Lerp(arg3[1].Color3, arg3[2].Transparency),
            Transparency = 0
        }
    end)
end

return useCumulativeBackground
