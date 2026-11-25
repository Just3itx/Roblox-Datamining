-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local React = require(ServerDrivenUiParent.React)

local bool1 = game:DefineFastFlag("LuaAppSduiSlotOverlayZIndex", false)

local tbl1 = {
    topLeftSlot = {
        AnchorPoint = Vector2.zero,
        Position = UDim2.fromScale(0, 0)
    },
    topMiddleSlot = {
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0)
    },
    topRightSlot = {
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.fromScale(1, 0)
    },
    centerLeftSlot = {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.fromScale(0, 0.5)
    },
    centerMiddleSlot = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5)
    },
    centerRightSlot = {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.fromScale(1, 0.5)
    },
    bottomLeftSlot = {
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.fromScale(0, 1)
    },
    bottomMiddleSlot = {
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.fromScale(0.5, 1)
    },
    bottomRightSlot = {
        AnchorPoint = Vector2.new(1, 1),
        Position = UDim2.fromScale(1, 1)
    }
}

return React.memo(function(tbl2) -- name: SduiSlotOverlay
    local layoutOrder = tbl2.layoutOrder
    local anchorPoint = tbl2.anchorPoint
    local automaticSize = tbl2.automaticSize
    local size = tbl2.size
    local position = tbl2.position

    local padding = tbl2.padding or 0
    local var1 = React.useMemo(function()
        local tbl3 = {
            UIPadding = React.createElement("UIPadding", {
                PaddingLeft = UDim.new(0, padding),
                PaddingTop = UDim.new(0, padding),
                PaddingRight = UDim.new(0, padding),
                PaddingBottom = UDim.new(0, padding)
            })
        }
        for value, value2 in tbl1 do
            if tbl2[value] == nil then
                continue
            end

            local createElement = React.createElement
            local tbl4 = {
                AnchorPoint = value2.AnchorPoint,
                AutomaticSize = Enum.AutomaticSize.XY,
                Position = value2.Position,
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 0, 0, 0),
                [React.Tag] = `data-testid=--sdui-slot-{value}`
            }
            local tbl5 = {
                item = tbl2[value]
            }
            tbl3[value] = createElement("Frame", tbl4, tbl5)
        end

        return tbl3
    end, {
        tbl2.topLeftSlot,
        tbl2.topMiddleSlot,
        tbl2.topRightSlot,
        tbl2.centerLeftSlot,
        tbl2.centerMiddleSlot,
        tbl2.centerRightSlot,
        tbl2.bottomLeftSlot,
        tbl2.bottomMiddleSlot,
        tbl2.bottomRightSlot,
        padding
    })

    return React.createElement("Frame", {
        LayoutOrder = layoutOrder,
        AnchorPoint = anchorPoint,
        AutomaticSize = automaticSize,
        Size = size or UDim2.new(1, 0, 1, 0),
        Position = position,
        BackgroundTransparency = 1,
        ZIndex = if bool1 then tbl2.zIndex else nil,
        [React.Tag] = "data-testid=--sdui-slot-overlay"
    }, var1)
end)
