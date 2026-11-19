-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:01:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local scriptParentParent = script.Parent.Parent
local SetDetailsInformation = require(scriptParentParent.Actions.SetDetailsInformation)
local SetTryingOnInfo = require(scriptParentParent.Actions.SetTryingOnInfo)

local InspectAndBuyContext = require(scriptParentParent.Components.InspectAndBuyContext)
local Modules = game:GetService("CoreGui").RobloxGui.Modules
local Theme = require(Modules.Settings.Theme)

local var1 = Roact.PureComponent:extend("CloseButton")

function var1.render(arg1)
    local view = arg1.props.view
    local viewingDetails = arg1.props.detailsInformation.viewingDetails
    local closeDetails = arg1.props.closeDetails
    local setTryingOnInfo = arg1.props.setTryingOnInfo

    return Roact.createElement(InspectAndBuyContext.Consumer, {
        render = function(arg2)
            local var2 = arg2[view]
            local uDim2 = UDim2.new(0, 0, 0, 0)
            local num1

            if Theme.UseInspectAndBuyPanel() then
                uDim2 = UDim2.new(0, var2.BorderPaddingSize, 0, 0)
                num1 = 18
            else
                num1 = 26
            end
            local createElement = Roact.createElement
            local tbl1 = {
                Size = UDim2.new(0, num1, 0, num1),
                Position = var2.CloseButtonPosition + uDim2,
                BackgroundTransparency = 1,
                Selectable = false,
                Image = if viewingDetails then "rbxasset://textures/ui/InspectMenu/caret_tail_left.png" else "rbxasset://textures/ui/InspectMenu/x.png",
                ZIndex = 2
            }

            tbl1[Roact.Event.Activated] = function()
                if viewingDetails then
                    closeDetails()
                    setTryingOnInfo(false, nil)
                    return
                end
                GuiService:CloseInspectMenu()
            end

            return createElement("ImageButton", tbl1)
        end
    })
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        view = arg1.view,
        detailsInformation = arg1.detailsInformation
    }
end, function(callback)
    return {
        closeDetails = function()
            callback(SetDetailsInformation(false, nil))
        end,
        setTryingOnInfo = function(arg1, arg2)
            callback(SetTryingOnInfo(arg1, arg2))
        end
    }
end)(var1)
