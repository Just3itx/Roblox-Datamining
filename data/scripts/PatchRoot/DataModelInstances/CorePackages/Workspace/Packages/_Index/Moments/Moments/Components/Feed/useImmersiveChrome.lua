-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local Signals = require(MomentsParent.Signals)
local SignalsReact = require(MomentsParent.SignalsReact)
local MomentsCommon = require(MomentsParent.MomentsCommon)

local useSignalState = SignalsReact.useSignalState

local _FeedTypes = require(script.Parent.FeedTypes)
local immersiveChromeMachine = require(script.Parent.immersiveChromeMachine)
local GetImmersiveChromeStore = require(Moments.Stores.GetImmersiveChromeStore)
local GetFIntMomentsImmersiveHideAfterAdvances = require(Moments.Flags.GetFIntMomentsImmersiveHideAfterAdvances)
local GetFIntMomentsImmersiveShownDwellMs = require(Moments.Flags.GetFIntMomentsImmersiveShownDwellMs)
local GetFIntMomentsImmersiveHiddenCooldownMs = require(Moments.Flags.GetFIntMomentsImmersiveHiddenCooldownMs)
local GetFFlagMomentsPersistHeaderOnProfilePeek = require(Moments.Flags.GetFFlagMomentsPersistHeaderOnProfilePeek)

local Analytics = MomentsCommon.Analytics
local EventNames = Analytics.EventNames
local fireAnalyticsEvent = Analytics.fireAnalyticsEvent

local function defaultFireEvent(bool1: boolean, trigger, num1: number)
    local var1 = if bool1 then EventNames.MomentsChromeRestored else EventNames.MomentsChromeAutoHidden
    fireAnalyticsEvent(var1, { trigger = trigger, index = tostring(num1) })
end

local function useImmersiveChrome(tbl1)
    local pager = tbl1.pager
    local active = tbl1.active
    local getActiveIsPlaying = tbl1.getActiveIsPlaying
    local getIsScrolling = tbl1.getIsScrolling
    local inputAllowed = tbl1.inputAllowed
    local reducedMotion = tbl1.reducedMotion
    local bool1 = tbl1.coveringOverlay == true

    local var1 = React.useMemo(function()
        return tbl1.store or GetImmersiveChromeStore(false)
    end, {})

    local current = tbl1.featureEnabledOverride == nil or tbl1.featureEnabledOverride

    local var3 = React.useRef(1)
    local var4 = React.useRef(current)
    var4.current = current
    local var5 = React.useRef(tbl1.fireEvent or defaultFireEvent)
    var5.current = tbl1.fireEvent or defaultFireEvent

    local var6 = React.useMemo(function()
        local var6 = tbl1.config
            or {
                hideAfterAdvances = GetFIntMomentsImmersiveHideAfterAdvances(),
                shownDwellMs = GetFIntMomentsImmersiveShownDwellMs(),
                hiddenCooldownMs = GetFIntMomentsImmersiveHiddenCooldownMs()
            }
        local now = tbl1.now or function(): number
            return os.clock() * 1000
        end
        return immersiveChromeMachine(var6, {
            now = now,
            setChromeVisible = function(bool2: boolean, arg1)
                var1.setChromeVisible(bool2)
                if var4.current then
                    var5.current(bool2, arg1, var3.current)
                end
            end
        })
    end, {})

    React.useEffect(function()
        return (Signals.createEffect(function(arg1)
            local count = pager.getCount(arg1)
            local currentIndex = pager.getCurrentIndex(arg1)
            local activeIsPlaying = getActiveIsPlaying(arg1)
            local isScrolling = getIsScrolling(arg1)
            var3.current = currentIndex

            var6.setCount(count)
            var6.onActiveUpdate(currentIndex, activeIsPlaying, isScrolling)
        end))
    end, {
        pager,
        getActiveIsPlaying,
        getIsScrolling,
        var6
    })

    local var7 = useSignalState(var1.getOverlayCovering)

    local fFlagMomentsPersistHeaderOnProfilePeek = GetFFlagMomentsPersistHeaderOnProfilePeek()
    local var8 = if fFlagMomentsPersistHeaderOnProfilePeek then bool1 else var7 or bool1
    local var9 = React.useRef(false)

    React.useEffect(function()
        if fFlagMomentsPersistHeaderOnProfilePeek then
            if var7 and not active then
                var9.current = true
            elseif active then
                var9.current = false
            end
        end

        local bool2 = not active and not (fFlagMomentsPersistHeaderOnProfilePeek and var9.current)
        local var10 = bool2 or not inputAllowed or reducedMotion or not current
        local setForceShow = var6.setForceShow
        var10 = var10 and not (var7 or bool1)
        setForceShow(var10)
        var6.setForceHide(var8)
    end, {
        active,
        inputAllowed,
        reducedMotion,
        current,
        var7,
        bool1,
        var8,
        fFlagMomentsPersistHeaderOnProfilePeek,
        var6
    })

    React.useEffect(function()
        var1.setRevealHandler(var6.reveal)
        return function()
            var1.setRevealHandler(nil)
        end
    end, { var1, var6 })

    React.useEffect(function()
        return function()
            var1.setChromeVisible(true)
        end
    end, { var1 })
end

return useImmersiveChrome
