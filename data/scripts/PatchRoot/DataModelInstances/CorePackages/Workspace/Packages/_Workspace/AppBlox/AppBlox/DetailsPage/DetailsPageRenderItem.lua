-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local UIBlox = require(AppBloxParent.UIBlox)
local GuiService = game:GetService("GuiService")
local useSelectionCursor = UIBlox.App.SelectionImage.useSelectionCursor
local CursorKind = UIBlox.App.SelectionImage.CursorKind

local _Types = require(script.Parent.Types)

local React = require(AppBloxParent.React)

local function onSelectionGained(selectionParent: Instance)
    GuiService:Select(selectionParent)
end

local function DetailsPageRenderItem(tbl1)
    local item = tbl1.item
    local safeArea = tbl1.safeArea
    local itemPadding = tbl1.itemPadding

    local view = React.useMemo(function()
        return item.renderComponent()
    end, { item.renderComponent })

    local groupTransparency, var3 = React.useBinding(0)

    local ref = React.useRef(nil)
    local var5 = React.useCallback(function(arg1)
        local scrollingFrame = arg1:FindFirstAncestorOfClass("ScrollingFrame")
        if scrollingFrame == nil then
            return nil
        end

        local var5 = arg1.AbsolutePosition.Y - scrollingFrame.AbsolutePosition.Y - safeArea.Y
        local var6 = -(arg1.AbsoluteSize.Y + itemPadding)
        if var5 < 1 and var6 < var5 + safeArea.Y + 1 then
            local var7 = var5 / var6
            var3(var7)
        else
            var3(0)
        end
        return nil
    end, { safeArea, itemPadding })

    local selectionImageObject = useSelectionCursor(CursorKind.Invisible)

    return React.createElement("CanvasGroup", {
        key = item.key,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        ref = ref,
        [React.Change.AbsolutePosition] = var5,
        GroupTransparency = groupTransparency,
        BackgroundTransparency = 1,
        Selectable = item.useSelectionBumper,
        SelectionImageObject = selectionImageObject,
        [React.Event.SelectionGained] = onSelectionGained
    }, {
        Padding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, safeArea.X), PaddingRight = UDim.new(0, safeArea.X) }),
        View = view
    })
end

return DetailsPageRenderItem
