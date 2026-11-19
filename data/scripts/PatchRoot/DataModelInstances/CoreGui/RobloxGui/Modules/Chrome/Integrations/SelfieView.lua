-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local Service = require(Chrome.Service)
local ChromeUtils = require(Chrome.ChromeShared.Service.ChromeUtils)
local VideoCaptureService = game:GetService("VideoCaptureService")
local FaceAnimatorService = game:GetService("FaceAnimatorService")
local SocialService = game:GetService("SocialService")
local StarterGui = game:GetService("StarterGui")
local CommonIcon = require(Chrome.Integrations.CommonIcon)
local MappedSignal = ChromeUtils.MappedSignal

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local TopBar = RobloxGui.Modules.TopBar
local Constants = require(TopBar.Constants)
local var1 = Constants.ApplyDisplayScale(Constants.TopBarHeight)

local SelfieView = Chrome.Parent.SelfieView
local GetFFlagChromeSelfViewIgnoreCoreGui = require(Chrome.Flags.GetFFlagChromeSelfViewIgnoreCoreGui)

local SideSheetPlacement = require(CorePackages.Workspace.Packages.Chrome).Enums.SideSheetPlacement

local FFlagTokenizeUnibarConstantsWithStyleProvider = require(Chrome.ChromeShared.Flags).FFlagTokenizeUnibarConstantsWithStyleProvider

local FFlagEnableConsoleExpControls = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableConsoleExpControls

local var2 = require(SelfieView)
local FaceChatUtils = require(SelfieView.Utils.FaceChatUtils)
local SizingUtils = require(SelfieView.Utils.SizingUtils)
local SelfieViewPolicy = require(SelfieView.Utils.SelfieViewPolicy)
local AvailabilitySignalState = require(Chrome.ChromeShared.Service.ChromeUtils).AvailabilitySignalState
local WindowSizeSignal = require(Chrome.ChromeShared.Service.WindowSizeSignal)
local UnibarStyle = require(CorePackages.Workspace.Packages.Chrome).UnibarStyle

local ViewportUtil = require(Chrome.ChromeShared.Service.ViewportUtil)
local size = SizingUtils.getSize(ViewportUtil.screenSize:get(), false)
local windowSizeSignal = WindowSizeSignal.new(size.X, size.Y)
local Constants2 = require(Chrome.ChromeShared.Unibar.Constants)

local var3 = require(RobloxGui.Modules.SelfView.Analytics).new()

local SELFIE_VIEW_ID = Constants2.SELFIE_VIEW_ID

local mappedSignal = MappedSignal.new(Service:onIntegrationStatusChanged(), function()
    return Service:isWindowOpen(SELFIE_VIEW_ID)
end)

local var4 = nil
local var5 = nil

local var6 = Service:register({
    id = SELFIE_VIEW_ID,
    label = "CoreScripts.TopBar.SelfViewLabel",
    sideSheetPlacement = SideSheetPlacement.BelowFold,
    windowSize = windowSizeSignal,
    windowDefaultOpen = false,
    initialAvailability = AvailabilitySignalState.Unavailable,
    persistWindowState = true,
    activated = function()
        Service:toggleWindow(SELFIE_VIEW_ID)
    end,
    isActivated = mappedSignal,
    draggable = true,
    cachePosition = true,
    components = {
        Icon = function(_)
            local iconSize = if FFlagTokenizeUnibarConstantsWithStyleProvider then UnibarStyle.use().ICON_SIZE else Constants2.ICON_SIZE
            return React.createElement("Frame", {
                Size = UDim2.new(0, iconSize, 0, iconSize),
                BackgroundTransparency = 1
            }, {
                CommonIcon("icons/controls/selfieOff", "icons/controls/selfie", mappedSignal),
                CameraStatusDot = if var2.useCameraOn() and not Service:isWindowOpen(SELFIE_VIEW_ID) then React.createElement(var2.CameraStatusDot, { Position = UDim2.fromScale(0.8, 0.7), ZIndex = 2 }) else nil
            }, {})
        end,
        Window = function(_)
            local var6 = Service:dragConnection(SELFIE_VIEW_ID)
            return React.createElement(
                var2.Window,
                {
                    id = SELFIE_VIEW_ID,
                    windowSize = windowSizeSignal,
                    isDraggedOut = not (var6 == nil) and var6.connection ~= nil
                },
                {}
            )
        end
    }
})

ViewportUtil.screenSize:connect(function(arg1)
    if not Service:isWindowOpen(SELFIE_VIEW_ID) then
        local size2 = SizingUtils.getSize(arg1, windowSizeSignal:getIsLarge())
        windowSizeSignal:requestSize(size2.X, size2.Y)
    end
end, true)

local function func1()
    local coreGuiEnabled = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.SelfView)
    if not (GetFFlagChromeSelfViewIgnoreCoreGui() or coreGuiEnabled) then
        if FaceChatUtils.isCameraOn() then
            FaceChatUtils.toggleVideoAnimation()
        end
        var6.availability:unavailable()
        return
    end

    local permissions = FaceChatUtils.getPermissions()

    local var7 = permissions.placeCamEnabled or permissions.placeMicEnabled
    local var8 = permissions.userCamEligible or permissions.userMicEligible
    if not (var7 and var8) then
        var6.availability:unavailable()
        return
    end

    var6.availability:available()
end

local function func2() -- Luacid: Inlined by compiler; 1 call site recovered
    local permissions = FaceChatUtils.getPermissions()
    var3:reportExperienceSettings(true, permissions.placeCamEnabled, permissions.placeMicEnabled)
    var3:reportUserAccountSettings(permissions.userCamEnabled, permissions.userMicEnabled)
end

if FFlagEnableConsoleExpControls then
    local var7 = SelfieViewPolicy.PolicyImplementation.read()

    if not (var7 and SelfieViewPolicy.Mapper(var7).eligibleForSelfieViewFeature()) then
        var6.availability:forceUnavailable()
    end
end

if game:GetEngineFeature("VideoCaptureService") then
    func1()
    VideoCaptureService.Started:Connect(func1)
    VideoCaptureService.Stopped:Connect(func1)
    VideoCaptureService.DevicesChanged:Connect(func1)
    FaceAnimatorService:GetPropertyChangedSignal("VideoAnimationEnabled"):Connect(func1)
    FaceAnimatorService:GetPropertyChangedSignal("AudioAnimationEnabled"):Connect(func1)
    func2()
end

StarterGui.CoreGuiChangedSignal:Connect(func1)

if game:GetEngineFeature("EnableSelfViewToggleApi") then
    if var4 then
        var4:Disconnect()
    end

    if var5 then
        var5:Disconnect()
    end

    local _connection = SocialService.SelfViewVisible:Connect(function(selfViewPosition: Enum.SelfViewPosition)
        local xOffset = Constants.ApplyDisplayScale(Constants.ScreenSideOffset)

        if Service:isWindowOpen(SELFIE_VIEW_ID) then
            return
        end
        local var7 = windowSizeSignal:get()
        local var8 = ViewportUtil.screenSize:get()
        local offset = nil

        if selfViewPosition == Enum.SelfViewPosition.TopLeft then
            offset = UDim2.fromOffset(xOffset, Constants2.WINDOW_DEFAULT_PADDING)
        elseif selfViewPosition == Enum.SelfViewPosition.TopRight then
            offset = UDim2.fromOffset(var8.X - (var7.X.Offset + xOffset), Constants2.WINDOW_DEFAULT_PADDING)
        elseif selfViewPosition == Enum.SelfViewPosition.BottomLeft then
            offset = UDim2.fromOffset(xOffset, var8.Y - (var1 + var7.Y.Offset + Constants2.WINDOW_DEFAULT_PADDING))
        elseif selfViewPosition == Enum.SelfViewPosition.BottomRight then
            offset = UDim2.fromOffset(
                var8.X - (var7.X.Offset + xOffset),
                var8.Y - (var1 + var7.Y.Offset + Constants2.WINDOW_DEFAULT_PADDING)
            )
        end

        Service:toggleWindow(SELFIE_VIEW_ID)
        if offset then
            Service:updateWindowPosition(SELFIE_VIEW_ID, offset)
        end
    end)

    local _connection2 = SocialService.SelfViewHidden:Connect(function()
        if Service:isWindowOpen(SELFIE_VIEW_ID) then
            Service:toggleWindow(SELFIE_VIEW_ID)
        end
    end)
end

return var6
