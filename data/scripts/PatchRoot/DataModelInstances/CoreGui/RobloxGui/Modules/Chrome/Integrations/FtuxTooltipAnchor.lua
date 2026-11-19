-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")

local React = require(CorePackages.Packages.React)
local UIBlox = require(CorePackages.Packages.UIBlox)
local withTooltip = UIBlox.App.Dialog.TooltipV2.withTooltip
local TooltipOrientation = UIBlox.App.Dialog.Enum.TooltipOrientation

return (React.forwardRef(function(arg1, ref)
    return withTooltip({
        ref = ref,
        headerText = arg1.headerText,
        bodyText = arg1.bodyText
    }, {
        DisplayOrder = 10,
        active = arg1.shouldShowTooltip,
        guiTarget = CoreGui,
        preferredOrientation = TooltipOrientation.Bottom
    }, function(arg2)
        return React.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            [React.Change.AbsoluteSize] = arg2,
            [React.Change.AbsolutePosition] = arg2
        })
    end)
end))
