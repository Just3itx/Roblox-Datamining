-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceLoadingScript = script:FindFirstAncestor("ExperienceLoadingScript")
local ExperienceLoadingScriptParent = ExperienceLoadingScript.Parent

local ColorMode = require(ExperienceLoadingScriptParent.Foundation).Enums.ColorMode

local Players = require(ExperienceLoadingScriptParent.MockableProxyServices).Players
local ReplicatedFirst = require(ExperienceLoadingScriptParent.MockableProxyServices).ReplicatedFirst
local RunService = require(ExperienceLoadingScriptParent.MockableProxyServices).RunService
local VRService = require(ExperienceLoadingScriptParent.MockableProxyServices).VRService
local SplashScreenManager = require(ExperienceLoadingScriptParent.SplashScreenManager).SplashScreenManager
local IsVRAppBuild = require(ExperienceLoadingScriptParent.AppCommonLib).IsVRAppBuild

local LoadingScreenMilestones = require(ExperienceLoadingScriptParent.ProgressLoading.LoadingScreenMilestones)
local AbortReason = LoadingScreenMilestones.AbortReason
local FFlagLoadingScreenMilestones = require(ExperienceLoadingScriptParent.SharedFlags).FFlagLoadingScreenMilestones
local FFlagLoadingScreenControlMilestones = require(ExperienceLoadingScriptParent.SharedFlags).FFlagLoadingScreenControlMilestones
local FFlagTiltLoadingScreenEnterExitHold = require(ExperienceLoadingScriptParent.SharedFlags).FFlagTiltLoadingScreenEnterExitHold

local FFlagTiltLoadingScreenDismissOnLoaded = require(ExperienceLoadingScriptParent.SharedFlags).FFlagTiltLoadingScreenDismissOnLoaded
local FFlagEnableTiltLoadingScreen = require(ExperienceLoadingScriptParent.SharedFlags).FFlagEnableTiltLoadingScreen

local CoreGui = game:GetService("CoreGui")

local game2 = require(ExperienceLoadingScriptParent.MockableProxyServices).game
local waitProxy = require(ExperienceLoadingScriptParent.MockableProxyServices).waitProxy
local settingsProxy = require(ExperienceLoadingScriptParent.MockableProxyServices).settingsProxy

game:DefineFastInt("FPSAwareSplashScreenTimeout", 30)

local UIBlox = require(ExperienceLoadingScriptParent.UIBlox)
local UIBloxInGameConfig = require(ExperienceLoadingScriptParent.CoreScriptsInitializer).UIBloxInGameConfig
UIBlox.init(UIBloxInGameConfig)

local Constants = UIBlox.App.Style.Constants

local UiModeStyleProvider = require(ExperienceLoadingScriptParent.Style).UiModeStyleProvider

local Create = require(ExperienceLoadingScriptParent.AppCommonLib).Create
local LoadingScreen = require(ExperienceLoadingScript.LoadingScreen)
local LoadingScreenReducer = require(ExperienceLoadingScript.Reducers.LoadingScreenReducer)
local LoggingProtocol = require(ExperienceLoadingScriptParent.LoggingProtocol)

local function GenerateDevGUIBlackoutCurtain()
    local var1 = Create("ScreenGui")({ Name = "DevGUIBlackoutCurtain", DisplayOrder = 8, IgnoreGuiInset = true })

    Create("Frame")({
        Name = "BlackFrame",
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0,
        Size = UDim2.fromScale(10, 10),
        Position = UDim2.fromOffset(0, 0),
        Active = true,
        Parent = var1
    })
    var1.Parent = CoreGui

    return var1
end

local function mountTiltLoadingScreen(placeId, callback: (...any) -> (...any), milestones)
    local react = require(ExperienceLoadingScriptParent.React)
    local reactRoblox = require(ExperienceLoadingScriptParent.ReactRoblox)
    local tiltLoadingScreen = require(ExperienceLoadingScriptParent.ProgressLoading).TiltLoadingScreen

    local robloxLoadingGui = Instance.new("Folder")
    robloxLoadingGui.Name = "RobloxLoadingGUI"
    robloxLoadingGui.Parent = CoreGui

    local root = reactRoblox.createRoot(robloxLoadingGui)
    local bool1 = false
    local function unmount() -- Luacid: Inlined by compiler; 1 call site recovered
        if FFlagLoadingScreenMilestones and milestones then
            milestones.abort(AbortReason.Unmounted)
        end
        root:unmount()
        robloxLoadingGui:Destroy()
    end
    local function onCancel(bool2: boolean?, bool3: boolean?)
        if bool1 or bool3 and game2:IsLoaded() then
            return
        end
        bool1 = true
        if FFlagLoadingScreenMilestones and milestones then
            milestones.abort(AbortReason.Cancelled)
        end
        if bool2 then
            LoggingProtocol.default:logEventOnce("first_experience_cancelled")
        end
        game2:Shutdown()
    end

    local createElement = react.createElement
    local tbl1 = {
        milestones = if FFlagLoadingScreenMilestones then milestones else nil,
        placeId = placeId,
        onCancel = onCancel,
        onDismissComplete = 0
    }

    function tbl1.onDismissComplete()
        if FFlagTiltLoadingScreenDismissOnLoaded then
            callback()
            return
        end
        if FFlagLoadingScreenMilestones and milestones then
            milestones.complete()
        end

        unmount()
        callback()
        LoggingProtocol.default:logEventOnce("first_experience_interactive")
    end

    root:render(createElement(tiltLoadingScreen, tbl1))

    return unmount
end

local function func1(placeId, arg1)
    local bool1 = true
    local bool2 = false
    local bool3 = false

    local var1 = nil
    local var2 = nil
    local var3 = nil
    local bool4 = false
    local var4 = nil

    local var5 = GenerateDevGUIBlackoutCurtain()

    local roact = nil

    local function func2() -- Luacid: Inlined by compiler; 9 call sites recovered
        if var5 then
            var5.Enabled = false
            var5:Destroy()
            var5 = nil
        end
    end

    local function func3(placeId2)
        roact = require(ExperienceLoadingScriptParent.Roact)
        local rodux = require(ExperienceLoadingScriptParent.Rodux)
        local roactRodux = require(ExperienceLoadingScriptParent.RoactRodux)
        local store = rodux.Store.new(LoadingScreenReducer, {}, { rodux.thunkMiddleware })

        local loadingScreenUi = roact.createElement(
            LoadingScreen,
            {
                placeId = placeId2,
                milestones = if FFlagLoadingScreenControlMilestones then var4 else nil
            }
        )
        local element2 = roact.createElement(roactRodux.StoreProvider, { store = store }, { roact.createElement(
                UiModeStyleProvider,
                {
                    style = {
                        themeName = ColorMode.Dark,
                        fontName = Constants.FontName.Gotham
                    }
                },
                { loadingScreenUI = loadingScreenUi }
            ) })

        local element3 = roact.createElement("Folder", nil, element2)
        local var6 = roact.mount(element3, CoreGui, "RobloxLoadingGUI")

        RunService.Heartbeat:Wait()
        var5.Enabled = false
        return var6
    end

    local function func4()
        if FFlagTiltLoadingScreenDismissOnLoaded and var3 then
            var3()
            var3 = nil
            return
        end
        if not roact then
            return
        end

        waitProxy(0.6)
        if var2 == nil then
            return
        end
        if FFlagLoadingScreenControlMilestones and var4 then
            var4.record(LoadingScreenMilestones.Milestone.ScreenHidden)
            var4.complete()
        end

        roact.unmount(var2)
        var2 = nil
    end

    local function func5(num1: number)
        bool1 = false

        func4()

        SplashScreenManager.initialize(num1 / 2, game:GetFastInt("FPSAwareSplashScreenTimeout"), num1)
        SplashScreenManager.addStatusChangeListener(function(arg2)
            bool1 = arg2
            if bool1 and var1 then
                var1()
            end
        end)
        var5.Enabled = true

        require(ExperienceLoadingScript.LoadingScreen3D).Parent = var5
    end

    local function func6() -- Luacid: Inlined by compiler; 2 call sites recovered
        if not Players.CharacterAutoLoads then
            return
        end

        local localPlayer = Players.LocalPlayer
        if not localPlayer then
            Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
            localPlayer = Players.LocalPlayer
        end
        if not localPlayer.Character then
            localPlayer.CharacterAdded:Wait()
        end
    end

    local function func7()
        if game2:IsLoaded() then
            if FFlagLoadingScreenControlMilestones and var4 then
                var4.dismissRequested(LoadingScreenMilestones.DismissSource.NormalReady)
            end

            func6()
            bool2 = true
            if var1 then
                var1()
            end

            return
        end

        local connection = nil
        connection = game2.Loaded:Connect(function()
            connection:Disconnect()
            connection = nil
            if FFlagLoadingScreenControlMilestones and var4 then
                var4.dismissRequested(LoadingScreenMilestones.DismissSource.NormalReady)
            end

            func6()
            bool2 = true
            if var1 then
                var1()
            end
        end)
    end

    if VRService.VREnabled or IsVRAppBuild() then
        func5(arg1)
    elseif FFlagEnableTiltLoadingScreen then
        if ReplicatedFirst:IsDefaultLoadingGuiRemoved() then
            func2()
            ReplicatedFirst:SetDefaultLoadingGuiRemoved()
            LoggingProtocol.default:logEventOnce("first_experience_interactive")
            return
        end
        local connection = nil
        local bool5 = true
        local function cleanUpTilt() -- Luacid: Inlined by compiler; 5 call sites recovered
            bool5 = false
            if connection then
                connection:Disconnect()
                connection = nil
            end

            func2()
        end

        local var6 = if FFlagLoadingScreenMilestones then LoadingScreenMilestones.start({
            page = LoadingScreenMilestones.Page.TiltLoadingScreen,
            holdEnabled = FFlagTiltLoadingScreenEnterExitHold,
            reducedMotion = UserSettings():GetService("UserGameSettings").ReducedMotion
        }) else nil

        local func8 = mountTiltLoadingScreen(placeId, function() -- name: onTiltDismissComplete
            if not FFlagTiltLoadingScreenDismissOnLoaded then
                cleanUpTilt()
                return
            end

            bool4 = true
            if var1 then
                var1()
            end
        end, var6)
        var3 = FFlagTiltLoadingScreenDismissOnLoaded and function()
            if FFlagLoadingScreenMilestones and var6 then
                var6.complete()
            end
            func8()
            cleanUpTilt()
        end or var3

        local function transitionToVR() -- Luacid: Inlined by compiler; 2 call sites recovered
            if not bool5 then
                return
            end
            if FFlagLoadingScreenMilestones and var6 then
                var6.abort(AbortReason.VRHandoff)
            end

            cleanUpTilt()
            func8()
            if FFlagTiltLoadingScreenDismissOnLoaded then
                var3 = nil
                var1 = nil
            end
            func1(placeId, arg1)
        end

        connection = VRService:GetPropertyChangedSignal("VREnabled"):Connect(function()
            if VRService.VREnabled then
                transitionToVR()
            end
        end)

        if VRService.VREnabled then
            transitionToVR()
        end

        if bool5 then
            RunService.Heartbeat:Wait()
            if bool5 then
                var5.Enabled = false
            end
        end
        if not (FFlagTiltLoadingScreenDismissOnLoaded and bool5) then
            return
        end
    else
        VRService:GetPropertyChangedSignal("VREnabled"):Connect(function()
            if not VRService.VREnabled then
                return
            end

            if FFlagLoadingScreenControlMilestones and var4 then
                var4.abort(AbortReason.VRHandoff)
            end
            func5(arg1)
        end)

        if FFlagLoadingScreenControlMilestones and not ReplicatedFirst:IsDefaultLoadingGuiRemoved() then
            var4 = LoadingScreenMilestones.start({
                page = LoadingScreenMilestones.Page.LoadingScreenView,
                holdEnabled = false,
                reducedMotion = UserSettings():GetService("UserGameSettings").ReducedMotion
            })
        end
        var2 = func3(placeId)
    end

    var1 = function()
        if VRService.VREnabled then
            if bool1 or settingsProxy().Rendering.QualityLevel ~= Enum.QualityLevel.Automatic then
                func2()
                ReplicatedFirst:SetDefaultLoadingGuiRemoved()
                LoggingProtocol.default:logEventOnce("first_experience_interactive")
            end

            return
        end

        if not bool2 and not bool3 then
            return
        end

        if FFlagTiltLoadingScreenDismissOnLoaded and var3 and not bool4 then
            return
        end
        func4()
        func2()
        ReplicatedFirst:SetDefaultLoadingGuiRemoved()
        LoggingProtocol.default:logEventOnce("first_experience_interactive")
    end

    ReplicatedFirst.FinishedReplicating:Connect(func7)
    if ReplicatedFirst:IsFinishedReplicating() then
        func7()
    end

    ReplicatedFirst.RemoveDefaultLoadingGuiSignal:Connect(function()
        if FFlagLoadingScreenControlMilestones and var4 then
            var4.dismissRequested(LoadingScreenMilestones.DismissSource.DeveloperOverride)
        end
        bool3 = true
        if var1 then
            var1()
        end
    end)
    if not ReplicatedFirst:IsDefaultLoadingGuiRemoved() then
        return
    end

    if FFlagLoadingScreenControlMilestones and var4 then
        var4.dismissRequested(LoadingScreenMilestones.DismissSource.DeveloperOverride)
    end
    bool3 = true
    if var1 then
        var1()
    end
end

return func1
