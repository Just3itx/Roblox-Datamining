-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Roact = require(scriptParentParent.Roact)
local UIBlox = require(scriptParentParent.UIBlox)
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Interactable = UIBlox.Core.Control.Interactable

local RobloxTranslator = require(scriptParentParent.RobloxTranslator)
local var1 = RobloxTranslator:FormatByKey("CoreScripts.Ads.Label.WhyThisAd")
local var2 = RobloxTranslator:FormatByKey("CoreScripts.Ads.Label.ReportAd")

local iconsActionsInfo = Images["icons/actions/info"]
local iconsActionsFeedback = Images["icons/actions/feedback"]

local var3 = require(script.Parent.Flags).GetAdGuiInteractivityPixelsPerStud() / 50

local function applyScalingUDim(uDim: UDim): UDim -- Luacid: Inlined by compiler; 13 call sites recovered
    return UDim.new(uDim.Scale, uDim.Offset * var3)
end

local function applyScalingUDim2(uDim2: UDim2): UDim2 -- Luacid: Inlined by compiler; 3 call sites recovered
    return UDim2.new(uDim2.X.Scale, uDim2.X.Offset * var3, uDim2.Y.Scale, uDim2.Y.Offset * var3)
end

local function applyScalingNumber(num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    return num1 * var3
end

local function WhyThisAdRow(tbl1)
    local createElement = Roact.createElement
    local var4 = Interactable
    local tbl2 = {
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        [Roact.Event.Activated] = tbl1.onWhyThisAdActivated
    }

    function tbl2.onStateChanged() end

    return createElement(var4, tbl2, {
        UICorner = Roact.createElement("UICorner", { CornerRadius = applyScalingUDim(UDim.new(0, 10)) }),
        UIPadding = Roact.createElement("UIPadding", {
            PaddingTop = applyScalingUDim(UDim.new(0, 16)),
            PaddingBottom = applyScalingUDim(UDim.new(0, 8)),
            PaddingLeft = applyScalingUDim(UDim.new(0, 16)),
            PaddingRight = applyScalingUDim(UDim.new(0, 48))
        }),
        UIListLayout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = applyScalingUDim(UDim.new(0, 16))
        }),
        Icon = Roact.createElement(
            ImageSetLabel,
            {
                Image = iconsActionsInfo,
                Size = applyScalingUDim2(UDim2.fromOffset(24, 24)),
                BackgroundTransparency = 1
            }
        ),
        TextLabel = Roact.createElement("TextLabel", {
            Text = var1,
            TextColor3 = Color3.new(1, 1, 1),
            BackgroundTransparency = 1,
            Font = Enum.Font.GothamMedium,
            TextSize = applyScalingNumber(24),
            TextScaled = false,
            TextWrapped = true,
            AutomaticSize = Enum.AutomaticSize.XY
        })
    })
end

local function ReportAdRow(tbl1)
    local createElement = Roact.createElement
    local var4 = Interactable
    local tbl2 = {
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        [Roact.Event.Activated] = tbl1.onReportAdActivated
    }

    function tbl2.onStateChanged() end

    return createElement(var4, tbl2, {
        UICorner = Roact.createElement("UICorner", { CornerRadius = applyScalingUDim(UDim.new(0, 10)) }),
        UIPadding = Roact.createElement("UIPadding", {
            PaddingTop = applyScalingUDim(UDim.new(0, 8)),
            PaddingBottom = applyScalingUDim(UDim.new(0, 16)),
            PaddingLeft = applyScalingUDim(UDim.new(0, 16)),
            PaddingRight = applyScalingUDim(UDim.new(0, 48))
        }),
        UIListLayout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = applyScalingUDim(UDim.new(0, 16))
        }),
        Icon = Roact.createElement(
            ImageSetLabel,
            {
                Image = iconsActionsFeedback,
                Size = applyScalingUDim2(UDim2.fromOffset(24, 24)),
                BackgroundTransparency = 1
            }
        ),
        TextLabel = Roact.createElement("TextLabel", {
            Text = var2,
            TextColor3 = Color3.new(1, 1, 1),
            BackgroundTransparency = 1,
            Font = Enum.Font.GothamMedium,
            TextSize = applyScalingNumber(24),
            TextScaled = false,
            TextWrapped = true,
            AutomaticSize = Enum.AutomaticSize.XY
        })
    })
end

function AdDropdownMenu(tbl1)
    return Roact.createElement("Frame", {
        Visible = tbl1.showDropDownMenu,
        Position = tbl1.Position or UDim2.new(0.5, 0, 0.5, 0),
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = tbl1.transparency,
        AnchorPoint = tbl1.AnchorPoint or Vector2.new(0.5, 0.5),
        Size = applyScalingUDim2(UDim2.new(0.24, 0, 0.12, 0)),
        AutomaticSize = Enum.AutomaticSize.XY
    }, {
        UICorner = Roact.createElement("UICorner", { CornerRadius = applyScalingUDim(UDim.new(0, 10)) }),
        UIListLayout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        WhyThisAdRow(tbl1),
        ReportAdRow(tbl1)
    })
end

return AdDropdownMenu
