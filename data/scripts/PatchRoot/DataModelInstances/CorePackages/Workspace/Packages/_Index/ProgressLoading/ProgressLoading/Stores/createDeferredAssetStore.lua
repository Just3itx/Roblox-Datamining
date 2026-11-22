-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProgressLoading = script:FindFirstAncestor("ProgressLoading")
local ProgressLoadingParent = ProgressLoading.Parent

local EngineFeatureEnableDeferredAssetManagerService = require(ProgressLoading.Flags.EngineFeatureEnableDeferredAssetManagerService)
local DeferredAssetManagerService = if EngineFeatureEnableDeferredAssetManagerService then game:GetService("DeferredAssetManagerService") else nil
local Signals = require(ProgressLoadingParent.Signals)

local function createDeferredAssetStore(arg1)
    local var1 = arg1 or DeferredAssetManagerService
    if not EngineFeatureEnableDeferredAssetManagerService and arg1 == nil then
        return {
            getDownloadStatus = function() end,
            getPregameLoadingScreenOnly = function(): boolean
                return false
            end,
            cleanUp = function() end
        }
    end
    local prefetchDownloadStatus = var1:GetPrefetchDownloadStatus()
    local getDownloadStatus, var3 = Signals.createSignal(prefetchDownloadStatus)
    local connection = var1.PrefetchDownloadStatusChanged:Connect(function(status: Enum.PrefetchDownloadStatus)
        var3(status)
    end)

    local getPregameLoadingScreenOnly, var5 = Signals.createSignal(var1.PregameLoadingScreenOnly)

    local connection2 = var1:GetPropertyChangedSignal("PregameLoadingScreenOnly"):Connect(function()
        var5(var1.PregameLoadingScreenOnly)
    end)

    return {
        getDownloadStatus = getDownloadStatus,
        getPregameLoadingScreenOnly = getPregameLoadingScreenOnly,
        cleanUp = function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    }
end

return createDeferredAssetStore
