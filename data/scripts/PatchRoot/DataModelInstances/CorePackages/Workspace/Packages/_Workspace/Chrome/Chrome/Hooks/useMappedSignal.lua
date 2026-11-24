-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local ChromeParent = Chrome.Parent
local React = require(ChromeParent.React)
local _Types = require(Chrome.Common.Types)

return function(arg1)
    local var1 = if arg1 == nil then nil else arg1:get()
    local var2, var3 = React.useState(var1)
    React.useEffect(function()
        if arg1 == nil then
            return
        end

        local var4 = arg1
        local connection = var4:connect(function(arg2)
            var3(arg2)
        end)

        if var2 ~= var4:get() then
            var3(var4:get())
        end

        return function()
            connection:disconnect()
        end
    end, { arg1 })

    return var2
end
