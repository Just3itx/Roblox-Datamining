-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")

local React = require(scriptParentParentParent.React)
local RoactUtils = require(scriptParentParentParent.RoactUtils)
local SocialStopwatch = require(scriptParentParentParent.SocialStopwatch)

local Constants = require(scriptParentParent.Constants)
local EventNames = require(scriptParentParent.Analytics.EventNames)
local getCaptureShortcutSetupKeys = require(scriptParentParent.Utils.getCaptureShortcutSetupKeys)
local TakeCapture = require(scriptParentParent.Thunks.TakeCapture)

local useAnalytics = require(scriptParentParent.Analytics.useAnalytics)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useEffect = React.useEffect
local useKeyboardEnabled = require(scriptParentParent.Hooks.useKeyboardEnabled)
local usePlayShutterSound = require(scriptParentParent.Hooks.usePlayShutterSound)
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
    for _, value in (getCaptureShortcutSetupKeys()) do
        if UserInputService:IsKeyDown(value) then
            return true
        end
    end
    return false
end

return function()
    local var1 = useAnalytics()
    local var2 = useDispatch()

    local var3 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].IsActive
    end)

    local var4 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].IsCapturesCoreGuiEnabled
    end)

    local var5 = usePlayShutterSound()
    local var6 = useKeyboardEnabled()

    useEffect(function()
        if not var6 then
            return
        end

        if not var4 then
            return
        end

        local function func2()
            var5()

            if not SocialStopwatch.Stopwatch.get(SocialStopwatch.Events.CaptureTaken) then
                SocialStopwatch.Stopwatch.start(SocialStopwatch.Events.CaptureTaken)
            end
            var1.fireEvent(EventNames.CapturesEntrypointActivated)
            var1.fireEvent(EventNames.CapturesDesktopHotkeyCaptureTriggered)
            var2(TakeCapture())
        end

        ContextActionService:BindCoreAction("CaptureShortcutAction", function(_, userInputState)
            if userInputState ~= Enum.UserInputState.Begin or not func1() then
                return Enum.ContextActionResult.Pass
            end

            func2()
            return Enum.ContextActionResult.Sink
        end, false, Enum.KeyCode.One)

        return function()
            ContextActionService:UnbindCoreAction("CaptureShortcutAction")
        end
    end, { var3, var4, var6 })
end
