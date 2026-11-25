-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContentProvider = game:GetService("ContentProvider")

local function tryLoadRbxthumbAsync(str1: string, num1: number?): string
    local num2 = num1 or 5

    if ContentProvider:GetAssetFetchStatus(str1) == Enum.AssetFetchStatus.Success then
        return str1
    end

    ContentProvider:PreloadAsync({ str1 })
    local num3 = 0

    while ContentProvider:GetAssetFetchStatus(str1) ~= Enum.AssetFetchStatus.Success do
        num3 += task.wait()

        if num2 < num3 then
            error(`timed out after {num2} seconds when loading {str1}`)
        end
    end

    return str1
end

return tryLoadRbxthumbAsync
