-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChromeShared = script:FindFirstAncestor("ChromeShared")

local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local _ChromeUtils = require(ChromeShared.Service.ChromeUtils)

return function(arg1)
    if not arg1 then
        warn("observableValue undefined")
        return nil
    end

    local var1, var2 = React.useState(arg1:get())
    React.useEffect(function()
        local connection = arg1:connect(function()
            var2(arg1:get())
        end)

        if var1 ~= arg1:get() then
            var2(arg1:get())
        end

        return function()
            connection:disconnect()
        end
    end, { arg1 })

    return var1
end
