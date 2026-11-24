-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:11:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local UserInputService = game:GetService("UserInputService")

local React = require(scriptParentParentParentParent.React)
local Foundation = require(scriptParentParentParentParent.Foundation)
local Display = require(scriptParentParentParentParent.Display)
local _ConfigTypes = require(scriptParentParentParent.Configs.ConfigTypes)
local _ActionText = require(scriptParentParentParent.Components.Common.ActionText)
local GamepadList = require(scriptParentParentParent.Components.Gamepad.GamepadList)
local DiagramLayoutView = require(scriptParentParentParent.Components.Common.DiagramLayoutView)
local Constants = require(scriptParentParentParent.Constants)
local useKeybinds = require(scriptParentParentParent.Hooks.useKeybinds)
local SignalsReact = require(scriptParentParentParentParent.SignalsReact)
local RobloxAppHooks = require(scriptParentParentParentParent.RobloxAppHooks)
local RobloxAppEnums = require(scriptParentParentParentParent.RobloxAppEnums)
local useDeviceOrientation = RobloxAppHooks.useDeviceOrientation
local DeviceOrientationMode = RobloxAppEnums.DeviceOrientationMode

local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local FFlagHelpPageCCL = require(scriptParentParentParent.Flags.FFlagHelpPageCCL)

local function getGamepadInput(tbl1, isSpatial: boolean, platform) -- Luacid: Inlined by compiler; 1 call site recovered
    local gamepadInput = tbl1.gamepadInput
    if gamepadInput == nil then
        return nil
    end

    local var1 = if FFlagHelpPageCCL and isSpatial and gamepadInput.spatialGamepadInput ~= nil then gamepadInput.spatialGamepadInput else gamepadInput.input

    if var1 == nil then
        if isSpatial then
            return gamepadInput.spatialGamepadInput
        end

        if Constants.HELP_PAGE.GAMEPAD_PLAYSTATION_PLATFORMS[platform] then
            return gamepadInput.playstationInput
        end
        var1 = gamepadInput.xboxInput
    end

    return var1
end

local function getAbilitySlot(str1: string): number? -- Luacid: Inlined by compiler; 1 call site recovered
    return tonumber(string.match(str1, "^AbilityAction(%d+)$"))
end

local function getResolvedControls(controls, isSpatial: boolean, platform)
    local resolvedControls = ({})
    local tbl1 = ({})

    local function addControl(arg1)
        local gamepadInput = getGamepadInput(arg1, isSpatial, platform)
        if gamepadInput == nil then
            return
        end

        for _, value in ipairs(gamepadInput) do
            if isSpatial and Constants.HELP_PAGE.GAMEPAD_ICON_MAP_SPATIAL[value] == nil then
                continue
            end

            local input = { value }
            local str1 = tostring(value)
            local resolvedControl = resolvedControls[str1]

            if resolvedControl == nil then
                local tbl3 = {
                    label = arg1.label,
                    gamepadInput = { input = input },
                    actionLabels = {{
                        label = arg1.label,
                        disabled = arg1.disabled
                    }}
                }

                resolvedControls[str1] = tbl3
            else
                table.insert(resolvedControl.actionLabels, { label = arg1.label, disabled = arg1.disabled })
            end
        end
    end

    for k, control in controls do
        local abilitySlot = getAbilitySlot(k)

        if abilitySlot == nil then
            addControl(control)
        else
            tbl1[abilitySlot] = control
        end
    end

    local tbl2 = {}
    for value in tbl1 do
        table.insert(tbl2, value)
    end
    table.sort(tbl2)

    for _, value in ipairs(tbl2) do
        addControl(tbl1[value])
    end

    return resolvedControls
end

return React.memo(function(tbl1) -- name: GamepadHelpPage
    local platform = if tbl1.getPlatform then tbl1.getPlatform() else UserInputService:GetPlatform()
    local var1 = useDeviceOrientation()
    local controls = useKeybinds().controls
    local var2 = useTokens()
    local var3, var4 = React.useState(math.huge)
    local var5, var6 = React.useState(nil)
    local var7, var8 = React.useState(nil)
    local var9 = SignalsReact.useSignalState(Display.GetDisplayStore)
    local var10 = SignalsReact.useSignalState(var9.getViewportSize)
    local bool1 = not tbl1.isSpatial

    if bool1 then
        if var10.X < Constants.HELP_PAGE.TOUCH_OFFSETS.SMALL_SCREEN_CUTOFF_X
            or var10.Y < Constants.HELP_PAGE.TOUCH_OFFSETS.SMALL_SCREEN_CUTOFF_Y
        then
            bool1 = var1 == DeviceOrientationMode.Portrait
        else
            bool1 = false
        end
    end
    local var11, var12, var13 = React.useMemo(function()
        local tbl2 = ({})
        local tbl3 = ({})
        local tbl4 = ({})

        if FFlagHelpPageCCL then
            for k, value in pairs((getResolvedControls(controls, tbl1.isSpatial, platform))) do
                local input = value.gamepadInput.input

                if input == nil or not (#input > 0) then
                    continue
                end

                if Constants.HELP_PAGE.GAMEPAD_LAYOUT_ORDER[input[1]] <= Constants.HELP_PAGE.GAMEPAD_CUTOFFS.LEFT_COL then
                    tbl2[k] = value
                else
                    tbl4[k] = value
                end
            end

            return tbl2, tbl3, tbl4
        end

        for k, control in controls do
            if control.gamepadInput == nil then
                continue
            end

            local gamepadInput = control.gamepadInput
            local input = gamepadInput.input

            if input == nil then
                if tbl1.isSpatial then
                    input = gamepadInput.spatialGamepadInput
                elseif Constants.HELP_PAGE.GAMEPAD_PLAYSTATION_PLATFORMS[platform] then
                    input = gamepadInput.playstationInput
                else
                    input = gamepadInput.xboxInput
                end
            end

            if input == nil or not (#input > 0) then
                continue
            end
            local var11 = Constants.HELP_PAGE.GAMEPAD_LAYOUT_ORDER[input[1]]

            if var11 <= Constants.HELP_PAGE.GAMEPAD_CUTOFFS.LEFT_COL then
                tbl2[k] = control
            elseif var11 <= Constants.HELP_PAGE.GAMEPAD_CUTOFFS.BOTTOM_RIGHT_COL
                and Constants.HELP_PAGE.GAMEPAD_PLAYSTATION_PLATFORMS[platform]
            then
                tbl3[k] = control
            else
                tbl4[k] = control
            end
        end

        return tbl2, tbl3, tbl4
    end, FFlagHelpPageCCL and { controls, platform, tbl1.isSpatial } or { controls })

    local element = React.createElement("ImageLabel", {
        Name = "GamepadImage",
        Size = UDim2.fromScale(1, 1),
        ScaleType = Enum.ScaleType.Fit,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Image = if tbl1.isSpatial then "rbxasset://textures/ui/Gamepad/VRController.png" else "rbxasset://textures/ui/Gamepad/Controller@3x.png",
        BackgroundTransparency = 1
    })

    local var14 = React.useMemo(function(): UDim
        if not tbl1.isSpatial
            and (var10.X < Constants.HELP_PAGE.TOUCH_OFFSETS.SMALL_SCREEN_CUTOFF_X
                or var10.Y < Constants.HELP_PAGE.GAMEPAD_SIZES.NO_PADDING_CUTOFF_Y)
        then
            return UDim.new(0, 0)
        end
        return UDim.new(0, var2.Size.Size_2400)
    end, FFlagHelpPageCCL and { var10, tbl1.isSpatial, var2.Size.Size_2400 } or { var10 })

    local var15, leftPosition, var17, rightPosition, var19, var20 = React.useMemo(function()
        if tbl1.isSpatial and not FFlagHelpPageCCL then
            return Vector2.new(1, 0.5), UDim2.new(
                Constants.HELP_PAGE.GAMEPAD_SIZES.LEFT_COL_SCALE,
                0,
                0,
                var3 * Constants.HELP_PAGE.GAMEPAD_SIZES.IMAGE_MULTIPLIER_VR * 0.5 / Constants.HELP_PAGE.GAMEPAD_SIZES.IMAGE_ASPECT_RATIO
            ), Vector2.new(0, 0.5), UDim2.new(
                Constants.HELP_PAGE.GAMEPAD_SIZES.RIGHT_COL_SCALE_VR,
                0,
                0,
                var3 * Constants.HELP_PAGE.GAMEPAD_SIZES.IMAGE_MULTIPLIER_VR * 0.5 / Constants.HELP_PAGE.GAMEPAD_SIZES.IMAGE_ASPECT_RATIO
            ), Constants.HELP_PAGE.GAMEPAD_SIZES.COL_SCALE_VR, Constants.HELP_PAGE.GAMEPAD_SIZES.IMAGE_MULTIPLIER_VR
        end

        if bool1 then
            return Vector2.new(0, 0), UDim2.fromOffset(
                0,
                var3 * Constants.HELP_PAGE.GAMEPAD_SIZES.IMAGE_MULTIPLIER_PORTRAIT / Constants.HELP_PAGE.GAMEPAD_SIZES.IMAGE_ASPECT_RATIO
            ), Vector2.new(1, 0), UDim2.new(
                1,
                0,
                0,
                var3 * Constants.HELP_PAGE.GAMEPAD_SIZES.IMAGE_MULTIPLIER_PORTRAIT / Constants.HELP_PAGE.GAMEPAD_SIZES.IMAGE_ASPECT_RATIO
            ), Constants.HELP_PAGE.GAMEPAD_SIZES.COL_SCALE_PORTRAIT, Constants.HELP_PAGE.GAMEPAD_SIZES.IMAGE_MULTIPLIER_PORTRAIT
        end
        local var15 = var3 * Constants.HELP_PAGE.GAMEPAD_SIZES.LEFT_COL_SCALE
        local var16 = var3 * (1 - Constants.HELP_PAGE.GAMEPAD_SIZES.RIGHT_COL_SCALE)
        local var17 = if var5 == nil or var7 == nil or not (var5.X > 0 and var7.X > 0 and (var15 < var5.X or var16 < var7.X)) then 1 else math.min(var15 / var5.X, var16 / var7.X)
        return Vector2.new(1, 0), UDim2.fromScale(Constants.HELP_PAGE.GAMEPAD_SIZES.LEFT_COL_SCALE, 0), Vector2.new(0, 0), UDim2.fromScale(Constants.HELP_PAGE.GAMEPAD_SIZES.RIGHT_COL_SCALE, 0), var17, Constants.HELP_PAGE.GAMEPAD_SIZES.IMAGE_MULTIPLIER_DEFAULT
    end, FFlagHelpPageCCL and {
        var3,
        tbl1.isSpatial,
        bool1,
        var5,
        var7
    } or { var10, var3, tbl1.isSpatial })

    local columnWidth = if FFlagHelpPageCCL and bool1 then Constants.HELP_PAGE.GAMEPAD_SIZES.COL_SIZE_PORTRAIT elseif FFlagHelpPageCCL then Constants.HELP_PAGE.GAMEPAD_SIZES.COL_SIZE else nil

    if FFlagHelpPageCCL then
        return React.createElement(DiagramLayoutView, {
            layout = {
                leftAnchor = var15,
                leftPosition = leftPosition,
                rightAnchor = var17,
                rightPosition = rightPosition,
                columnWidth = columnWidth,
                columnTopPadding = UDim.new(0, var2.Padding.Large),
                columnScale = var19,
                diagramSize = Vector2.new(var3 * var20, var3 * var20 / Constants.HELP_PAGE.GAMEPAD_SIZES.IMAGE_ASPECT_RATIO),
                diagramOffsetY = nil,
                topPadding = var14,
                bottomPadding = nil
            },
            left = React.createElement(
                GamepadList,
                {
                    controls = var11,
                    layoutOrderReversed = false,
                    addBlankIcon = false,
                    isSpatial = tbl1.isSpatial,
                    platform = platform
                }
            ),
            right = React.createElement(
                GamepadList,
                {
                    controls = var13,
                    layoutOrderReversed = true,
                    addBlankIcon = false,
                    isSpatial = tbl1.isSpatial,
                    platform = platform
                }
            ),
            diagram = element,
            testId = "Gamepad",
            diagramTestId = "VRGamepadInstructions",
            onSizeChanged = function(arg1)
                var4(arg1.AbsoluteSize.X)
            end,
            onLeftSizeChanged = function(arg1)
                if var5 == nil then
                    var6(arg1.AbsoluteSize)
                end
            end,
            onRightSizeChanged = function(arg1)
                if var7 == nil then
                    var8(arg1.AbsoluteSize)
                end
            end
        })
    end

    return React.createElement(View, {
        tag = "size-full-0 auto-y",
        padding = { top = var14 },
        onAbsoluteSizeChanged = function(arg1)
            var4(arg1.AbsoluteSize.X)
        end
    }, {
        LeftColContainer = React.createElement(View, {
            tag = "auto-xy padding-top-large",
            AnchorPoint = var15,
            Position = leftPosition,
            scale = var19,
            onAbsoluteSizeChanged = function(arg1)
                if var5 == nil then
                    var6(arg1.AbsoluteSize)
                end
            end
        }, {
            LeftCol = React.createElement(
                GamepadList,
                {
                    controls = var11,
                    layoutOrderReversed = false,
                    addBlankIcon = false,
                    isSpatial = tbl1.isSpatial,
                    platform = platform
                }
            )
        }),
        ImageComponentContainer = React.createElement(View, {
            Position = UDim2.fromScale(0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0),
            Size = UDim2.fromOffset(var3 * var20, var3 * var20 / Constants.HELP_PAGE.GAMEPAD_SIZES.IMAGE_ASPECT_RATIO),
            testId = "VRGamepadInstructions"
        }, { ImageComponent = element }),
        RightColContainer = React.createElement(View, {
            tag = "auto-xy padding-top-large",
            AnchorPoint = var17,
            Position = rightPosition,
            scale = var19,
            onAbsoluteSizeChanged = function(arg1)
                if var7 == nil then
                    var8(arg1.AbsoluteSize)
                end
            end
        }, {
            RightCol = React.createElement(View, { tag = "col auto-xy" }, {
                TopRightColContainer = React.createElement(View, {
                    tag = "auto-xy",
                    LayoutOrder = 1
                }, {
                    TopRightCol = React.createElement(
                        GamepadList,
                        {
                            controls = var13,
                            layoutOrderReversed = true,
                            addBlankIcon = false,
                            isSpatial = tbl1.isSpatial,
                            platform = platform
                        }
                    )
                }),
                BottomRightColContainer = React.createElement(View, {
                    tag = "auto-xy",
                    LayoutOrder = 2
                }, {
                    BottomRightCol = React.createElement(
                        GamepadList,
                        {
                            controls = var12,
                            layoutOrderReversed = true,
                            addBlankIcon = true,
                            isSpatial = tbl1.isSpatial,
                            platform = platform
                        }
                    )
                })
            })
        })
    })
end)
