-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local RunService = game:GetService("RunService")
local VRService = game:GetService("VRService")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t

local InGameMenu = script:FindFirstAncestor("InGameMenu")
local Constants = require(InGameMenu.Resources.Constants)

local var1 = Roact.PureComponent:extend("BlurredModalPortal")

var1.validateProps = t.strictInterface({ Enabled = t.boolean, [Roact.Children] = t.optional(t.table) })

function var1.render(arg1)
    return Roact.createElement(Roact.Portal, { target = CoreGui }, {
        InGameMenuModalBlur = Roact.createElement("ScreenGui", {
            OnTopOfCoreBlur = true,
            Enabled = arg1.props.Enabled,
            IgnoreGuiInset = true,
            DisplayOrder = Constants.DisplayOrder.BlurredModalPortal
        }, arg1.props[Roact.Children])
    })
end

function var1.didUpdate(arg1, arg2)
    if VRService.VREnabled then
        return
    end

    local enabled = arg2.Enabled
    local propsEnabled = arg1.props.Enabled

    if enabled ~= propsEnabled then
        RunService:SetRobloxGuiFocused(propsEnabled)
    end
end

return var1
