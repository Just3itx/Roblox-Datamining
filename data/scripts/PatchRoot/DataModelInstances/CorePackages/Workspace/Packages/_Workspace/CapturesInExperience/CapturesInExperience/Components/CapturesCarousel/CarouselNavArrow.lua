-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local React = require(scriptParentParentParentParent.React)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)
local SocialCommon = require(scriptParentParentParentParent.SocialCommon)
local UIBlox = require(scriptParentParentParentParent.UIBlox)
local ReactUtils = require(scriptParentParentParentParent.ReactUtils)

local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local InputUtilities = SocialCommon.Utils.InputUtilities

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useEventConnection = ReactUtils.useEventConnection
local useStyle = UIBlox.Core.Style.useStyle

local CarouselNavigated = require(scriptParentParentParent.Thunks.CarouselNavigated)
local Constants = require(scriptParentParentParent.Constants)
local EventNames = require(scriptParentParentParent.Analytics.EventNames)
local useAnalytics = require(scriptParentParentParent.Analytics.useAnalytics)

local iconsActionsCycleLeft = Images["icons/actions/cycleLeft"]
local iconsActionsCycleRight = Images["icons/actions/cycleRight"]

return function(tbl1)
    local var1 = useAnalytics()
    local var2 = useDispatch()
    local var3 = useStyle()

    local var4 = React.useRef(nil)

    local bool1 = tbl1.direction == Constants.CarouselDirection.Left
    local vector2 = if bool1 then Vector2.new(0, 0.5) else Vector2.new(1, 0.5)
    local image = if bool1 then iconsActionsCycleLeft else iconsActionsCycleRight
    local uDim2 = if bool1 then UDim2.fromScale(0, 0.5) else UDim2.fromScale(1, 0.5)

    React.useEffect(function()
        return function()
            if var4.current then
                var4.current:Disconnect()
                var4.current = nil
            end
        end
    end, {})

    React.useEffect(function()
        if tbl1.isDisabled and var4.current then
            var4.current:Disconnect()
            var4.current = nil
        end
    end, { tbl1.isDisabled })

    local var6 = React.useCallback(function(_, arg1)
        if tbl1.isDisabled or arg1.UserInputState ~= Enum.UserInputState.Begin or not InputUtilities.isActivationInput(arg1) then
            return
        end

        if var4.current then
            var4.current:Disconnect()
            var4.current = nil
        end

        var1.fireEvent(EventNames.CapturesCarouselNavigated, { direction = tbl1.direction })

        var2(CarouselNavigated(tbl1.direction))

        local var6 = tick()
        local var7 = var6

        var4.current = RunService.RenderStepped:Connect(function(_: number)
            if not (math.max(0.5 / (tick() - var7), 0.15) < tick() - var6) then
                return
            end

            var1.fireEvent(EventNames.CapturesCarouselNavigated, { direction = tbl1.direction })

            var2(CarouselNavigated(tbl1.direction))
            var6 = tick()
        end)
    end, { tbl1.isDisabled })

    local var7 = React.useCallback(function(_, arg1)
        if InputUtilities.isActivationInput(arg1) and var4.current then
            var4.current:Disconnect()
            var4.current = nil
        end
    end, {})

    useEventConnection(UserInputService.InputEnded, function(arg1)
        if InputUtilities.isActivationInput(arg1) and var4.current then
            var4.current:Disconnect()
            var4.current = nil
        end
    end)

    return React.createElement("TextButton", {
        AnchorPoint = vector2,
        BackgroundTransparency = 1,
        Position = uDim2,
        Size = tbl1.Size,
        Text = "",
        ZIndex = tbl1.ZIndex,
        Visible = not tbl1.isDisabled,
        [React.Event.InputBegan] = var6,
        [React.Event.InputEnded] = var7
    }, {
        Arrow = React.createElement(ImageSetLabel, {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Image = image,
            ImageColor3 = var3.Theme.IconEmphasis.Color,
            ImageTransparency = var3.Theme.IconEmphasis.Transparency,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(36, 36)
        })
    })
end
