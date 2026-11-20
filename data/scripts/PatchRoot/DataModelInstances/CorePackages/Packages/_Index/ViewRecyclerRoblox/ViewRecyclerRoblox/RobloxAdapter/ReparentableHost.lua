-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerRoblox").Flags).FFlagViewRecyclerReact084
local ViewRecyclerRoblox = script:FindFirstAncestor("ViewRecyclerRoblox")

local SlotGeometry = require(ViewRecyclerRoblox.RobloxAdapter.SlotGeometry)
local GuiService = game:GetService("GuiService")

local module = {}

function module.clearSelection(arg1)
    local selectedObject = GuiService.SelectedObject
    if selectedObject ~= nil and (selectedObject == arg1 or selectedObject:IsDescendantOf(arg1)) then
        GuiService.SelectedObject = nil
    end
end

function module.create(frameName: string): Frame
    local frame = Instance.new("Frame")
    frame.Name = frameName
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.Position = UDim2.new()
    frame.Size = UDim2.new()
    return frame
end

function module.place(arg1, tbl1)
    arg1.AutomaticSize = tbl1.automaticSize

    if FFlagViewRecyclerReact084 then
        arg1.Position = UDim2.new()
    end
    arg1.Size = SlotGeometry.getHostSize(tbl1.automaticSize)
    arg1.Parent = tbl1.placeholder
end

function module.detach(arg1)
    module.clearSelection(arg1)
    arg1.Parent = nil
end

function module.destroy(arg1)
    module.detach(arg1)
    arg1:Destroy()
end

return module
