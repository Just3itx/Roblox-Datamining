-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChromeShared = script:FindFirstAncestor("ChromeShared")

local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local _ChromeUtils = require(ChromeShared.Service.ChromeUtils)

return function(arg1, func1: (...any) -> (...any))
    if not arg1 then
        warn("observableValue undefined")
        return nil
    end

    local var1, var2 = React.useState(func1(arg1:get()))
    React.useEffect(function()
        local connection = arg1:connect(function()
            var2(func1(arg1:get()))
        end)

        local var3 = func1(arg1:get())
        if var1 ~= var3 then
            var2(var3)
        end

        return function()
            connection:disconnect()
        end
    end, { arg1 })

    return var1
end
