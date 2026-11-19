-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local useLocalPlayer = require(script.Parent.useLocalPlayer)

local function usePlayerGui()
    local var1 = useLocalPlayer()
    local var2, var3 = React.useState(nil)

    React.useEffect(function()
        local connection = nil

        if var1 then
            var3(var1:FindFirstChildOfClass("PlayerGui"))

            connection = var1.ChildAdded:Connect(function(child: Instance)
                if child:IsA("PlayerGui") then
                    var3(child)
                end
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

return usePlayerGui
