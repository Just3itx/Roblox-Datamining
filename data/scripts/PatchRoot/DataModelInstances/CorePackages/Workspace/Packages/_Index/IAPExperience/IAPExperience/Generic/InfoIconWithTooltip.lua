-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")

local scriptParentParentParent = script.Parent.Parent.Parent
local UIBlox = require(scriptParentParentParent.UIBlox)
local Roact = require(scriptParentParentParent.Roact)

local withHoverTooltip = UIBlox.App.Dialog.TooltipV2.withHoverTooltip
local TooltipOrientation = UIBlox.App.Dialog.Enum.TooltipOrientation
local Images = UIBlox.App.ImageSet.Images
local Interactable = UIBlox.Core.Control.Interactable
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local iconsActionsInfo = Images["icons/actions/info"]

function InfoIconWithTooltip(tbl1)
    local uDim2 = UDim2.new(0, 18, 0, 18)
    return withHoverTooltip({
        bodyText = tbl1.text
    }, {
        preferredOrientation = TooltipOrientation.Bottom,
        guiTarget = CoreGui,
        DisplayOrder = 10,
        delayTime = 0.2,
        triggerPointName = "BonusBannerInfoIcon"
    }, function(arg1, onStateChanged)
        local createElement = Roact.createElement
        local tbl2 = {
            Size = uDim2,
            BackgroundTransparency = 1,
            LayoutOrder = tbl1.layoutOrder,
            AnchorPoint = Vector2.new(1, 0),
            [Roact.Change.AbsolutePosition] = arg1,
            [Roact.Change.AbsoluteSize] = arg1
        }
        local tbl3 = {
            TooltipIcon = Roact.createElement(
                ImageSetLabel,
                {
                    Size = uDim2,
                    BackgroundTransparency = 1,
                    Image = iconsActionsInfo,
                    ImageColor3 = tbl1.color,
                    ZIndex = 1
                }
            ),
            Hitbox = Roact.createElement(Interactable, {
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = 1,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                onStateChanged = onStateChanged,
                [Roact.Event.Activated] = tbl1.eventActivated,
                ZIndex = 2
            })
        }
        return createElement("Frame", tbl2, tbl3)
    end)
end

return InfoIconWithTooltip
