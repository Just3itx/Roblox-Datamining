-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local FloatVector = require(scriptParentParent.util.FloatVector)

local module = {}
module.__index = module

function module.new(tbl1, objectFunction: (...any) -> (...any), terminateFunction: (...any) -> (...any))
    local self = (setmetatable({}, module))

    if tbl1 and #tbl1 > 0 then
        local var1 = tbl1[1]
        for _, value in tbl1 do
            if not var1:checkCompatible(value) then
                error("initial simplex has vectors that are not compatible")
            end
        end
    else
        error("must provide an initial simplex")
    end

    self.simplex = {}
    for _, value in tbl1 do
        table.insert(self.simplex, FloatVector.new(value))
    end
    self.objectFunction = objectFunction
    self.terminateFunction = terminateFunction
    return self
end

function module:evaluate()
    local simplex = self.simplex

    local tbl1 = ({})
    local function func1(arg1) -- Luacid: Inlined by compiler; 11 call sites recovered
        local var1 = tbl1[arg1]
        if not var1 then
            var1 = self.objectFunction(arg1)
            tbl1[arg1] = var1
        end
        return var1
    end

    local num1 = 0

    while not self.terminateFunction(simplex, num1) do
        tbl1 = {}

        table.sort(simplex, function(arg1, arg2): boolean
            return func1(arg1) < func1(arg2)
        end)

        local var1 = simplex[#simplex]

        local tbl2 = {}
        for _ = 1, simplex[1]:getSize() do
            table.insert(tbl2, 0)
        end
        local floatVector = FloatVector.new(tbl2)
        for i = 1, #simplex - 1 do
            floatVector += simplex[i]
        end
        local var2 = floatVector / (#simplex - 1) - var1
        local var3 = var1 + var2 * 2
        local var4 = func1(var3)

        if func1(simplex[1]) < var4 and var4 < func1(simplex[#simplex - 1]) then
            simplex[#simplex] = var3
        elseif var4 < func1(simplex[1]) then
            local var5 = var3 + var2

            if func1(var5) < var4 then
                simplex[#simplex] = var5
            else
                simplex[#simplex] = var3
            end
        else
            local var5 = var1 + var2 * 0.5
            local var6 = var1 + var2 * 1.5

            if not (func1(var5) < func1(var6)) then
                var5 = var6
            end

            if func1(var5) < func1(simplex[#simplex - 1]) then
                simplex[#simplex] = var5
            else
                for i = 1, #simplex do
                    simplex[i] = (simplex[i] - simplex[1]) * 0.8 + simplex[1]
                end
            end
        end

        num1 += 1
    end
end

function module.calculateMaxLengthBetweenVertices(tbl1): number
    local num1 = 0
    for i = 1, #tbl1 - 1 do
        for j = i + 1, #tbl1 do
            num1 = math.max(num1, ((tbl1[j] - tbl1[i]):magnitude()))
        end
    end

    return num1
end

return module
