-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChromeShared = script:FindFirstAncestor("ChromeShared")

local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local _ChromeUtils = require(ChromeShared.Service.ChromeUtils)

return function(arg1, func1: ((...any) -> (...any))?)
    if not arg1 then
        warn("observableValue undefined")
        return React.useBinding(nil)
    end

    local var1 = func1 or function<T>(arg2: T): T
        return arg2
    end

    local var2, var3 = React.useBinding(var1(arg1:get()))

    React.useEffect(function()
        local connection = arg1:connect(function()
            var3(var1(arg1:get()))
        end)

        var3(var1(arg1:get()))

        return function()
            connection:disconnect()
        end
    end, { arg1 })

    return var2
end
