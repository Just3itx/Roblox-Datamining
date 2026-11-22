-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProgressLoadingParent = script:FindFirstAncestor("ProgressLoading").Parent

local React = require(ProgressLoadingParent.React)
local SignalsReact = require(ProgressLoadingParent.SignalsReact)

local ProgressLoadingAssets = require(script.Parent.ProgressLoadingAssets)
local ProgressLoadingTelemetry = require(script.Parent.ProgressLoadingTelemetry)
local GetDeferredAssetStore = require(script.Parent.Stores.GetDeferredAssetStore)
local Constants = require(script.Parent.Constants)

local function getIsLoadingAssets(arg1): boolean
    local deferredAssetStore = GetDeferredAssetStore(arg1)
    return if deferredAssetStore then deferredAssetStore.getDownloadStatus(arg1) == Enum.PrefetchDownloadStatus.InProgress else false
end

return React.memo(function(tbl1) -- name: ProgressLoadingAssetsScreenGui
    local isVisible = SignalsReact.useSignalState(getIsLoadingAssets)
    local var2, var3 = React.useState(isVisible)

    React.useEffect(function()
        if isVisible then
            ProgressLoadingTelemetry.logLoadingAssetsActivated()
            var3(true)
        end
    end, { isVisible })

    local onHideComplete = React.useCallback(function()
        ProgressLoadingTelemetry.logLoadingAssetsDeactivated()
        var3(false)
    end, {})

    if not var2 then
        return nil
    end

    return React.createElement("ScreenGui", {
        Enabled = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = tbl1.displayOrder or Constants.DISPLAY_ORDER,
        ScreenInsets = Enum.ScreenInsets.None,
        ClipToDeviceSafeArea = false
    }, {
        ProgressLoadingAssets = React.createElement(ProgressLoadingAssets, { isVisible = isVisible, onHideComplete = onHideComplete })
    })
end)
