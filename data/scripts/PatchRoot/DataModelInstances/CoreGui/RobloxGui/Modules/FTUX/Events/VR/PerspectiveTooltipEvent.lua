-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local _EventType = require(script.Parent.Parent.EventType)
local Roact = require(CorePackages.Packages.Roact)
local VRFTUXToolTips = require(script.Parent.Parent.Parent.Components.Tooltips.VRFTUXToolTips)

local renderWithCoreScriptsStyleProvider = require(script.Parent.Parent.Parent.Parent.Common.renderWithCoreScriptsStyleProvider)

local module = { Name = "PerspectiveTooltipEvent" }

local var1 = nil

function module.StartEvent()
    local element = Roact.createElement(VRFTUXToolTips, {
        tooltipButtons = {{
            Text = "Press",
            Controller = Enum.UserCFrame.RightHand,
            ButtonKeycode = Enum.KeyCode.ButtonR3
        }}
    })

    local var2 = renderWithCoreScriptsStyleProvider({ element })

    var1 = Roact.mount(var2, CoreGui:FindFirstChild("FTUXMenu"), "PerspectiveTooltip")
end

function module.StopEvent()
    if var1 then
        Roact.unmount(var1)
    end
end

return module
