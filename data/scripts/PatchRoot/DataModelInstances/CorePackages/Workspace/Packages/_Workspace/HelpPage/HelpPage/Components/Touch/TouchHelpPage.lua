-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Foundation = require(scriptParentParentParentParent.Foundation)
local useKeybinds = require(scriptParentParentParent.Hooks.useKeybinds)
local TouchControlsEnum = require(scriptParentParentParent.Enums.TouchControlsEnum)
local TouchAction = require(scriptParentParentParent.Components.Touch.TouchAction)
local RobloxAppHooks = require(scriptParentParentParentParent.RobloxAppHooks)
local RobloxAppEnums = require(scriptParentParentParentParent.RobloxAppEnums)
local Display = require(scriptParentParentParentParent.Display)
local Constants = require(scriptParentParentParent.Constants)
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens
local useDeviceOrientation = RobloxAppHooks.useDeviceOrientation
local DeviceOrientationMode = RobloxAppEnums.DeviceOrientationMode

local bool1 = game:DefineFastFlag("TouchHelpPageResponsiveUnits", false)

local function getTapOrRotate(arg1, arg2, tbl1) -- Luacid: Inlined by compiler; 3 call sites recovered
    assert(not (tbl1[arg1] and tbl1[arg2]), "Cannot assign a position to both tap and rotate simultaneously.")

    return if tbl1[arg1] then arg1 elseif tbl1[arg2] then arg2 else nil
end

local var1 = React.memo(function(tbl1)
    local var1 = useTokens()
    local components = tbl1.components
    local bool2 = tbl1.orientation == DeviceOrientationMode.Portrait

    local function createSideColumn(str1: string, layoutOrder: number, topComponent, bottomComponent)
        return React.createElement(
            View,
            {
                tag = `align-x-{str1} auto-x col flex-y-between size-0-full`,
                LayoutOrder = layoutOrder
            },
            { topComponent = topComponent, bottomComponent = bottomComponent }
        )
    end

    local sideColumn = createSideColumn(if bool2 then "center" else "left", 1, components.topLeftComponent, components.bottomLeftComponent)

    local sideColumn2 = createSideColumn(if bool2 then "center" else "right", 3, components.topRightComponent, components.bottomRightComponent)

    if not bool2 then
        return React.createElement(View, {
            tag = "auto-y flex-x-between row size-full-0",
            LayoutOrder = 1,
            padding = UDim2.fromOffset(var1.Margin.Large, var1.Margin.Small)
        }, {
            leftColumn = sideColumn,
            middleColumn = React.createElement(
                View,
                { tag = "align-x-center auto-x col flex-y-fill size-0-full", LayoutOrder = 2 },
                {
                    topMidContainer = React.createElement(
                        View,
                        { tag = "align-y-center auto-x col size-0-full", LayoutOrder = 1 },
                        {
                            topMid = components.topMidComponent
                        }
                    ),
                    bottomMidContainer = React.createElement(
                        View,
                        { tag = "align-y-bottom auto-xy col", LayoutOrder = 2 },
                        {
                            bottomMid = components.bottomMidComponent
                        }
                    )
                }
            ),
            rightColumn = sideColumn2
        })
    end

    return React.createElement(View, { tag = "auto-y flex-x-between row size-full-0" }, {
        Inner = React.createElement(
            View,
            { tag = "col flex-y-fill padding-y-large padding-x-xxlarge size-full", LayoutOrder = 1 },
            {
                TopRow = React.createElement(View, { tag = "auto-y size-full-0", LayoutOrder = 1 }, {
                    Columns = React.createElement(
                        View,
                        { tag = "auto-y flex-x-between row size-full-0" },
                        { LeftColumn = sideColumn, RightColumn = sideColumn2 }
                    ),
                    Center = React.createElement(
                        View,
                        {
                            tag = "auto-xy",
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            Position = UDim2.fromScale(0.5, 0.5)
                        },
                        {
                            TopMid = components.topMidComponent
                        }
                    )
                }),
                BottomRow = React.createElement(View, {
                    tag = "auto-y size-full-0",
                    LayoutOrder = 2
                }, {
                    BottomMid = React.createElement(
                        View,
                        {
                            tag = "align-x-center align-y-bottom auto-y padding-top-xxlarge row size-full-0",
                            LayoutOrder = 4
                        },
                        {
                            bottomMid = components.bottomMidComponent
                        }
                    )
                })
            }
        )
    })
end)

return React.memo(function() -- name: TouchHelpPage
    local orientation = useDeviceOrientation()
    local controls = useKeybinds().controls
    local var3, var4 = React.useState(UserGameSettings.TouchMovementMode)
    local var5 = Display.GetDisplayStore(false).getViewportSize(false)

    React.useEffect(function()
        local connection = UserGameSettings:GetPropertyChangedSignal("TouchMovementMode"):Connect(function()
            var4(UserGameSettings.TouchMovementMode)
        end)

        return function()
            connection:Disconnect()
        end
    end, {})

    local bool2 = var3 == Enum.TouchMovementMode.ClickToMove

    local var6 = React.useMemo(function()
        local result = ({})

        if controls == nil then
            return result
        end

        for _, control in controls do
            if control.touchInput == nil then
                continue
            end

            local var6 = if bool2 then control.touchInput.tapToMoveInput else control.touchInput.thumbstickInput

            for _, value in ipairs(var6) do
                assert(result[value] == nil, "A touch input position cannot have multiple actions.")

                result[value] = control.label
            end
        end

        return result
    end, { controls, var3 })

    if controls == nil then
        return nil
    end

    local touchInput = getTapOrRotate(TouchControlsEnum.TopMidTap, TouchControlsEnum.TopMidRotate, var6)

    local tapOrRotate = getTapOrRotate(TouchControlsEnum.TopRightTap, TouchControlsEnum.TopRightRotate, var6)

    local tapOrRotate2 = getTapOrRotate(TouchControlsEnum.BottomLeftTap, TouchControlsEnum.BottomLeftRotate, var6)

    local components = {
        topLeftComponent = var6[TouchControlsEnum.TopLeft]
            and React.createElement(
                TouchAction,
                {
                    action = var6[TouchControlsEnum.TopLeft],
                    touchInput = TouchControlsEnum.TopLeft,
                    layoutOrder = 0
                }
            )
            or React.createElement(View),
        bottomLeftComponent = tapOrRotate2
            and React.createElement(
                TouchAction,
                {
                    action = tapOrRotate2 and var6[tapOrRotate2],
                    touchInput = tapOrRotate2,
                    layoutOrder = 1
                }
            )
            or React.createElement(View),
        topMidComponent = touchInput
            and React.createElement(TouchAction, { action = touchInput and var6[touchInput], touchInput = touchInput, layoutOrder = 1 })
            or React.createElement(View),
        bottomMidComponent = var6[TouchControlsEnum.BottomMid]
            and React.createElement(
                TouchAction,
                {
                    action = var6[TouchControlsEnum.BottomMid],
                    touchInput = TouchControlsEnum.BottomMid,
                    layoutOrder = 1
                }
            )
            or React.createElement(View),
        topRightComponent = tapOrRotate
            and React.createElement(
                TouchAction,
                {
                    action = tapOrRotate and var6[tapOrRotate],
                    touchInput = tapOrRotate,
                    layoutOrder = 1
                }
            )
            or React.createElement(View),
        bottomRightComponent = var6[TouchControlsEnum.BottomRight]
            and React.createElement(
                TouchAction,
                {
                    action = var6[TouchControlsEnum.BottomRight],
                    touchInput = TouchControlsEnum.BottomRight,
                    layoutOrder = 2
                }
            )
            or React.createElement(View)
    }
    local pageComponent = React.createElement(var1, { components = components, orientation = orientation })

    local bigScreenOffset = Constants.HELP_PAGE.TOUCH_OFFSETS.BIG_SCREEN_OFFSET

    if var5.X < Constants.HELP_PAGE.TOUCH_OFFSETS.SMALL_SCREEN_CUTOFF_X
        or var5.Y < Constants.HELP_PAGE.TOUCH_OFFSETS.SMALL_SCREEN_CUTOFF_Y
    then
        bigScreenOffset = Constants.HELP_PAGE.TOUCH_OFFSETS.SMALL_SCREEN_OFFSET
    end

    return React.createElement(View, {
        Size = if bool1 then UDim2.fromScale(1, 1) else UDim2.new(1, 0, 0, var5.Y - bigScreenOffset),
        ClipsDescendants = true
    }, { pageComponent = pageComponent })
end)
