-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local AppTabBarRodux = require(MomentsParent.AppTabBarRodux)
local useDispatch = require(MomentsParent.RoactUtils).Hooks.RoactRodux.useDispatch
local MomentsCommon = require(MomentsParent.MomentsCommon)

local SetTabBarVisible = AppTabBarRodux.Actions.SetTabBarVisible
local Analytics = MomentsCommon.Analytics
local FunnelEventNames = Analytics.FunnelEventNames

local createGalleryCaptureSource = require(Moments.Capture.createGalleryCaptureSource)
local isStudio = require(MomentsParent.MomentsCommon.isStudio)
local hasGalleryApi = require(Moments.Capture.hasGalleryApi)
local logCreationEntryResolved = require(Moments.Analytics.logCreationEntryResolved)
local FFlagMomentsCreationEntryOutcome = require(Moments.Flags.FFlagMomentsCreationEntryOutcome)

local function useCreationEntry(tbl1)
    local isCreating, var2 = React.useState(false)
    local var3, var4 = React.useState(false)
    local var5 = React.useRef(nil)
    local var6 = React.useRef(false)

    local var7 = useDispatch()
    local bool1 = tbl1 == nil or tbl1.manageTabBarVisibility ~= false

    local var8 = isStudio()
    local var9 = hasGalleryApi()
    local var10 = var8 or not var9

    local onCreatePressed = React.useCallback(function()
        local sessionId = if FFlagMomentsCreationEntryOutcome then Analytics.SessionManager.getSessionId(FunnelEventNames.FunnelTypes.CreationFlow) else nil

        if var10 then
            var2(true)
            if FFlagMomentsCreationEntryOutcome then
                logCreationEntryResolved.log(logCreationEntryResolved.Outcome.GalleryUnavailable, sessionId)
            end

            return
        end

        if var6.current then
            if FFlagMomentsCreationEntryOutcome then
                logCreationEntryResolved.log(logCreationEntryResolved.Outcome.RequestInFlight, sessionId)
            end

            return
        end

        var6.current = true
        task.spawn(function()
            var5.current = createGalleryCaptureSource(nil, function(arg1, arg2, arg3)
                var6.current = false
                if arg2 and #arg1 == 0 then
                    var4(true)
                else
                    var2(true)
                end
                if FFlagMomentsCreationEntryOutcome then
                    logCreationEntryResolved.log(logCreationEntryResolved.resolveGalleryOutcome(arg2, #arg1, arg3), sessionId)
                end
            end)
        end)
    end, { var10 })

    React.useEffect(function()
        if bool1 and isCreating then
            var7(SetTabBarVisible(false))
        end
        return function()
            if bool1 and isCreating then
                var7(SetTabBarVisible(true))
            end
        end
    end, { isCreating, var7, bool1 })

    local onExitCreation = React.useCallback(function()
        var5.current = nil
        var2(false)
    end, {})

    local onExitFtux = React.useCallback(function()
        var5.current = nil
        var4(false)
    end, {})

    local tbl2 = {
        isCreating = isCreating,
        showFtux = 0,
        captureSource = 0,
        onCreatePressed = 0,
        onExitCreation = 0,
        onExitFtux = 0
    }

    if var10 then
        var3 = false
    end

    tbl2.showFtux = var3
    tbl2.captureSource = if var10 then nil else var5.current
    tbl2.onCreatePressed = onCreatePressed
    tbl2.onExitCreation = onExitCreation
    tbl2.onExitFtux = onExitFtux
    return tbl2
end

return useCreationEntry
