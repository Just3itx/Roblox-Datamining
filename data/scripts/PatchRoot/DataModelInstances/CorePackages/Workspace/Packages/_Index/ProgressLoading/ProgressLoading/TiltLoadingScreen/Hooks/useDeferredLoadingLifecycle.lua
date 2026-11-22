-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProgressLoading = script:FindFirstAncestor("ProgressLoading")
local ProgressLoadingParent = ProgressLoading.Parent

local React = require(ProgressLoadingParent.React)
local RunService = game:GetService("RunService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local LoadingScreenMilestones = require(ProgressLoading.LoadingScreenMilestones.LoadingScreenMilestones)
local Constants = require(ProgressLoading.LoadingScreenMilestones.Constants)
local FFlagLoadingScreenMilestones = require(ProgressLoadingParent.SharedFlags).FFlagLoadingScreenMilestones

local function useDeferredLoadingLifecycle(bool1: boolean, bool2: boolean, current: ((...any) -> (...any))?)
    local var1, var2 = React.useState(nil)
    local var3 = React.useRef(nil)
    local var4 = React.useRef(current)
    var4.current = current
    local var5 = React.useRef(false)
    local var6 = React.useCallback(function(bool3: boolean?, bool4: boolean?)
        if var5.current then
            return
        end
        var5.current = true
        if var3.current then
            var3.current.abort(Constants.AbortReason.Cancelled)
        end
        if var4.current then
            var4.current(bool3, bool4)
        end
    end, {})

    React.useEffect(function()
        if not bool1 then
            return
        end

        RunService:SetRobloxGuiFocused(true)
        local var7 = nil
        local tbl1 = {}
        local var8 = nil
        if FFlagLoadingScreenMilestones then
            var7 = LoadingScreenMilestones.start({
                page = Constants.Page.TiltLoadingScreen,
                host = Constants.Host.DeferredJoin,
                holdEnabled = false,
                reducedMotion = UserGameSettings.ReducedMotion
            })
            var3.current = var7
            var2(var7)
            if var7 then
                var7.record(Constants.Milestone.ScreenVisible)
            end
            if var7 and bool2 then
                local function onLoadingStateChanged()
                    if var5.current then
                        return
                    end
                    local prefetchDownloadStatus = bool2:GetPrefetchDownloadStatus()
                    if prefetchDownloadStatus == Enum.PrefetchDownloadStatus.InProgress or bool2.PregameLoadingScreenOnly then
                        return
                    end

                    if prefetchDownloadStatus == Enum.PrefetchDownloadStatus.Completed then
                        var7.dismissRequested(Constants.DismissSource.NormalReady)
                        var7.record(Constants.Milestone.DismissStarted)
                        var7.record(Constants.Milestone.ScreenHidden)
                        var7.complete()
                    else
                        var7.abort(Constants.AbortReason.Unmounted)
                    end
                end
                var8 = onLoadingStateChanged
                local prefetchDownloadStatusChanged = bool2.PrefetchDownloadStatusChanged
                table.insert(tbl1, prefetchDownloadStatusChanged:Connect(onLoadingStateChanged))

                local pregameLoadingScreenOnlyChanged = bool2:GetPropertyChangedSignal("PregameLoadingScreenOnly")
                table.insert(tbl1, pregameLoadingScreenOnlyChanged:Connect(onLoadingStateChanged))

                onLoadingStateChanged()
            end
        end
        return function()
            for _, value in tbl1 do
                value:Disconnect()
            end
            if var7 then
                if var8 then
                    var8()
                end
                var7.abort(Constants.AbortReason.Unmounted)
            end
            RunService:SetRobloxGuiFocused(false)
        end
    end, { bool1, bool2 })

    return var1, var6
end

return useDeferredLoadingLifecycle
