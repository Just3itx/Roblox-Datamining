-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local GuiService = game:GetService("GuiService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local CaptureService = require(scriptParentParent.Services.CaptureService)
local CapturesToastType = require(scriptParentParent.Enums.CapturesToastType)
local Constants = require(scriptParentParent.Constants)
local getAvatarAssets = require(scriptParentParent.Utils.getAvatarAssets)
local getScreenshotHud = require(scriptParentParent.Utils.getScreenshotHud)
local getUserMetadata = require(scriptParentParent.Utils.getUserMetadata)
local isEligibleForMoments = require(scriptParentParent.Utils.isEligibleForMoments)
local IXPServiceWrapper = require(scriptParentParentParent.IXPServiceWrapper).IXPServiceWrapper
local logCaptureEndLayerExposure = require(scriptParentParent.Utils.logCaptureEndLayerExposure)
local OverlayActivated = require(scriptParentParent.Actions.OverlayActivated)
local OverlayDeactivated = require(scriptParentParent.Actions.OverlayDeactivated)
local OverlayFlashActivated = require(scriptParentParent.Actions.OverlayFlashActivated)
local OverlayFlashDeactivated = require(scriptParentParent.Actions.OverlayFlashDeactivated)
local pendingCaptureToastAction = require(scriptParentParent.Utils.pendingCaptureToastAction)
local removeCoreUI = require(scriptParentParent.Utils.removeCoreUI)
local ToastTriggered = require(scriptParentParent.Actions.ToastTriggered)
local _Types = require(scriptParentParent.Types)

local FStringSocialCaptureTakenIXPLayer = require(scriptParentParentParent.SharedFlags).FStringSocialCaptureTakenIXPLayer
local FFlagBuildExperienceInGameCaptureToChat = require(scriptParentParentParent.SharedFlags).FFlagBuildExperienceInGameCaptureToChat
local FFlagMomentsCaptureEndIxpEnabled = require(scriptParentParent.Flags.FFlagMomentsCaptureEndIxpEnabled)

local bool1 = game:DefineFastFlag("DebugAPPEXP4747B", false)

local function hideGui(guiType: Enum.GuiType) -- Luacid: Inlined by compiler; 2 call sites recovered
    if GuiService:GetGuiIsVisible(guiType) then
        GuiService:ToggleGuiIsVisibleForCaptures(guiType)
    end
end

local function showGui(guiType: Enum.GuiType) -- Luacid: Inlined by compiler; 2 call sites recovered
    if not GuiService:GetGuiIsVisible(guiType) then
        GuiService:ToggleGuiIsVisibleForCaptures(guiType)
    end
end

local function hidePlayerGui() -- Luacid: Inlined by compiler; 1 call site recovered
    if GuiService:GetGuiIsVisible(Enum.GuiType.Custom) then
        GuiService:ToggleGuiIsVisibleForCaptures(Enum.GuiType.Custom)
    end
end

local function showPlayerGui() -- Luacid: Inlined by compiler; 1 call site recovered
    if not GuiService:GetGuiIsVisible(Enum.GuiType.Custom) then
        GuiService:ToggleGuiIsVisibleForCaptures(Enum.GuiType.Custom)
    end
end

return function(arg1)
    return function(arg2)
        local bool2 = false
        local bool3 = false

        if FFlagBuildExperienceInGameCaptureToChat then
            pendingCaptureToastAction.set(if arg1 then arg1.toastAction else nil)
        end

        arg2:dispatch(ToastTriggered(CapturesToastType.None))

        local overrideMouseIconBehavior = UserInputService.OverrideMouseIconBehavior
        UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceHide

        local screenshotHud = getScreenshotHud()

        if not bool1 and (not screenshotHud or screenshotHud.HidePlayerGuiForCaptures) then
            hidePlayerGui()
            bool3 = true
        end

        local var1 = nil
        if not bool1 then
            if not screenshotHud or screenshotHud.HideCoreGuiForCaptures then
                var1 = removeCoreUI()
                bool2 = true
            end

            hideGui(Enum.GuiType.CustomBillboards)
            hideGui(Enum.GuiType.PlayerNameplates)
        end

        arg2:dispatch(OverlayActivated())

        CaptureService:OnCaptureBegan()

        task.wait(0.1)

        local avatarAssets = getAvatarAssets()
        local userMetadata = getUserMetadata()

        if next(avatarAssets) == nil and next(userMetadata) == nil then
            CaptureService:SaveScreenshotCapture()
        else
            local input = { avatarItems = 0, userMetadata = 0 }
            if next(avatarAssets) == nil then
                avatarAssets = nil
            end

            input.avatarItems = avatarAssets
            if next(userMetadata) == nil then
                userMetadata = nil
            end

            input.userMetadata = userMetadata

            CaptureService:SaveScreenshotCapture(HttpService:JSONEncode(input))
        end

        task.wait()

        arg2:dispatch(OverlayFlashActivated())

        task.wait(0.5)

        CaptureService:OnCaptureEnded()

        arg2:dispatch(OverlayFlashDeactivated())
        arg2:dispatch(OverlayDeactivated())

        UserInputService.OverrideMouseIconBehavior = overrideMouseIconBehavior

        if bool3 then
            showPlayerGui()
        end

        if bool2 then
            var1()
        end

        showGui(Enum.GuiType.CustomBillboards)
        showGui(Enum.GuiType.PlayerNameplates)

        IXPServiceWrapper:LogUserLayerExposure(FStringSocialCaptureTakenIXPLayer)

        if FFlagMomentsCaptureEndIxpEnabled and isEligibleForMoments(arg2:getState()[Constants.RoduxKey].MomentsEligibility) then
            logCaptureEndLayerExposure()
        end
    end
end
