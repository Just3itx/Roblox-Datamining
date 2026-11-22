-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContentProvider = game:GetService("ContentProvider")

local tbl1 = { 0.5, 1, 2 }

local function isRetryable(assetFetchStatus): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return assetFetchStatus == Enum.AssetFetchStatus.Failure or assetFetchStatus == Enum.AssetFetchStatus.TimedOut
end

local function preloadImageWithRetry(str1: string, tbl2, tbl3)
    local var1 = if tbl3 and tbl3.contentProvider then tbl3.contentProvider else ContentProvider
    local var2 = if tbl3 and tbl3.retryDelays then tbl3.retryDelays else tbl1
    local wait = if tbl3 and tbl3.wait then tbl3.wait else task.wait

    for i = 1, #var2 + 1 do
        local var3 = nil
        pcall(function()
            var1:PreloadAsync({ str1 }, function(arg1, arg2)
                if arg1 == str1 then
                    var3 = arg2
                end
            end)
        end)

        if not tbl2.isCurrent() then
            return
        end

        local assetFetchStatus = var1:GetAssetFetchStatus(str1)
        local success = Enum.AssetFetchStatus.Success

        if var3 == success or assetFetchStatus == Enum.AssetFetchStatus.Success then
            tbl2.onSuccess()
            return
        end

        if not (isRetryable(var3) or isRetryable(assetFetchStatus)) then
            return
        end

        local var4 = var2[i]
        if var4 == nil then
            break
        end

        wait(var4)
        if not tbl2.isCurrent() then
            return
        end
    end

    tbl2.onGiveUp()
end

return preloadImageWithRetry
