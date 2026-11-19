-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local React = require(CorePackages.Packages.React)
local useSelector = require(CorePackages.Workspace.Packages.RoactUtils).Hooks.RoactRodux.useSelector

local function func1(vector2: Vector2, vector2_2: Vector2, tbl1)
    local result = {}
    local vector2X = vector2.X
    local vector2Y = vector2.Y
    local vector22X = vector2_2.X
    local var1 = vector2_2.Y - vector2Y

    local num1 = 0

    for _, value in ipairs(tbl1) do
        local var2 = vector2X + num1
        table.insert(result, { Position = { X = var2, Y = vector2Y }, Size = { X = value.position.X - var2, Y = var1 } })

        vector2X = value.position.X
        num1 = value.size.X
    end

    local var2 = vector2X + num1
    table.insert(result, { Position = { X = var2, Y = vector2Y }, Size = { X = vector22X - var2, Y = var1 } })

    return result
end

local function func2(vector2: Vector2, tbl1)
    local tbl2 = {}
    for _, value in pairs(tbl1) do
        table.insert(tbl2, { id = value.id, size = value.size, position = value.position })
    end

    table.sort(tbl2, function(arg1, arg2): boolean
        return arg1.position.X < arg2.position.X and arg1.position.X + arg1.size.X < arg2.size.X + arg2.position.X
    end)

    local vector2_2, _vector2 = GuiService:GetGuiInset()

    local vector2_3 = Vector2.new(0, 0)
    local vector2_4 = Vector2.new(vector2.X, vector2_2.Y)

    local tbl3 = func1(vector2_3, vector2_4, tbl2)

    local var1 = nil
    for _, value in ipairs(tbl3) do
        if not var1 or value.Size.X > var1.Width then
            var1 = Rect.new(value.Position.X, value.Position.Y, value.Position.X + value.Size.X, value.Position.Y + value.Size.Y)
        end
    end

    return var1
end

local function func3(vector2: Vector2, tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local topbarInset = func2(vector2, tbl1)
    if topbarInset then
        GuiService:SetTopbarInset(topbarInset)
    end
end

function KeepOutAreasHandler(_)
    local var1 = useSelector(function(arg1)
        return arg1.displayOptions.screenSize
    end)

    local var2 = useSelector(function(arg1)
        return arg1.displayOptions.keepOutAreas
    end)

    React.useEffect(function()
        func3(var1, var2)
    end, { var1, var2 })
end

return KeepOutAreasHandler
