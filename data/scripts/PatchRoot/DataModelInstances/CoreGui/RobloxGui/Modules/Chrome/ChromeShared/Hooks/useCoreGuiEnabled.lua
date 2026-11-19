-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local StarterGui = game:GetService("StarterGui")
local React = require(CorePackages.Packages.React)

function useCoreGuiEnabled(coreGuiType: Enum.CoreGuiType)
    local var1, var2 = React.useState(StarterGui:GetCoreGuiEnabled(coreGuiType))
    React.useEffect(function()
        local connection = StarterGui.CoreGuiChangedSignal:Connect(function(coreGuiType2: Enum.CoreGuiType, enabled: boolean)
            if coreGuiType2 == coreGuiType then
                var2(enabled)
            end
        end)

        var2(StarterGui:GetCoreGuiEnabled(coreGuiType))
        return function()
            connection:Disconnect()
        end
    end, { coreGuiType })
    return var1
end

return useCoreGuiEnabled
