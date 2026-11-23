-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")

local FIntBuildExperienceLibraryWorldFocusRadius = require(BuildExperience.Flags.FIntBuildExperienceLibraryWorldFocusRadius)
local getModelBox = require(script.Parent.getModelBox)

local function median(tbl1) -- Luacid: Inlined by compiler; 3 call sites recovered
    table.sort(tbl1)
    local num1 = #tbl1 // 2

    if #tbl1 % 2 == 1 then
        return tbl1[num1 + 1]
    end

    return (tbl1[num1] + tbl1[num1 + 1]) / 2
end

local function getSpawnPosition(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = if arg1 == nil then nil else arg1:FindFirstChildWhichIsA("SpawnLocation", true)
    return if var1 == nil then nil else var1.Position
end

local function getMiddleModelCenter(tbl1)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    for _, value in tbl1 do
        table.insert(tbl2, value.center.X)
        table.insert(tbl3, value.center.Y)
        table.insert(tbl4, value.center.Z)
    end
    local vec3 = Vector3.new(median(tbl2), median(tbl3), (median(tbl4)))
    local center = tbl1[1].center
    for i = 2, #tbl1 do
        if (tbl1[i].center - vec3).Magnitude < (center - vec3).Magnitude then
            center = tbl1[i].center
        end
    end
    return center
end

local function getDefaultWorldFocus(tbl1, arg1)
    local tbl2 = {}
    for _, value in tbl1 do
        local modelBox = getModelBox(value)
        if modelBox ~= nil then
            table.insert(tbl2, modelBox)
        end
    end
    if #tbl2 == 0 then
        return nil
    end

    local position = getSpawnPosition(arg1) or getMiddleModelCenter(tbl2)
    local tbl3 = ({})
    for _, value in tbl2 do
        tbl3[value] = (value.center - position).Magnitude
    end
    table.sort(tbl2, function(arg2, arg3): boolean
        return tbl3[arg2] < tbl3[arg3]
    end)
    local minimum = tbl2[1].minimum
    local maximum = tbl2[1].maximum
    local num1 = math.ceil(#tbl2 * 0.8)

    for i = 2, math.max(1, num1) do
        minimum = minimum:Min(tbl2[i].minimum)
        maximum = maximum:Max(tbl2[i].maximum)
    end
    local radius = (maximum - minimum).Magnitude / 2
    local num2 = math.max(1, FIntBuildExperienceLibraryWorldFocusRadius)
    return if num2 < radius then { position = position, radius = num2 } else {
        position = (minimum + maximum) / 2,
        radius = radius
    }
end
return getDefaultWorldFocus
