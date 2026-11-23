-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Roact = require(scriptParentParent.Roact)
local Interactable = require(scriptParentParent.UIBlox).Core.Control.Interactable
local LinkingProtocol = require(scriptParentParent.LinkingProtocol).LinkingProtocol

local var1 = require(scriptParentParent.RobloxTranslator):FormatByKey("CoreScripts.Ads.Label.IllegalContentReportingLink")

function ReportAdFooter(tbl1)
    local default = LinkingProtocol.default
    local var2 = "https://www.roblox.com/illegal-content-reporting?contentURL=" .. "https://create.roblox.com/store/asset/" .. tbl1.assetId

    local createElement = Roact.createElement
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, 48),
        BackgroundTransparency = 1
    }
    local tbl3 = {
        UIListLayout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        UIPadding = Roact.createElement("UIPadding", { PaddingTop = UDim.new(0, 16) }),
        Border = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, 1),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 0.8,
            LayoutOrder = 1
        }),
        InteractableText = 0
    }

    local createElement2 = Roact.createElement
    local var3 = Interactable
    local tbl4 = {
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        LayoutOrder = 2
    }

    tbl4[Roact.Event.Activated] = function()
        default:openURL(var2)
    end

    tbl3.InteractableText = createElement2(var3, tbl4, {
        UIListLayout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        FooterText = Roact.createElement(
            "TextLabel",
            {
                Text = var1,
                TextColor3 = Color3.fromRGB(82, 173, 244),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                TextSize = 16,
                TextScaled = false,
                TextWrapped = false,
                AutomaticSize = Enum.AutomaticSize.XY,
                AnchorPoint = Vector2.new(0.5, 0.5)
            },
            {
                UIPadding = Roact.createElement("UIPadding", { PaddingTop = UDim.new(0, 16) })
            }
        )
    })
    return createElement("Frame", tbl2, tbl3)
end

return ReportAdFooter
