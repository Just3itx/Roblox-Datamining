-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local CoreGuiCommon = require(BuildExperienceParent.CoreGuiCommon)
local Display = require(BuildExperienceParent.Display)
local Foundation = require(BuildExperienceParent.Foundation)
local Motion = require(BuildExperienceParent.Motion)
local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local BuildPillMenuPageHost = require(BuildExperience.Components.BuildPillMenu.BuildPillMenuPageHost)
local PublishSheetController = require(BuildExperience.Components.PublishSheet.PublishSheetController)
local getCurrentExperienceProject = require(BuildExperience.utils.getCurrentExperienceProject)
local useHardwareInsets = require(script.Parent.useHardwareInsets)
local FFlagBuildCheckGamePermissions = require(BuildExperience.Flags.FFlagBuildCheckGamePermissions)
local useGamePermissions = require(BuildExperience.useGamePermissions)

local Image = Foundation.Image
local IconButton = Foundation.IconButton
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance
local useOverlay = Foundation.Hooks.useOverlay
local usePreferences = Foundation.Hooks.usePreferences
local useTokens = Foundation.Hooks.useTokens

local function noop() end

local function createToolbarButtons(tbl1, onActivated: (...any) -> (...any), str1: string, arg1)
    local isDisabled = FFlagBuildCheckGamePermissions and not arg1.canEditOnBuild
    if tbl1.isSelecting then
        return {
            Cancel = React.createElement(IconButton, {
                LayoutOrder = 1,
                icon = IconName.X,
                onActivated = tbl1.onSelectionCancelled or noop,
                size = InputSize.Medium,
                testId = `{str1}-cancel-selection`,
                variant = ButtonVariant.Utility
            }),
            Confirm = if tbl1.onSelectionConfirmed == nil then nil else React.createElement(IconButton, {
                LayoutOrder = 2,
                icon = IconName.CheckLarge,
                isDisabled = isDisabled,
                onActivated = tbl1.onSelectionConfirmed,
                size = InputSize.Medium,
                testId = `{str1}-confirm-selection`,
                variant = ButtonVariant.Utility
            })
        }
    end

    local tbl2 = {
        Chat = React.createElement(IconButton, {
            LayoutOrder = 1,
            icon = IconName.Nebula,
            onActivated = tbl1.onActivated,
            size = InputSize.Medium,
            testId = `{str1}-chat`,
            variant = ButtonVariant.Utility
        }),
        Select = React.createElement(IconButton, {
            LayoutOrder = 2,
            icon = IconName.CursorStars,
            isDisabled = isDisabled,
            onActivated = tbl1.onSelectionActivated or noop,
            size = InputSize.Medium,
            testId = `{str1}-select`,
            variant = ButtonVariant.Utility
        }),
        Capture = React.createElement(IconButton, {
            LayoutOrder = 3,
            icon = IconName.FrameCameraCenter,
            isDisabled = isDisabled,
            onActivated = tbl1.onCaptureActivated or noop,
            size = InputSize.Medium,
            testId = `{str1}-capture`,
            variant = ButtonVariant.Utility
        }),
        Publish = React.createElement(IconButton, {
            LayoutOrder = 4,
            icon = IconName.ArrowUpRightFromSquare,
            isDisabled = FFlagBuildCheckGamePermissions and not arg1.canPublish,
            onActivated = onActivated,
            size = InputSize.Medium,
            testId = `{str1}-publish`,
            variant = ButtonVariant.Utility
        })
    }
    if tbl1.isLibraryMode then
        tbl2.Select = nil
        tbl2.Capture = nil
    end
    return tbl2
end

local function InGameBuildShell(tbl1)
    local isOpen, var2 = React.useState(false)
    local activePage, var4 = React.useState(nil)
    local target, var6 = React.useState(nil)
    local var7 = if FFlagBuildCheckGamePermissions then useGamePermissions({ universeId = getCurrentExperienceProject().universeId }) else nil

    local onActivated = React.useCallback(function()
        local currentExperienceProject = getCurrentExperienceProject()
        if currentExperienceProject.universeId == nil then
            return
        end
        var6({
            universeId = currentExperienceProject.universeId,
            placeId = currentExperienceProject.placeId,
            sessionId = nil,
            isNewGameTarget = false
        })

        var2(true)
    end, {})
    local onClose = React.useCallback(function()
        var2(false)
    end, {})
    local var1 = React.useCallback(function()
        var4(nil)
    end, {})
    local navigateToSubPage = React.useCallback(function(screen: string, tbl2)
        var4({
            type = "screen",
            screen = screen,
            target = {
                universeId = tbl2.universeId,
                placeId = tbl2.placeId,
                sessionId = tbl2.sessionId,
                isNewGameTarget = tbl2.isNewGameTarget or false
            }
        })
    end, {})
    local var11 = useTokens()
    local reducedMotion = usePreferences().reducedMotion
    local var12 = useOverlay()
    local var13 = useHardwareInsets(var12)
    local displayStore = Display.GetDisplayStore(false)
    local keepOutAreasStore = CoreGuiCommon.Stores.GetKeepOutAreasStore(false)
    local var14 = SignalsReact.useSignalState(displayStore.getGuiInset)
    local var15, ref = React.useState(nil)
    local var17 = SignalsReact.useSignalState(displayStore.getViewportSize)
    local var18 = SignalsReact.useSignalState(displayStore.getDisplaySize)
    local bool1 = var17.X > var17.Y
    local bool2 = not (var18 == nil) and var18 ~= Enum.DisplaySize.Small
    local bool3 = bool2 or tbl1.isVisible ~= false
    local var19, var20 = React.useState(nil)
    local var3 = React.useCallback(function(arg1)
        var20(arg1)
    end, {})
    local size1200 = var11.Size.Size_1200
    local var22 = React.useMemo(function()
        return {
            visible = Motion.createState({ progress = 1 }, {
                default = Motion.transition({ duration = if reducedMotion then 0 else var11.Time.Time_300, easingStyle = var11.Ease.StandardOut })
            }),
            hidden = Motion.createState({ progress = 0 }, {
                default = Motion.transition({ duration = if reducedMotion then 0 else var11.Time.Time_100, easingStyle = var11.Ease.StandardIn })
            })
        }
    end, { reducedMotion, var11 })

    local var23, var24 = Motion.useMotion(if bool3 then var22.visible else var22.hidden)
    local var25, var26 = React.useState(bool3)

    React.useEffect(function()
        local bool4 = false
        if not bool3 then
            var24(var22.hidden, {
                onAnimationComplete = function(arg1)
                    if bool4 or arg1 ~= true then
                        return
                    end

                    if tbl1.onInsetsChanged ~= nil then
                        tbl1.onInsetsChanged(0, 0, 0)
                    end
                    var26(false)
                end
            })
        else
            var26(true)
            var24(var22.visible)
        end
        return function()
            bool4 = true
        end
    end, {
        var24,
        var22,
        bool3,
        tbl1.onInsetsChanged
    })
    local var27, var28 = React.useState(0)
    local var29, var30 = React.useState(0)
    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var28(arg1.AbsoluteSize.Y)
    end, {})
    local var32 = React.useCallback(function(arg1)
        var30(arg1.AbsoluteSize.X)
        keepOutAreasStore.setKeepOutArea("build-shell-right-inset", arg1.AbsolutePosition, arg1.AbsoluteSize)
    end, { keepOutAreasStore })
    local var5 = React.useCallback(function(arg1)
        if tbl1.onInsetsChanged ~= nil then
            tbl1.onInsetsChanged(
                0,
                if not bool1 or bool2 then 0 else arg1.AbsoluteSize.X,
                if bool1 or bool2 then 0 else arg1.AbsoluteSize.Y
            )
        end
    end, { bool1, tbl1.onInsetsChanged, bool2 })
    React.useEffect(function()
        if bool2 and tbl1.onInsetsChanged ~= nil then
            tbl1.onInsetsChanged(0, 0, 0)
        end
    end, { tbl1.onInsetsChanged, bool2 })
    React.useEffect(function()
        if not var25 or not bool1 or bool2 then
            keepOutAreasStore.removeKeepOutArea("build-shell-right-inset")
        end
    end, {
        bool1,
        var25,
        keepOutAreasStore,
        bool2
    })

    React.useEffect(function()
        return function()
            keepOutAreasStore.removeKeepOutArea("build-shell-right-inset")
        end
    end, { keepOutAreasStore })
    local progress = var23.progress
    local var34 = progress:map(function(num1: number): UDim2
        return UDim2.new(1, var29 * (1 - num1), 0, 0)
    end)
    local var35 = progress:map(function(num1: number): UDim2
        return UDim2.new(1, -var29 * num1 + 1, 0, 0)
    end)
    local var36 = progress:map(function(num1: number): UDim2
        return UDim2.new(0, 0, 1, var27 * (1 - num1))
    end)
    local var37 = progress:map(function(num1: number): UDim2
        return UDim2.new(0, -1, 1, -var27 * num1 + 1)
    end)
    local var38 = progress:map(function(num1: number): UDim2
        return UDim2.new(1, -(if bool1 then var29 else 0) * num1 + 1, 1, -(if bool1 then 0 else var27) * num1 + 1)
    end)
    local var39 = progress:map(function(num1: number): UDim2
        if bool2 then
            return UDim2.fromOffset(0, 0)
        end
        return UDim2.fromOffset((if bool1 then var29 else 0) * num1, (if bool1 then 0 else var27) * num1)
    end)

    local surface100 = var11.Color.Surface.Surface_100
    local imageStyle = progress:map(function(num1: number)
        return {
            Color3 = surface100.Color3,
            Transparency = 1 - (1 - surface100.Transparency) * num1
        }
    end)

    local createElement = React.createElement
    local var41 = View
    local tbl2 = {
        Visible = var25,
        tag = "size-full",
        testId = tbl1.testId or "in-game-build-shell"
    }
    local tbl3 = {
        FloatingToolbarBounds = 0,
        InsetReporter = 0,
        RightInset = 0,
        TopRightInnerCorner = 0,
        BottomLeftInnerCorner = 0,
        BottomRightInnerCorner = 0,
        BottomBar = 0
    }
    local element

    if bool2 then
        element = React.createElement(View, {
            Position = UDim2.fromOffset(var13.left + var11.Padding.Large, var13.top + var11.Padding.Large),
            Size = UDim2.new(
                1,
                -(var13.left + var13.right + var11.Padding.Large * 2),
                1,
                -(var13.top + var13.bottom + var11.Padding.Large * 2)
            ),
            ref = var3,
            testId = "in-game-build-shell-floating-toolbar-bounds"
        }, {
            Toolbar = React.createElement(View, {
                Visible = bool3,
                ZIndex = 1000,
                onActivated = noop,
                stateLayer = {
                    affordance = StateLayerAffordance.None
                },
                tag = "col align-x-center gap-xsmall position-center-right anchor-center-right auto-xy padding-xsmall radius-medium bg-surface-100",
                testId = "in-game-build-shell-floating-toolbar"
            }, {
                DragDetector = React.createElement("UIDragDetector", {
                    BoundingBehavior = Enum.UIDragDetectorBoundingBehavior.EntireObject,
                    BoundingUI = var19,
                    DragStyle = Enum.UIDragDetectorDragStyle.TranslatePlane,
                    ReferenceUIInstance = var19,
                    ResponseStyle = Enum.UIDragDetectorResponseStyle.Scale
                }),
                Buttons = React.createElement(
                    React.Fragment,
                    nil,
                    (createToolbarButtons(tbl1, onActivated, "in-game-build-shell-floating", var7))
                ),
                DragAffordance = React.createElement(
                    View,
                    {
                        LayoutOrder = 6,
                        tag = "position-center-center anchor-center-center auto-xy padding-xxsmall"
                    },
                    {
                        Icon = React.createElement(Image, {
                            Image = "component_assets/dragger_small",
                            tag = "position-center-center anchor-center-center size-600-400 content-muted"
                        })
                    }
                )
            })
        })
    else
        element = nil
    end

    tbl3.FloatingToolbarBounds = element

    tbl3.InsetReporter = React.createElement(View, { Size = var39, onAbsoluteSizeChanged = var5, testId = "in-game-build-shell-inset-reporter" })
    local element2

    if bool1 and not bool2 then
        element2 = React.createElement(
            View,
            {
                Position = var34,
                ZIndex = 1000,
                tag = "col align-x-center align-y-center gap-xsmall anchor-top-right size-0-full auto-x bg-surface-100",
                padding = {
                    left = UDim.new(0, var11.Padding.Small),
                    right = UDim.new(0, math.max(var13.right, var11.Padding.Small))
                },
                onAbsolutePositionChanged = var32,
                onAbsoluteSizeChanged = var32,
                testId = "in-game-build-shell-right-toolbar"
            },
            (createToolbarButtons(tbl1, onActivated, "in-game-build-shell-landscape", var7))
        )
    else
        element2 = nil
    end

    tbl3.RightInset = element2
    local element3

    if bool1 and not bool2 then
        element3 = React.createElement(View, {
            Position = var35,
            Size = UDim2.fromOffset(size1200, size1200),
            ZIndex = 1000,
            tag = "anchor-top-right clip",
            testId = "in-game-build-shell-top-right-inner-corner"
        }, {
            Image = React.createElement(Image, {
                Image = "rbxasset://textures/ui/AvatarExperience/CircleCutoutLargeNoBorder.png",
                Position = UDim2.fromOffset(-size1200, 0),
                Size = UDim2.fromOffset(size1200 * 2, size1200 * 2),
                ZIndex = 1000,
                imageStyle = imageStyle,
                testId = "in-game-build-shell-top-right-inner-corner-image"
            })
        })
    else
        element3 = nil
    end

    tbl3.TopRightInnerCorner = element3
    local element4

    if bool2 or bool1 or var27 == 0 then
        element4 = nil
    else
        element4 = React.createElement(View, {
            Position = var37,
            Size = UDim2.fromOffset(size1200, size1200),
            ZIndex = 1000,
            tag = "anchor-bottom-left clip",
            testId = "in-game-build-shell-bottom-left-inner-corner"
        }, {
            Image = React.createElement(Image, {
                Image = "rbxasset://textures/ui/AvatarExperience/CircleCutoutLargeNoBorder.png",
                Position = UDim2.fromOffset(0, -size1200),
                Size = UDim2.fromOffset(size1200 * 2, size1200 * 2),
                ZIndex = 1000,
                imageStyle = imageStyle,
                testId = "in-game-build-shell-bottom-left-inner-corner-image"
            })
        })
    end

    tbl3.BottomLeftInnerCorner = element4
    local element5

    if bool2 or not bool1 and var27 == 0 then
        element5 = nil
    else
        element5 = React.createElement(View, {
            Position = var38,
            Size = UDim2.fromOffset(size1200, size1200),
            ZIndex = 1000,
            tag = "anchor-bottom-right clip",
            testId = "in-game-build-shell-bottom-right-inner-corner"
        }, {
            Image = React.createElement(Image, {
                Image = "rbxasset://textures/ui/AvatarExperience/CircleCutoutLargeNoBorder.png",
                Position = UDim2.fromOffset(-size1200, -size1200),
                Size = UDim2.fromOffset(size1200 * 2, size1200 * 2),
                ZIndex = 1000,
                imageStyle = imageStyle,
                testId = "in-game-build-shell-bottom-right-inner-corner-image"
            })
        })
    end

    tbl3.BottomRightInnerCorner = element5

    tbl3.BottomBar = React.createElement(View, {
        Position = var36,
        Visible = not (bool1 or bool2),
        tag = "row align-x-center align-y-center gap-xsmall anchor-bottom-left size-full-0 auto-y bg-surface-100",
        onAbsoluteSizeChanged = onAbsoluteSizeChanged,
        padding = {
            top = UDim.new(0, var11.Padding.Small),
            left = UDim.new(0, var11.Padding.Large),
            right = UDim.new(0, var11.Padding.Large),
            bottom = UDim.new(0, var11.Margin.Small + var13.bottom)
        },
        testId = "in-game-build-shell-bottom-inset"
    }, (createToolbarButtons(tbl1, onActivated, "in-game-build-shell", var7)))
    local shell = createElement(var41, tbl2, tbl3)

    local yOffset = var13.top + var14.top
    local createElement2 = React.createElement
    local fragment = React.Fragment
    local var42 = nil
    local tbl4 = {
        Shell = shell,
        PublishOverlay = if target == nil or tbl1.isLibraryMode then nil else React.createElement(View, {
            Position = UDim2.fromOffset(0, yOffset),
            Size = UDim2.new(1, 0, 1, -yOffset),
            ZIndex = 2,
            ref = ref,
            testId = "in-game-build-shell-publish-overlay"
        }),
        PublishSheet = 0,
        PublishPage = 0
    }
    local var43

    if target == nil or not tbl1.isLibraryMode and var15 == nil then
        var43 = nil
    else
        local createElement3 = React.createElement
        local overlayProvider = Foundation.OverlayProvider
        local tbl5 = { gui = 0 }
        if tbl1.isLibraryMode then
            var15 = nil
        end

        tbl5.gui = var15
        var43 = createElement3(overlayProvider, tbl5, {
            Controller = React.createElement(PublishSheetController, {
                isOpen = isOpen,
                target = target,
                onClose = onClose,
                navigateToSubPage = navigateToSubPage,
                showPreviewButton = false
            })
        })
    end

    tbl4.PublishSheet = var43

    tbl4.PublishPage = if target == nil then nil else React.createElement(BuildPillMenuPageHost, { activePage = activePage, target = target, onClose = var1 })
    return createElement2(fragment, var42, tbl4)
end

return InGameBuildShell
