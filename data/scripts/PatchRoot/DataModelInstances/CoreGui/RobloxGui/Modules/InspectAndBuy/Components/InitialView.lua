-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local scriptParentParent = script.Parent.Parent
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local PlayerNameLabel = require(scriptParentParent.Components.PlayerNameLabel)
local AvatarHeadShot = require(scriptParentParent.Components.AvatarHeadShot)
local AssetList = require(scriptParentParent.Components.AssetList)

local InspectAndBuyContext = require(scriptParentParent.Components.InspectAndBuyContext)

local var1 = Roact.PureComponent:extend("InitialView")

function var1.render(arg1)
    local view = arg1.props.view
    local detailsInformation = arg1.props.detailsInformation

    return Roact.createElement(InspectAndBuyContext.Consumer, {
        render = function(arg2)
            local var2 = arg2[view]
            return Roact.createElement("ScrollingFrame", {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, var2.BorderPaddingSize, 0, 10),
                Size = UDim2.new(1, -(2 * var2.BorderPaddingSize), 1, -36),
                ScrollBarThickness = 0,
                ScrollingDirection = Enum.ScrollingDirection.Y,
                Visible = not detailsInformation.viewingDetails,
                Selectable = false
            }, {
                UIListLayout = Roact.createElement("UIListLayout", {
                    Padding = UDim.new(0, 15),
                    HorizontalAlignment = Enum.HorizontalAlignment.Left,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }),
                Top = Roact.createElement(
                    "Frame",
                    {
                        Size = UDim2.new(1, 0, 0, var2.TopSizeY),
                        BackgroundTransparency = 1,
                        LayoutOrder = 2
                    },
                    {
                        UIListLayout = Roact.createElement(
                            "UIListLayout",
                            {
                                Padding = UDim.new(0, 10),
                                SortOrder = Enum.SortOrder.LayoutOrder,
                                FillDirection = Enum.FillDirection.Horizontal
                            }
                        ),
                        AvatarHeadShot = Roact.createElement(AvatarHeadShot),
                        PlayerNameLabel = Roact.createElement(PlayerNameLabel)
                    }
                ),
                AssetList = Roact.createElement(AssetList)
            })
        end
    })
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        view = arg1.view,
        detailsInformation = arg1.detailsInformation
    }
end)(var1)
