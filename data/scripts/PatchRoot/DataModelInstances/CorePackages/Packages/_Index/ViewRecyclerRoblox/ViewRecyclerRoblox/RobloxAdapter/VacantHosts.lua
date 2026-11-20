-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecyclerRoblox = script:FindFirstAncestor("ViewRecyclerRoblox")

local ReparentableHost = require(ViewRecyclerRoblox.RobloxAdapter.ReparentableHost)
local transparentFrame = require(ViewRecyclerRoblox.RobloxAdapter.transparentFrame)

local module = {}

local var1 = (setmetatable({}, { __mode = "k" }))

function module.register(arg1, tbl1)
    var1[arg1] = tbl1
end

function module.forScope(arg1)
    local var2 = var1[arg1]
    assert(
        var2 ~= nil,
        "ViewRecycler: the Recycling scope has no place for Vacant Hosts; create it with RobloxAdapter.createRecyclingScope"
    )

    return var2
end

local function scaleOf(arg1): number
    local num1 = 1

    while arg1 ~= nil do
        local uiScale = arg1:FindFirstChildOfClass("UIScale")
        if uiScale ~= nil then
            num1 *= uiScale.Scale
        end
        arg1 = arg1.Parent
    end
    return num1
end

local function hide(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    ReparentableHost.clearSelection(arg1)
    if arg1.Visible then
        arg1.Visible = false
    end
end

function module.new()
    local var2 = transparentFrame("ViewRecyclerVacantHosts")
    var2.Size = UDim2.fromScale(1, 1)
    var2.Visible = false

    local tbl1 = ({})
    local var3 = (setmetatable({}, { __mode = "k" }))

    local function frameFor(scale: number)
        if math.abs(scale - 1) < 1e-6 then
            return var2
        end
        local str1 = string.format("%.6f", scale)
        local var4 = tbl1[str1]
        if var4 == nil then
            var4 = transparentFrame("Scaled")
            var4.Size = UDim2.fromScale(1, 1)
            local uiScale = Instance.new("UIScale")
            uiScale.Scale = scale
            uiScale.Parent = var4
            var4.Parent = var2
            tbl1[str1] = var4
        end
        return var4
    end

    local function hold(tbl2)
        local bool1 = var2:FindFirstAncestorWhichIsA("LayerCollector") ~= nil
        local num1 = scaleOf(var2)

        local var4 = table.create(#tbl2)
        local var5 = table.create(#tbl2)
        for value, value2 in tbl2 do
            var3[value2] = nil
            hide(value2)

            if value2:FindFirstAncestorWhichIsA("LayerCollector") == nil then
                var4[value] = false
            elseif bool1 then
                var4[value] = value2.AbsoluteSize / scaleOf(value2)
                var5[value] = scaleOf(value2.Parent) / num1
            end
        end
        for value, value2 in tbl2 do
            local var6 = var4[value]
            if var6 == false then
                value2.Position = UDim2.new()
                value2.Parent = var2
            elseif var6 ~= nil then
                value2.Position = UDim2.new()
                value2.Size = UDim2.fromOffset(var6.X, var6.Y)
                value2.Parent = frameFor(var5[value])
            end
        end
    end

    return {
        setParent = function(arg1)
            if var2.Parent ~= arg1 then
                var2.Parent = arg1
            end
        end,
        leave = function(arg1)
            hide(arg1)
            var3[arg1] = true
        end,
        reclaim = function(arg1)
            var3[arg1] = nil
        end,
        evacuate = function(arg1)
            local tbl2 = {}
            for value in var3 do
                local valueParent = value.Parent
                if valueParent ~= nil and arg1(valueParent) then
                    table.insert(tbl2, value)
                end
            end
            if #tbl2 > 0 then
                hold(tbl2)
            end
        end,
        hold = hold,
        destroy = function()
            var2:Destroy()
            table.clear(tbl1)
            table.clear(var3)
        end
    }
end

return module
