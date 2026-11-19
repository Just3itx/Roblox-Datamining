-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)

return function(arg1)
    local var1, var2 = React.useState(arg1:getIsLarge())

    React.useEffect(function()
        local connection = arg1:connect(function()
            var2(arg1:getIsLarge())
        end)

        if var1 ~= arg1:getIsLarge() then
            var2(arg1:getIsLarge())
        end

        return function()
            connection:disconnect()
        end
    end, { arg1 })

    return var1
end
