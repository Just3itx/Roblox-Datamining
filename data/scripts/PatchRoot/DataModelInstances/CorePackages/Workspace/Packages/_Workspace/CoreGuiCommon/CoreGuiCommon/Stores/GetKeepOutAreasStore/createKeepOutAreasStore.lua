-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:00:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local GuiService = game:GetService("GuiService")
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Signals = require(scriptParentParentParentParent.Signals)
local Cryo = require(scriptParentParentParentParent.Cryo)
local Display = require(scriptParentParentParentParent.Display)
local createSignal = Signals.createSignal
local createEffect = Signals.createEffect

return function()
    local getKeepOutAreas, var2 = createSignal({}, Cryo.Dictionary.equals)

    local function func1(vector2: Vector2, vector2_2: Vector2, tbl1)
        local result = {}
        local vector2X = vector2.X
        local vector2Y = vector2.Y
        local vector22X = vector2_2.X
        local var3 = vector2_2.Y - vector2Y

        local num1 = 0

        for _, value in ipairs(tbl1) do
            local var4 = vector2X + num1
            table.insert(result, { Position = { X = var4, Y = vector2Y }, Size = { X = value.position.X - var4, Y = var3 } })

            vector2X = value.position.X
            num1 = value.size.X
        end

        local var4 = vector2X + num1
        table.insert(result, { Position = { X = var4, Y = vector2Y }, Size = { X = vector22X - var4, Y = var3 } })

        return result
    end

    local function func2(tbl1)
        local tbl2 = {}
        for _, value in pairs(tbl1) do
            table.insert(tbl2, { id = value.id, size = value.size, position = value.position })
        end

        table.sort(tbl2, function(arg1, arg2): boolean
            return arg1.position.X < arg2.position.X and arg1.position.X + arg1.size.X < arg2.size.X + arg2.position.X
        end)

        local vector2, _vector2 = GuiService:GetGuiInset()
        local var3 = Display.GetDisplayStore(false).getViewportSize(false)

        local vector2_2 = Vector2.new(0, 0)
        local vector2_3 = Vector2.new(var3.X, vector2.Y)

        local tbl3 = func1(vector2_2, vector2_3, tbl2)

        local var4 = nil
        for _, value in ipairs(tbl3) do
            if not var4 or value.Size.X > var4.Width then
                var4 = Rect.new(value.Position.X, value.Position.Y, value.Position.X + value.Size.X, value.Position.Y + value.Size.Y)
            end
        end

        return var4
    end

    local function setKeepOutArea(id: string, vector2: Vector2, vector2_2: Vector2)
        local tbl1 = ({})
        tbl1[id] = { id = id, position = vector2, size = vector2_2 }

        var2(Cryo.Dictionary.join(getKeepOutAreas(false), tbl1))
    end

    local effect = createEffect(function(arg1)
        Display.GetDisplayStore(arg1).getViewportSize(arg1)
        local topbarInset = func2(getKeepOutAreas(arg1))
        if topbarInset then
            GuiService:SetTopbarInset(topbarInset)
        end
    end)

    return {
        getKeepOutAreas = getKeepOutAreas,
        setKeepOutArea = setKeepOutArea,
        removeKeepOutArea = function(str1: string)
            local var3 = getKeepOutAreas(false)
            var3[str1] = nil
            var2(var3)
        end,
        cleanup = function()
            effect()
        end
    }
end
