-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T09:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PinShortcutParent = script:FindFirstAncestor("PinShortcut").Parent

local AppBlox = require(PinShortcutParent.AppBlox)
local CentralOverlay = require(PinShortcutParent.CentralOverlay)
local Localization = require(PinShortcutParent.Localization)
local LoggingProtocol = require(PinShortcutParent.LoggingProtocol)
local Foundation = require(PinShortcutParent.Foundation)
local React = require(PinShortcutParent.React)
local RoactUtils = require(PinShortcutParent.RoactUtils)
local SharedFlags = require(PinShortcutParent.SharedFlags)
local UniversalAppPolicy = require(PinShortcutParent.UniversalAppPolicy)

local CloseCentralOverlay = CentralOverlay.Thunks.CloseCentralOverlay
local Enums = Foundation.Enums
local getAppFeaturePolicies = UniversalAppPolicy.getAppFeaturePolicies
local SnackbarWrapper = AppBlox.SnackbarWrapper
local TelemetryCounters = require(script.Parent.TelemetryCounters)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useLocalization = Localization.Hooks.useLocalization

local FFlagAddPinExperienceTargetDestinationGUACPolicy = SharedFlags.FFlagAddPinExperienceTargetDestinationGUACPolicy
local FFlagPinShortcutSnackbarTelemetryEnabled = require(script.Parent.Flags.FFlagPinShortcutSnackbarTelemetryEnabled)

return React.memo(function(tbl1) -- name: PinExperienceResultSnackbar
    local var1 = useDispatch()

    local closeSnackbar = React.useCallback(function()
        var1(CloseCentralOverlay())
    end, { var1 })

    local bool1 = tbl1.status == Enum.PinExperienceStatus.Success

    local bool2 = tbl1.status == Enum.PinExperienceStatus.AlreadyExists
    local experienceName = tbl1.experienceName

    local var3 = useLocalization({
        successDesktop = {
            "InstantApps.Shortcuts.Label.SuccessAddingExperienceToDesktop",
            experience_name = experienceName
        },
        successHomeScreen = {
            "InstantApps.Shortcuts.Label.SuccessAddingExperienceToHomeScreen",
            experience_name = experienceName
        },
        alreadyExists = {
            "InstantApps.Shortcuts.Label.ShortcutAlreadyExists",
            experience_name = experienceName
        },
        failedDesktop = {
            "InstantApps.Shortcuts.Label.FailedToAddExperienceToDesktop",
            experience_name = experienceName
        },
        failedHomeScreen = {
            "InstantApps.Shortcuts.Label.FailedToAddExperienceToHomeScreen",
            experience_name = experienceName
        },
        viewShortcut = { "InstantApps.Shortcuts.Label.ViewShortcut" },
        tryAgain = { "InstantApps.Shortcuts.Label.TryAgain" }
    })

    local var4 = if FFlagAddPinExperienceTargetDestinationGUACPolicy then getAppFeaturePolicies().getPinExperienceTargetDestination() else "HomeScreen"
    local var5, tbl2

    if bool1 then
        if var4 == "Desktop" then
            var5 = var3.successDesktop
        else
            var5 = var3.successHomeScreen
        end

        tbl2 = {
            name = Enums.IconName.CircleCheck,
            variant = Enums.IconVariant.Filled
        }
    elseif bool2 then
        var5 = var3.alreadyExists
        tbl2 = {
            name = Enums.IconName.CircleI
        }
    else
        if var4 == "Desktop" then
            var5 = var3.failedDesktop
        else
            var5 = var3.failedHomeScreen
        end
        tbl2 = {
            name = Enums.IconName.TriangleExclamation
        }
    end
    if FFlagPinShortcutSnackbarTelemetryEnabled then
        React.useEffect(function()
            LoggingProtocol.default:logRobloxTelemetryCounter(
                TelemetryCounters.SnackbarShown,
                1,
                {
                    action = if bool1 then "Success" elseif bool2 then "AlreadyExists" else "Failure"
                }
            )
        end, {})
    end

    local var6 = nil
    local var7 = nil

    if bool1 and tbl1.onViewShortcut then
        var6 = var3.viewShortcut
        var7 = function()
            if FFlagPinShortcutSnackbarTelemetryEnabled then
                LoggingProtocol.default:logRobloxTelemetryCounter(
                    TelemetryCounters.SnackbarButtonPressed,
                    1,
                    { action = "ViewShortcut" }
                )
            end
            closeSnackbar()
            tbl1.onViewShortcut()
        end
    elseif not bool1 and not bool2 and tbl1.onRetry then
        var6 = var3.tryAgain
        var7 = function()
            if FFlagPinShortcutSnackbarTelemetryEnabled then
                LoggingProtocol.default:logRobloxTelemetryCounter(TelemetryCounters.SnackbarButtonPressed, 1, { action = "TryAgain" })
            end

            closeSnackbar()
            tbl1.onRetry()
        end
    end

    local bool3 = bool1 or bool2

    return React.createElement(SnackbarWrapper, {
        titleText = var5,
        icon = tbl2,
        buttonText = var6,
        onButtonActivated = var7,
        closeSnackbar = closeSnackbar,
        autoDismissDelaySeconds = if bool3 then 5 else nil,
        hideCloseAffordance = not not bool3
    })
end)
