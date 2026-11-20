-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local Utils = require(scriptParent.Utils)

local module = {}

module.__index = module

function module:getCFrame()
    return self.part.CFrame
end

function module:setCFrame(cFrame: CFrame)
    self.part.CFrame = cFrame
end

function module:updateTransparency()
    if self.dragBarState == "Hovering" then
        self.dragBarImage.ImageTransparency = 0.2
    elseif self.dragBarState == "Dragging" then
        self.dragBarImage.ImageTransparency = 0
    else
        self.dragBarImage.ImageTransparency = 0.6
    end
end

function module:updateState()
    if self.dragging then
        self.dragBarState = "Dragging"
    elseif self.hovering and not self.dragging then
        self.dragBarState = "Hovering"
    else
        self.dragBarState = "Idle"
    end
    self:updateTransparency()
end

function module:startDrag(cFrame: CFrame)
    self.dragging = true
    self.uiGroupOffSet = cFrame
    self:updateState()
end

function module:dragEnd()
    self.dragging = false
    self:updateState()
end

function module:startHover()
    self.hovering = true
    self:updateState()
end

function module:hoverEnd()
    self.hovering = false
    self:updateState()
end

function module:show()
    self.part.Parent = self.partsParent
end

function module:hide()
    self.part.Parent = nil
end

function module:rescale(num1: number)
    self.part.Size = self.part.Size * num1
    if self.uiGroupOffSet then
        self.uiGroupOffSet = Utils.rescaleCFramePosition(self.uiGroupOffSet, num1)
    end
end

function module.new(part, dragBarImage)
    local tbl1 = {
        part = part,
        dragBarImage = dragBarImage,
        hovering = false,
        dragging = false,
        dragBarState = "Idle",
        partsParent = part.Parent,
        uiGroupOffSet = nil
    }

    setmetatable(tbl1, module)
    tbl1.dragBarImage.ImageTransparency = 0.6
    return tbl1
end

return module
