-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local usePlayerGui = require(script.Parent.usePlayerGui)

local function usePlayerCurrentScreenOrientation()
    local var1 = usePlayerGui()
    local var2, var3 = React.useState(nil)

    React.useEffect(function()
        local connection = nil

        if var1 then
            var3(var1.CurrentScreenOrientation)

            connection = var1:GetPropertyChangedSignal("CurrentScreenOrientation"):Connect(function()
                var3(var1.CurrentScreenOrientation)
            end)
        end

        return function()
            if connection then
                connection:Disconnect()
            end
        end
    end, { var1 })

    return var2
end

return usePlayerCurrentScreenOrientation
