-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local React = require(scriptParentParent.React)
local Roact = require(scriptParentParent.Roact)
local UIBlox = require(scriptParentParent.UIBlox)
local SharedFlags = require(scriptParentParent.SharedFlags)
local Panel3D = UIBlox.Core.VR.Panel3D
local useIsFPSAtTarget = require(scriptParentParent.SplashScreenManager).useIsFPSAtTarget

local RoundedCornersFrame = require(script.Parent.RoundedCornersFrame)
local Object = require(scriptParentParent.LuauPolyfill).Object
local useIsSpatial = require(scriptParentParent.Responsive).useIsSpatial
local GetFFlagEnableVRWrapperTransparency = SharedFlags.GetFFlagEnableVRWrapperTransparency

local ROUNDED_CORNER_RADIUS = require(script.Parent.Constants).ROUNDED_CORNER_RADIUS

return function(tbl1)
    local var1 = useIsFPSAtTarget()
    local var2 = Object.assign({}, tbl1.vrProps, { hidden = tbl1.vrProps.hidden or not var1 })
    if not useIsSpatial() then
        return React.createElement(tbl1.component, tbl1.props, tbl1[Roact.Children])
    end

    local var3 = var2.roundedCornersFrameColor
        and {
            RoundedFrame = Roact.createElement(RoundedCornersFrame, {
                cornerRadius = ROUNDED_CORNER_RADIUS / (384 / (var2.virtualScreenSize.X / var2.partSize.X)),
                backgroundColor = var2.roundedCornersFrameColor,
                backgroundTransparency = GetFFlagEnableVRWrapperTransparency() and var2.backgroundTransparency or 0
            }, tbl1[Roact.Children])
        }
        or tbl1[Roact.Children]

    return React.createElement(Panel3D, var2, var3)
end
