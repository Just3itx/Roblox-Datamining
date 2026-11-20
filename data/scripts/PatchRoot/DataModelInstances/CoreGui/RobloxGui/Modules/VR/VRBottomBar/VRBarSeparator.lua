-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local t = InGameMenuDependencies.t
local Roact = InGameMenuDependencies.Roact
local UIBlox = InGameMenuDependencies.UIBlox
local Cryo = InGameMenuDependencies.Cryo
local withSelectionCursorProvider = UIBlox.App.SelectionImage.withSelectionCursorProvider
local CursorKind = UIBlox.App.SelectionImage.CursorKind

local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton

local _StarterGui = game:GetService("StarterGui")
local _RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local _StarterPlayer = game:GetService("StarterPlayer")

t.strictInterface({
    AnchorPoint = t.optional(t.Vector2),
    Position = t.optional(t.UDim2),
    layoutOrder = t.optional(t.integer),
    onActivated = t.callback,
    onSelectionGained = t.optional(t.callback),
    onSelectionLost = t.optional(t.callback),
    forwardRef = t.optional(t.table)
})

local function renderWithSelectionCursor(arg1, arg2)
    local createElement = Roact.createElement
    local var1 = ImageSetButton
    local tbl1 = {
        Visible = true,
        AnchorPoint = arg1.AnchorPoint,
        BackgroundTransparency = 1,
        Image = "rbxasset://textures/ui/MenuBar/divider.png",
        Position = UDim2.new(0, 1, 0, 1),
        Size = UDim2.new(0, 28, 0, 36),
        LayoutOrder = arg1.layoutOrder,
        SelectionImageObject = arg2(CursorKind.RoundedRect)
    }
    tbl1[Roact.Event.Activated] = function() end

    tbl1[Roact.Event.SelectionGained] = arg1.onSelectionGained
    tbl1[Roact.Event.SelectionLost] = arg1.onSelectionLost
    tbl1[Roact.Ref] = arg1.forwardRef
    return createElement(var1, tbl1)
end

local function VRBarSeparator(arg1)
    return withSelectionCursorProvider(function(arg2)
        return renderWithSelectionCursor(arg1, arg2)
    end)
end

return Roact.forwardRef(function(arg1, forwardRef)
    return Roact.createElement(VRBarSeparator, Cryo.Dictionary.join(arg1, { forwardRef = forwardRef }))
end)
