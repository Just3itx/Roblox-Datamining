-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:11:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local VRHub = require(CorePackages.Workspace.Packages.VrCommon).VRHub
local IsVRAppBuild = require(CorePackages.Workspace.Packages.AppCommonLib).IsVRAppBuild
local React = require(CorePackages.Packages.React)

local RunService = game:GetService("RunService")
local ToolTip = require(script.Parent.ToolTip)

local LuauPolyfill = require(CorePackages.Packages.LuauPolyfill)

local tbl1 = {}

local function onRenderStepped(_: number)
    if not IsVRAppBuild() then
        return
    end

    for _, value in pairs(tbl1) do
        local controllerModel = VRHub:GetControllerModel(value.Button.Controller)
        local buttonPosition = if controllerModel then controllerModel:getButtonPosition(value.Button.ButtonKeycode) else nil

        if not value.Part then
            continue
        end

        if controllerModel == nil or buttonPosition == nil then
            value.Part.Position = Vector3.new(-99999, -99999, -99999)
        else
            value.Part.Position = buttonPosition
        end
    end
end

function spawnTooltipPart(): Part
    local tooltipPart = Instance.new("Part")
    tooltipPart.Name = "TooltipPart"
    tooltipPart.Position = Vector3.new(0, -100, 0)
    tooltipPart.Anchored = true
    tooltipPart.CanCollide = false
    tooltipPart.Transparency = 1
    tooltipPart.Size = Vector3.new(0.1, 0.1, 0.1)
    tooltipPart.Parent = game.Workspace

    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Parent = tooltipPart
    billboardGui.Adornee = tooltipPart
    billboardGui.AlwaysOnTop = true
    billboardGui.Active = false
    billboardGui.Size = UDim2.new(1, 0, 1, 0)

    return tooltipPart
end

function showTooltipText(tbl2)
    for _, descendant in ipairs(tbl2.Part:GetDescendants()) do
        if descendant:IsA("TextLabel") and descendant.Name == "Body" then
            descendant.ZIndex = 10
        end
    end
end

function Tooltips(tbl2)
    for k, button in pairs(tbl2.tooltipButtons) do
        local tbl3 = tbl1
        local tbl4 = {
            Button = button,
            Part = spawnTooltipPart()
        }
        tbl3[k] = tbl4
    end

    React.useEffect(function()
        for _, value in pairs(tbl1) do
            showTooltipText(value)
        end
    end, {})

    RunService.RenderStepped:Connect(onRenderStepped)

    return React.createElement("Frame", {}, (LuauPolyfill.Array.map(tbl1, function(arg1, arg2)
        return (React.createElement(ToolTip, { controllerPart = arg1.Part, tooltipText = tbl2.tooltipButtons[arg2].Text }))
    end)))
end

return Tooltips
