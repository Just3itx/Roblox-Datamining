-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileQRCode = script:FindFirstAncestor("ProfileQRCode")
local ProfileQRCodeParent = ProfileQRCode.Parent

local AppStorageService = game:GetService("AppStorageService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local IXPService = game:GetService("IXPService")

local Localization = require(ProfileQRCodeParent.Localization)
local React = require(ProfileQRCodeParent.React)
local RoactUtils = require(ProfileQRCodeParent.RoactUtils)
local SocialCommon = require(ProfileQRCodeParent.SocialCommon)
local UIBlox = require(ProfileQRCodeParent.UIBlox)
local UniversalAppPolicy = require(ProfileQRCodeParent.UniversalAppPolicy)
local AppUserLayers = require(ProfileQRCodeParent.ExperimentLayers).AppUserLayers
local FocusNavigationUtils = require(ProfileQRCodeParent.FocusNavigationUtils)

local HeaderBar = UIBlox.App.Bar.HeaderBar
local IconButton = UIBlox.App.Button.IconButton
local IconSize = UIBlox.App.ImageSet.Enum.IconSize
local Images = UIBlox.App.ImageSet.Images
local TooltipOrientation = UIBlox.App.Dialog.Enum.TooltipOrientation
local withTooltip = UIBlox.App.Dialog.TooltipV2.withTooltip
local makeBackButton = require(ProfileQRCodeParent.AppHeaderBar).makeBackButton

local ExternalEventConnection = RoactUtils.ExternalEventConnection
local InputUtilities = SocialCommon.Utils.InputUtilities

local EventNames = require(ProfileQRCode.Analytics.EventNames)
local TextKeys = require(ProfileQRCode.Common.TextKeys)

local useAnalytics = require(ProfileQRCode.Analytics.useAnalytics)
local useAppPolicy = UniversalAppPolicy.useAppPolicy

local useLocalization = Localization.Hooks.useLocalization
local useLastInputMode = FocusNavigationUtils.useLastInputMode
local FFlagProfileQRCodeFixFocusNavigation = require(ProfileQRCode.Flags.FFlagProfileQRCodeFixFocusNavigation)
local FFlagProfileQRCodeGamepadBackFix = require(ProfileQRCode.Flags.FFlagProfileQRCodeGamepadBackFix)

local function getTooltipWasShown(arg1): boolean -- Luacid: unused: defined but never referenced
    local var1 = arg1 or AppStorageService
    assert(var1 ~= nil, "AppStorageService is not nil")

    local success, result = pcall(function()
        return var1:GetItem("QrCodeScannerTooltipSeen")
    end)

    return if success and result ~= nil then result == "true" else false
end

local function setTooltipWasShown(arg1, bool1: boolean) -- Luacid: unused: defined but never referenced
    local var1 = arg1 or AppStorageService
    assert(var1 ~= nil, "AppStorageService is not nil")

    pcall(function()
        var1:SetItem("QrCodeScannerTooltipSeen", tostring(bool1))
        var1:Flush()
    end)
end

return function(tbl1)
    local bool1 = if FFlagProfileQRCodeFixFocusNavigation then useLastInputMode() == "Focus" else nil
    local var1 = useAnalytics()
    local var2 = useLocalization(
        {
            title = TextKeys.Title,
            tooltipBodyText = TextKeys.TooltipText,
            tooltipHeaderText = TextKeys.TooltipTitle
        }
    )
    local var3 = useAppPolicy(function(arg1)
        return arg1.getFriendCodeQrCodeScannerEnabled()
    end)

    local active, var5 = React.useState(false)
    React.useEffect(function()
        local var6 = tbl1.appStorageService or AppStorageService
        assert(var6 ~= nil, "AppStorageService is not nil")

        local success, result = pcall(function()
            return var6:GetItem("QrCodeScannerTooltipSeen")
        end)

        local bool2 = if success and result ~= nil then result == "true" else false
        var5(not bool2)
        if not bool2 then
            var1.fireEvent(EventNames.QRCodeScannerTooltipShown)
        end
    end, {})

    local callback = React.useCallback(function(arg1)
        if not InputUtilities.isActivationInput(arg1) or not active then
            return
        end

        var5(false)
        local var6 = tbl1.appStorageService or AppStorageService
        assert(var6 ~= nil, "AppStorageService is not nil")

        local bool2 = true

        pcall(function()
            var6:SetItem("QrCodeScannerTooltipSeen", tostring(bool2))
            var6:Flush()
        end)
    end, { active })

    local onActivated = React.useCallback(function()
        IXPService:LogUserLayerExposure(AppUserLayers.ProfileQRCodeScannerLayer)
        var1.fireEvent(EventNames.QRCodeScannerOpened)
        tbl1.openQrCodeScanner()
    end, { tbl1.openQrCodeScanner })

    local tooltipBodyText = var2.tooltipBodyText
    local tooltipHeaderText = var2.tooltipHeaderText

    local var8 = React.useCallback(function()
        local tbl2 = { bodyText = tooltipBodyText, headerText = tooltipHeaderText }

        local tbl3 = {
            active = active,
            DisplayOrder = 10,
            guiTarget = CoreGui,
            preferredOrientation = TooltipOrientation.Bottom
        }

        return withTooltip(tbl2, tbl3, function(onAbsolutePositionChanged)
            return React.createElement(IconButton, {
                icon = Images["icons/actions/scan"],
                iconSize = IconSize.Medium,
                onActivated = onActivated,
                size = UDim2.fromOffset(0, 0),
                onAbsolutePositionChanged = onAbsolutePositionChanged,
                [React.Change.AbsoluteSize] = onAbsolutePositionChanged
            }, {
                InputBeganConnection = React.createElement(ExternalEventConnection, { event = UserInputService.InputBegan, callback = callback })
            })
        end)
    end, {
        onActivated,
        var3,
        active,
        tooltipBodyText,
        tooltipHeaderText
    })
    local backButton = makeBackButton(tbl1.onClose)

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 56),
        LayoutOrder = tbl1.layoutOrder,
        ZIndex = 2
    }
    local tbl3 = { headerBar = 0 }
    local createElement2 = React.createElement
    local var9 = HeaderBar
    local tbl4 = {
        isSecondary = true,
        title = var2.title,
        backgroundTransparency = 1,
        barHeight = 56,
        renderLeft = 0,
        renderRight = 0
    }

    if not FFlagProfileQRCodeGamepadBackFix
        and (not FFlagProfileQRCodeFixFocusNavigation or bool1)
        and FFlagProfileQRCodeFixFocusNavigation
    then
        backButton = nil
    end

    tbl4.renderLeft = backButton

    if not var3 then
        var8 = nil
    end

    tbl4.renderRight = var8
    tbl3.headerBar = createElement2(var9, tbl4)
    return createElement(str1, tbl2, tbl3)
end
