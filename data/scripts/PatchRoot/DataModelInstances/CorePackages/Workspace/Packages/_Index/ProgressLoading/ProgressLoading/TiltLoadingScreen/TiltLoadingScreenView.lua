-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProgressLoadingParent = script:FindFirstAncestor("ProgressLoading").Parent

local React = require(ProgressLoadingParent.React)
local Foundation = require(ProgressLoadingParent.Foundation)
local View = Foundation.View
local Progress = Foundation.Progress
local ProgressShape = Foundation.Enums.ProgressShape

local Badge = Foundation.Badge
local Icon = Foundation.Icon
local IconButton = Foundation.IconButton
local FoundationText = Foundation.Text
local Enums = Foundation.Enums
local IconSize = Enums.IconSize
local useTokens = Foundation.Hooks.useTokens
local useLocalization = require(ProgressLoadingParent.Localization).Hooks.useLocalization
local isPioneerLaunch = require(ProgressLoadingParent.PioneerUtils).isPioneerLaunch
local TiltLockup = require(script.Parent.Components.TiltLockup)
local TiltLoadingScreenStatusPanel = require(script.Parent.Components.TiltLoadingScreenStatusPanel)
local FFlagTiltLoadingScreenConsoleHints = require(ProgressLoadingParent.SharedFlags).FFlagTiltLoadingScreenConsoleHints

local _Types = require(script.Parent.Types)

return React.memo(function(arg1) -- name: TiltLoadingScreenView
    local var1 = useTokens()
    local var2 = useLocalization({
        autoTranslate = "CoreScripts.TopBar.LoadingScreen.AutoTranslate",
        back = if FFlagTiltLoadingScreenConsoleHints then "CoreScripts.TopBar.Back" else nil
    })

    local createElement = React.createElement
    local var3 = View

    local tbl1 = {
        tag = "size-full bg-surface-0",
        GroupTransparency = arg1.chromeReveal:map(function(num1: number): number
            return 1 - num1
        end),
        testId = "tilt-loading-screen-root"
    }

    local tbl2 = {
        Overlay = React.createElement(View, { tag = "size-full", backgroundStyle = var1.Color.Extended.Black.Black_50, ZIndex = 0 }),
        SafeArea = 0
    }
    local var4

    if arg1.showContent then
        local createElement2 = React.createElement
        local var5 = View
        local tbl3 = {
            tag = "size-full",
            padding = {
                left = UDim.new(0, arg1.safeAreaInsets.left),
                top = UDim.new(0, arg1.safeAreaInsets.top),
                right = UDim.new(0, arg1.safeAreaInsets.right),
                bottom = UDim.new(0, arg1.safeAreaInsets.bottom)
            },
            ZIndex = 1,
            testId = "tilt-loading-screen-safe-area"
        }

        local tbl4 = { CancelButton = 0, GamepadCancelHint = 0, Layout = 0 }
        local element

        if isPioneerLaunch() or arg1.isDirectionalInput then
            element = nil
        else
            element = React.createElement(View, {
                tag = "col align-x-left align-y-top size-full padding-xlarge",
                ZIndex = 2
            }, {
                Button = React.createElement(IconButton, {
                    icon = Enums.IconName.X,
                    variant = Enums.ButtonVariant.Standard,
                    size = Enums.InputSize.Large,
                    isCircular = true,
                    onActivated = arg1.onCancel,
                    testId = "tilt-loading-screen-cancel-button"
                })
            })
        end

        tbl4.CancelButton = element
        local element2

        if isPioneerLaunch() or not arg1.isDirectionalInput then
            element2 = nil
        else
            element2 = React.createElement(View, {
                tag = "col align-x-left align-y-bottom size-full padding-xlarge",
                ZIndex = 2,
                testId = "tilt-loading-screen-gamepad-cancel-hint"
            }, {
                Hint = React.createElement(View, {
                    tag = "row align-y-center gap-small auto-xy padding-x-medium"
                }, {
                    ButtonIcon = React.createElement(
                        Icon,
                        {
                            LayoutOrder = 1,
                            name = arg1.gamepadCancelIcon,
                            size = IconSize.Medium,
                            style = var1.Color.System.Contrast
                        }
                    ),
                    Label = React.createElement(
                        FoundationText,
                        {
                            LayoutOrder = 2,
                            Text = var2.back,
                            tag = "auto-xy text-title-large content-system-contrast"
                        }
                    )
                })
            })
        end

        tbl4.GamepadCancelHint = element2

        local createElement3 = React.createElement
        local var6 = View
        local tbl5 = { tag = "col size-full", ZIndex = 1 }

        local tbl6 = { Content = 0, StatusPanel = 0, ProgressBar = 0 }
        local createElement4 = React.createElement
        local var7 = View
        local tbl7 = {
            LayoutOrder = 1,
            tag = "col align-x-center align-y-center grow gap-large size-full-0 padding-x-xxlarge",
            testId = "tilt-loading-screen-lockup-slot"
        }

        local tbl8 = {
            Lockup = React.createElement(TiltLockup, {
                LayoutOrder = 1,
                gameName = if arg1.gameData then arg1.gameData.name else nil,
                creatorName = if arg1.gameData then arg1.gameData.creator else nil,
                isCreatorVerified = if arg1.gameData then arg1.gameData.verified else nil,
                thumbnailUrl = arg1.thumbnailUrl,
                onThumbnailLoaded = arg1.onThumbnailLoaded,
                animation = arg1.animation
            }),
            AutoTranslate = 0
        }
        local element3

        if arg1.isAutoTranslated then
            element3 = React.createElement(View, {
                LayoutOrder = 2,
                tag = "auto-xy",
                GroupTransparency = arg1.animation.creator.reveal:map(function(arg2): number
                    return 1 - arg2
                end)
            }, {
                Badge = React.createElement(Badge, {
                    text = var2.autoTranslate,
                    variant = Enums.BadgeVariant.Neutral,
                    shape = Enums.BadgeShape.Box,
                    icon = {
                        name = Enums.IconName.LanguageCharacters,
                        size = Enums.IconSize.XSmall,
                        position = Enums.IconPosition.Left
                    }
                })
            })
        else
            element3 = nil
        end

        tbl8.AutoTranslate = element3
        tbl6.Content = createElement4(var7, tbl7, tbl8)

        tbl6.StatusPanel = React.createElement(TiltLoadingScreenStatusPanel, {
            LayoutOrder = 3,
            status = arg1.statusPanel.status,
            statusText = arg1.statusPanel.statusText,
            queuePosition = arg1.statusPanel.queuePosition,
            queueTreatment = arg1.statusPanel.queueTreatment,
            followUserId = arg1.statusPanel.followUserId,
            isSubjectToChinaPolicies = arg1.statusPanel.isSubjectToChinaPolicies,
            onAutoJoinNewServer = arg1.statusPanel.onAutoJoinNewServer,
            onJoinNewServer = arg1.statusPanel.onJoinNewServer,
            onJoinTheLine = arg1.statusPanel.onJoinTheLine,
            onShowConnectionHealth = arg1.statusPanel.onShowConnectionHealth
        })
        local element4

        if arg1.statusPanel.queueTreatment == nil then
            element4 = React.createElement(
                View,
                {
                    LayoutOrder = 4,
                    testId = "tilt-loading-screen-progress-slot",
                    tag = {
                        ["size-full-0 auto-y padding-x-medium padding-bottom-xlarge"] = arg1.isMobile,
                        ["size-full-0 auto-y"] = not arg1.isMobile
                    }
                },
                {
                    Bar = React.createElement(Progress, { shape = ProgressShape.Bar, testId = "loading-screen-progress-bar" })
                }
            )
        else
            element4 = nil
        end

        tbl6.ProgressBar = element4
        tbl4.Layout = createElement3(var6, tbl5, tbl6)
        var4 = createElement2(var5, tbl3, tbl4)
    else
        var4 = nil
    end

    tbl2.SafeArea = var4
    return createElement(var3, tbl1, tbl2)
end)
