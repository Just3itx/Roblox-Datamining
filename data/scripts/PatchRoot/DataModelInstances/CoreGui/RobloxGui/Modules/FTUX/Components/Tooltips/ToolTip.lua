-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:11:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local UIBlox = require(CorePackages.Packages.UIBlox)
local TooltipOrientation = UIBlox.App.Dialog.Enum.TooltipOrientation
local withTooltip = UIBlox.App.Dialog.TooltipV2.withTooltip
local React = require(CorePackages.Packages.React)

local function Tooltip(tbl1)
    local controllerPart = tbl1.controllerPart
    local billboardGui = controllerPart:WaitForChild("BillboardGui")

    return withTooltip({
        bodyText = tbl1.tooltipText
    }, {
        preferredOrientation = TooltipOrientation.Bottom,
        guiTarget = billboardGui,
        DisplayOrder = 0,
        triggerPointName = "TriggerPart",
        active = true,
        DEBUG_useTargetDirectly = true
    }, function(arg1)
        local createElement = React.createElement
        local tbl2 = {
            Parent = controllerPart,
            Adornee = controllerPart,
            AlwaysOnTop = true,
            Active = false,
            Size = UDim2.new(0.5, 0, 0.5, 0)
        }
        local tbl3 = {
            TriggerBody = React.createElement("Frame", {
                Transparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Position = UDim2.new(0.49, 0, 1.02, 0),
                [React.Change.AbsoluteSize] = arg1,
                [React.Change.AbsolutePosition] = arg1
            })
        }
        return createElement("BillboardGui", tbl2, tbl3)
    end)
end

return Tooltip
