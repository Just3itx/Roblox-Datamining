-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:40:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProgressLoading = script:FindFirstAncestor("ProgressLoading")
local ProgressLoadingParent = ProgressLoading.Parent

local React = require(ProgressLoadingParent.React)
local Motion = require(ProgressLoadingParent.Motion)
local Constants = require(script.Parent.Parent.Constants)
local shouldHoldForExit = require(script.Parent.Parent.shouldHoldForExit)
local FFlagLoadingScreenMilestones = require(ProgressLoadingParent.SharedFlags).FFlagLoadingScreenMilestones
local FFlagTiltLoadingScreenDismissOnLoaded = require(ProgressLoadingParent.SharedFlags).FFlagTiltLoadingScreenDismissOnLoaded
local Players = require(ProgressLoadingParent.MockableProxyServices).Players
local ReplicatedFirst = require(ProgressLoadingParent.MockableProxyServices).ReplicatedFirst
local game = require(ProgressLoadingParent.MockableProxyServices).game
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local _Types = require(ProgressLoading.LoadingScreenMilestones.Types)

local ANIMATION = Constants.ANIMATION

local state = Motion.createState({ reveal = 1 }, { default = Motion.transition({ duration = ANIMATION.chromeFadeIn }) })

local state2 = Motion.createState({ reveal = 0 }, { default = Motion.transition({ duration = ANIMATION.closeDur }) })

local Constants2 = require(ProgressLoading.LoadingScreenMilestones.Constants)
local AbortReason = Constants2.AbortReason
local Milestone = Constants2.Milestone
local DismissSource = Constants2.DismissSource
local function useExperienceLoadingLifecycle(bool1: boolean, arg1, current: ((...any) -> (...any))?)
    local var1 = if FFlagLoadingScreenMilestones then React.useRef(arg1) else nil

    local isVisible, var3 = React.useState(function(): boolean
        return not bool1 or not ReplicatedFirst:IsDefaultLoadingGuiRemoved()
    end)
    local isDismissing, var5 = React.useState(false)
    local var6, var2 = Motion.useMotion(state)
    local var8 = React.useRef(var6.reveal)
    local var9 = React.useRef(var2)
    var9.current = var2
    local var10 = React.useRef(current)
    var10.current = current
    local var11 = React.useRef(nil)
    local onEnterComplete = React.useCallback(function()
        if var11.current then
            var11.current()
        end
    end, {})

    React.useEffect(function()
        if not bool1 then
            return
        end

        local current2 = if var1 then var1.current else nil

        if FFlagLoadingScreenMilestones and current2 then
            current2.record(Milestone.ScreenVisible)
        end
        local tbl1 = {}
        local bool2 = false
        local bool3 = false
        local var13 = nil
        local var14 = nil
        local var15 = nil
        local bool4 = false
        local bool5 = false

        local function doDismiss()
            if FFlagLoadingScreenMilestones and current2 then
                current2.record(Milestone.DismissStarted)
            end
            bool2 = true
            var5(true)

            local function fadeChrome()
                var13 = nil
                if bool3 then
                    return
                end
                var9.current(state2, {
                    onAnimationComplete = function(arg2)
                        if arg2 ~= true or bool3 then
                            return
                        end
                        if FFlagLoadingScreenMilestones and current2 then
                            current2.record(Milestone.ScreenHidden)
                        end
                        if not FFlagTiltLoadingScreenDismissOnLoaded then
                            ReplicatedFirst:SetDefaultLoadingGuiRemoved()
                        end
                        var3(false)
                        if var10.current then
                            var10.current()
                        end
                    end
                })
            end

            if UserGameSettings.ReducedMotion then
                fadeChrome()
                return
            end
            var13 = task.delay(ANIMATION.closeDur, fadeChrome)
        end

        function var11.current()
            if bool3 or bool2 then
                return
            end

            if not shouldHoldForExit(UserGameSettings.ReducedMotion) then
                bool4 = true
                if bool5 then
                    doDismiss()
                end

                return
            end

            var15 = task.delay(ANIMATION.enterExitHold, function()
                var15 = nil
                if bool3 or bool2 then
                    return
                end
                bool4 = true
                if FFlagLoadingScreenMilestones and current2 then
                    current2.record(Milestone.DismissGateReleased)
                end
                if bool5 then
                    doDismiss()
                end
            end)
        end

        local function dismiss() -- Luacid: Inlined by compiler; 9 call sites recovered
            if bool2 then
                return
            end

            if not shouldHoldForExit(UserGameSettings.ReducedMotion) or bool4 then
                doDismiss()
            else
                bool5 = true
            end
        end

        local function waitForCharacterAndDismiss() -- Luacid: Inlined by compiler; 4 call sites recovered
            if var14 then
                return
            end
            var14 = task.spawn(function()
                if Players.CharacterAutoLoads then
                    local localPlayer = Players.LocalPlayer
                    if not localPlayer then
                        Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
                        localPlayer = Players.LocalPlayer
                    end
                    if not localPlayer.Character then
                        localPlayer.CharacterAdded:Wait()
                    end
                end
                var14 = nil
                if bool3 then
                    return
                end
                if FFlagLoadingScreenMilestones and current2 then
                    current2.dismissRequested(DismissSource.NormalReady)
                end

                dismiss()
            end)
        end

        local function handleFinishedReplicating() -- Luacid: Inlined by compiler; 1 call site recovered
            if game:IsLoaded() then
                waitForCharacterAndDismiss()
                return
            end

            local connection = nil
            connection = game.Loaded:Connect(function()
                connection:Disconnect()
                waitForCharacterAndDismiss()
            end)

            table.insert(tbl1, connection)
        end

        local function dismissOnLoaded() -- Luacid: Inlined by compiler; 3 call sites recovered
            if FFlagLoadingScreenMilestones and current2 then
                current2.dismissRequested(DismissSource.NormalReady)
            end

            dismiss()
        end

        if FFlagTiltLoadingScreenDismissOnLoaded then
            local loaded = game.Loaded
            table.insert(tbl1, loaded:Connect(dismissOnLoaded))
        else
            local finishedReplicating = ReplicatedFirst.FinishedReplicating
            table.insert(tbl1, finishedReplicating:Connect(handleFinishedReplicating))
        end

        local removeDefaultLoadingGuiSignal = ReplicatedFirst.RemoveDefaultLoadingGuiSignal

        table.insert(tbl1, removeDefaultLoadingGuiSignal:Connect(function()
            if FFlagLoadingScreenMilestones and current2 then
                current2.dismissRequested(DismissSource.DeveloperOverride)
            end

            dismiss()
        end))

        if FFlagTiltLoadingScreenDismissOnLoaded then
            if game:IsLoaded() then
                dismissOnLoaded()
            end
        elseif ReplicatedFirst:IsFinishedReplicating() then
            handleFinishedReplicating()
        end

        if ReplicatedFirst:IsDefaultLoadingGuiRemoved() then
            if FFlagLoadingScreenMilestones and current2 then
                current2.dismissRequested(DismissSource.DeveloperOverride)
            end

            dismiss()
        end

        return function()
            bool3 = true
            if FFlagLoadingScreenMilestones and current2 then
                current2.abort(AbortReason.Unmounted)
            end
            var11.current = nil
            if var15 then
                task.cancel(var15)
            end
            if var13 then
                task.cancel(var13)
            end
            if var14 and coroutine.status(var14) ~= "dead" then
                task.cancel(var14)
            end
            for _, value in tbl1 do
                value:Disconnect()
            end
        end
    end, { bool1 })

    return {
        isVisible = isVisible,
        isDismissing = isDismissing,
        chromeReveal = var8.current,
        onEnterComplete = onEnterComplete,
        milestones = if var1 then var1.current else nil
    }
end

return useExperienceLoadingLifecycle
