-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContentProvider = game:GetService("ContentProvider")

local MomentsCommonParent = script:FindFirstAncestor("MomentsCommon").Parent

local React = require(MomentsCommonParent.React)

return function(str1: string?)
    local var1, var2 = React.useState(false)

    React.useEffect(function()
        if not str1 or str1 == "" then
            var2(false)
            return
        end

        if ContentProvider:GetAssetFetchStatus(str1) == Enum.AssetFetchStatus.Success then
            var2(true)
            return
        end

        var2(false)
        local bool1 = true

        task.spawn(function()
            ContentProvider:PreloadAsync({ str1 }, function(arg1, assetFetchStatus)
                if bool1 and arg1 == str1 and assetFetchStatus == Enum.AssetFetchStatus.Success then
                    var2(true)
                end
            end)
        end)

        return function()
            bool1 = false
        end
    end, { str1 })

    return var1
end
