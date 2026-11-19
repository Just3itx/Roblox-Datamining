-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local _Chrome = require(CorePackages.Workspace.Packages.Chrome)

return function(arg1): UDim2
    if not (arg1 and arg1.windowSize) then
        warn("windowSize object not found")
        return UDim2.new()
    end

    local windowSize = arg1.windowSize

    local var1, var2 = React.useState(windowSize:get())

    React.useEffect(function()
        local connection = windowSize:connect(function()
            var2(windowSize:get())
        end)

        if var1 ~= windowSize:get() then
            var2(windowSize:get())
        end

        return function()
            connection:disconnect()
        end
    end, { arg1.id })

    return var1
end
