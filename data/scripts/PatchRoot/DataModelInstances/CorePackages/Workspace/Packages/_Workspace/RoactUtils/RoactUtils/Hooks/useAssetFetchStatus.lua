-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:40:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactUtilsParent = script:FindFirstAncestor("RoactUtils").Parent

local ContentProvider = game:GetService("ContentProvider")

local React = require(RoactUtilsParent.React)

local function useAssetFetchStatus(str1: string?)
    local var1, var2 = React.useState(Enum.AssetFetchStatus.None)

    React.useEffect(function()
        var2(Enum.AssetFetchStatus.None)

        if not str1 or str1 == "" then
            return
        end

        local connection = ContentProvider:GetAssetFetchStatusChangedSignal(str1):Connect(function(arg1)
            var2(arg1)
        end)

        local assetFetchStatus = ContentProvider:GetAssetFetchStatus(str1)
        var2(assetFetchStatus)

        return function()
            connection:Disconnect()
        end
    end, { str1 })

    return var1
end

return useAssetFetchStatus
