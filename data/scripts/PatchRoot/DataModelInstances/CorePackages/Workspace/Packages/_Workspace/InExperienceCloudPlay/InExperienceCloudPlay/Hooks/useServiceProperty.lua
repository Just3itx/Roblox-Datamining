-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceCloudPlay = script:FindFirstAncestor("InExperienceCloudPlay")
local InExperienceCloudPlayParent = InExperienceCloudPlay.Parent

local React = require(InExperienceCloudPlayParent.React)
local _getCloudClientService = require(InExperienceCloudPlay.getCloudClientService)

local function useServiceProperty(str1: string, str2: string)
    local var1, var2 = React.useState(if str1 then str1[str2] else nil)

    React.useEffect(function()
        if not str1 then
            return nil
        end
        local connection = str1:GetPropertyChangedSignal(str2):Connect(function()
            var2(str1[str2])
        end)
        return function()
            connection:Disconnect()
        end
    end, { str1, str2 })

    return var1
end

return useServiceProperty
