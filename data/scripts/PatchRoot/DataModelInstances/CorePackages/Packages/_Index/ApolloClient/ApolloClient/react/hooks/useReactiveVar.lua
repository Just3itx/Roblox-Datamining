-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:20:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local useEffect = React.useEffect
local useState = React.useState

local _cache = require(scriptParentParentParent.cache)

local tbl1 = { __value = "nil placeholder" }

function module.useReactiveVar(arg1)
    local var1 = arg1()

    local _, var2 = useState(var1)

    useEffect(function()
        local var3 = arg1()
        if var1 == var3 then
            return arg1:onNextChange(var2)
        end

        var2(var3)
    end, { var1 or tbl1 })

    return var1
end
return module
