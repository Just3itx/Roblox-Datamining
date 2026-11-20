-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local CorePackages = game:GetService("CorePackages")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local React = require(CorePackages.Packages.React)
local SignalsReact = require(CorePackages.Packages.SignalsReact)
local Foundation = require(CorePackages.Packages.Foundation)
local LinkingProtocol = require(CorePackages.Workspace.Packages.LinkingProtocol).LinkingProtocol
local useLocalization = require(CorePackages.Workspace.Packages.Localization).Hooks.useLocalization

local BuildModeLaunch = require(CorePackages.Workspace.Packages.BuildExperiencePlaytestLaunch.BuildModeLaunch)

local SettingsShowSignal = require(CorePackages.Workspace.Packages.CoreScriptsCommon).SettingsShowSignal
local GetPlaytestModeStore = require(CorePackages.Workspace.Packages.CoreScriptsRoactCommon.GetPlaytestModeStore)

local ObservableValue = require(RobloxGui.Modules.Chrome.ChromeShared.Service.ChromeUtils).ObservableValue

local useIsPlaytestMode = require(RobloxGui.Modules.Chrome.ChromeShared.Hooks.useIsPlaytestMode)
local useObservableValue = require(RobloxGui.Modules.Chrome.ChromeShared.Hooks.useObservableValue)

local EducationalTooltip = Foundation.EducationalTooltip
local OverlayProvider = Foundation.OverlayProvider
local PopoverSide = Foundation.Enums.PopoverSide
local PopoverAlign = Foundation.Enums.PopoverAlign
local ButtonVariant = Foundation.Enums.ButtonVariant

local bool1 = game:DefineFastFlag("PlaytestModeDismissTooltip", false)
local FFlagEnableConsoleExpControls = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableConsoleExpControls
local var1 = if bool1 then require(CorePackages.Workspace.Packages.Chrome).Enabled() else nil
local GamepadConnector = if bool1 and FFlagEnableConsoleExpControls and var1 then require(script.Parent.Parent.GamepadConnector) else nil
local bool2 = game:DefineFastFlag("PlaytestModeTooltipExcludeBuildMode", false)
local FFlagPlaytestModeTooltipOncePerWeek = require(CorePackages.Workspace.Packages.SharedFlags).FFlagPlaytestModeTooltipOncePerWeek
local FFlagPlaytestModeTooltipOnlyPrivateTesters = require(CorePackages.Workspace.Packages.SharedFlags).FFlagPlaytestModeTooltipOnlyPrivateTesters

local str1 = game:DefineFastString("PlaytestModeTooltipLearnMoreUrl", "https://about.roblox.com/community-standards")
local DisplayOrder = game:DefineFastInt("PlaytestModeTooltipDisplayOrder", -1)

local bool3 = false
local bool4 = false
local observableValue = if bool1 then ObservableValue.new(false) else nil

local function getCanShow(arg1, bool5: boolean?, bool6: boolean, bool7: boolean?)
    if FFlagPlaytestModeTooltipOncePerWeek and not bool6 then
        return false
    end

    if FFlagPlaytestModeTooltipOnlyPrivateTesters and bool7 ~= true then
        return false
    end

    if bool2 and BuildModeLaunch:hasBuildMode() then
        return false
    end

    if FFlagPlaytestModeTooltipOncePerWeek then
        if not (bool4 or GetPlaytestModeStore(false).getHasTooltipCooldownExpired()) then
            return false
        end
    elseif bool3 then
        return false
    end

    return not (arg1 == nil or arg1.current == nil) and (not bool1 or bool5 ~= false)
end

return React.memo(function(tbl1) -- name: PlaytestModeTooltip
    local var2 = useLocalization(
        FFlagPlaytestModeTooltipOnlyPrivateTesters
            and {
                title = "CoreScripts.FTUX.Heading.YouAreAnEarlyTester",
                text = "CoreScripts.FTUX.Description.WhiteMenuPreviewing",
                continueText = "CommonUI.Features.Action.OK",
                learnMoreText = "CommonUI.Features.Action.ViewDetails"
            }
            or {
                title = "CoreScripts.FTUX.Heading.ReadyToPlaytest",
                text = "CoreScripts.FTUX.Description.WhiteMenuPlaytestMode",
                continueText = "CommonUI.Features.Action.Continue",
                learnMoreText = "CommonUI.Features.Action.LearnMore"
            }
    )

    local var3 = useIsPlaytestMode()

    local var4 = if FFlagPlaytestModeTooltipOnlyPrivateTesters then SignalsReact.useSignalState(GetPlaytestModeStore(false).getIsPrivatePlaytester) else nil

    local var5 = if bool1 then useObservableValue(if GamepadConnector == nil then observableValue else GamepadConnector:getShowTopBar()) else nil

    local useState = React.useState
    local func1 = getCanShow
    local anchorRef = tbl1.anchorRef
    local var6 = if bool1 then var5 else nil
    local var7, var8 = useState((func1(anchorRef, var6, var3, var4)))

    if FFlagPlaytestModeTooltipOncePerWeek then
        React.useEffect(function()
            if var7 and not bool4 then
                bool4 = true
                GetPlaytestModeStore(false).markTooltipSeen()
            end
        end, { var7 })
    end

    local var9 = React.useCallback(function()
        if FFlagPlaytestModeTooltipOncePerWeek then
            bool4 = false
        else
            bool3 = true
        end
        var8(false)
    end, {})

    local onActivated = React.useCallback(function()
        LinkingProtocol.default:openURL(str1)
        if bool1 then
            var9()
            return
        end
        bool3 = true
        var8(false)
    end, { if bool1 then var9 else nil })

    React.useEffect(function()
        var8((getCanShow(tbl1.anchorRef, if bool1 then var5 else nil, var3, var4)))
    end, {
        tbl1.anchorRef,
        if bool1 then var5 else nil,
        if FFlagPlaytestModeTooltipOncePerWeek then var3 else nil,
        if FFlagPlaytestModeTooltipOnlyPrivateTesters then var4 else nil
    })

    if bool1 then
        React.useEffect(function()
            if var7 and not var5 then
                var9()
            end
        end, { var7, var5 })

        React.useEffect(function()
            local connection = SettingsShowSignal:connect(function(arg1)
                if arg1 then
                    var9()
                end
            end)

            return function()
                connection:Disconnect()
            end
        end, { var9 })
    end

    if not FFlagPlaytestModeTooltipOncePerWeek and (bool3 or not var3) or not var7 then
        return nil
    end

    return React.createElement(OverlayProvider, { DisplayOrder = DisplayOrder }, {
        Tooltip = React.createElement(EducationalTooltip, {
            anchorRef = tbl1.anchorRef,
            title = var2.title,
            text = var2.text,
            side = PopoverSide.Bottom,
            align = PopoverAlign.Start,
            isOpen = true,
            onClose = var9,
            actions = {
                {
                    text = var2.continueText,
                    variant = ButtonVariant.Emphasis,
                    onActivated = var9
                },
                {
                    text = var2.learnMoreText,
                    variant = ButtonVariant.Standard,
                    onActivated = onActivated
                }
            }
        })
    })
end)
