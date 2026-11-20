-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:21:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local _RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local LoadingBar = require(CorePackages.Workspace.Packages.AppBlox).LoadingBar

local Roact = require(CorePackages.Packages.Roact)

local var1 = Roact.PureComponent:extend("LoadingFriendsPage")

function var1.render(arg1)
    local layoutOrder = arg1.props.LayoutOrder
    local zIndex = arg1.props.ZIndex

    local num1 = 0
    local function incrementLayoutOrder(): number -- Luacid: Inlined by compiler; 1 call site recovered
        num1 += 1
        return num1
    end

    return Roact.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            LayoutOrder = layoutOrder,
            ZIndex = zIndex
        },
        {
            listLayout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            loadingIndicator = Roact.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, 70, 0, 16),
                    LayoutOrder = incrementLayoutOrder(),
                    ZIndex = zIndex
                },
                {
                    loadingBar = Roact.createElement(LoadingBar, { ZIndex = zIndex })
                }
            )
        }
    )
end
return var1
