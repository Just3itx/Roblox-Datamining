-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local RunService = game:GetService("RunService")

local React = require(scriptParentParentParentParent.React)
local ReactOtter = require(scriptParentParentParentParent.ReactOtter)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)

local Constants = require(scriptParentParentParent.Constants)

local useAnimatedBinding = ReactOtter.useAnimatedBinding
local useBindCaptureShortcut = require(scriptParentParentParent.Hooks.useBindCaptureShortcut)
local useEffect = React.useEffect
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useShowFlashOverlay = require(scriptParentParentParent.Hooks.useShowFlashOverlay)
local useTopbarInsetHeight = require(scriptParentParentParent.Hooks.useTopbarInsetHeight)

local instant = ReactOtter.instant
local spring = ReactOtter.spring

return function(_)
    useBindCaptureShortcut()

    local yOffset = useTopbarInsetHeight()

    local var1 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].IsOverlayActive
    end)

    local var2, var3 = useShowFlashOverlay()
    local var4, var5 = useAnimatedBinding(1)

    useEffect(function()
        if not var2 then
            return
        end

        var3()

        var5((instant(0)))

        task.defer(function()
            RunService.RenderStepped:Wait()
            RunService.RenderStepped:Wait()
            var5(spring(1))
        end)
    end, { var2 })

    return React.createElement("Frame", {
        Active = false,
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = if var2 then var4 else 1,
        Position = UDim2.fromOffset(0, -yOffset),
        Size = UDim2.new(1, 0, 1, yOffset),
        Visible = var1,
        ZIndex = Constants.ZIndex.Entrypoint
    }, {})
end
