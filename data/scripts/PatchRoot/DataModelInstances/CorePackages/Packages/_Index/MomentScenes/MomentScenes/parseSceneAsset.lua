-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Parent.Types)

local function readValue(arg1)
    if arg1:IsA("StringValue") then
        return arg1.Value
    end

    if arg1:IsA("IntValue") or arg1:IsA("NumberValue") then
        return arg1.Value
    end

    if arg1:IsA("BoolValue") then
        return arg1.Value
    end

    if arg1:IsA("Color3Value") then
        return arg1.Value
    end

    if arg1:IsA("Vector3Value") then
        return arg1.Value
    end

    if arg1:IsA("CFrameValue") then
        return arg1.Value
    end

    if arg1:IsA("ObjectValue") then
        return arg1.Value
    end

    if not arg1:IsA("Folder") then
        return nil
    end

    local children = arg1:GetChildren()

    local tbl1 = {}
    local bool1 = #children > 0
    for _, child in children do
        local index = tonumber(child.Name)
        if index == nil or index < 1 or index % 1 ~= 0 then
            bool1 = false
            break
        end

        table.insert(tbl1, { index = index, child = child })
    end
    if not bool1 then
        local result = {}
        for _, child in children do
            result[child.Name] = readValue(child)
        end
        return result
    end

    table.sort(tbl1, function(arg2, arg3): boolean
        return arg2.index < arg3.index
    end)
    local result = ({})
    for value, value2 in tbl1 do
        local var1 = readValue(value2.child)

        result[value] = var1
        if var1 == nil then
            warn(
                `parseSceneAsset: {value2.child:GetFullName()} is a {value2.child.ClassName}, which holds no value this parser reads. Slot {value} is empty.`
            )
        end
    end
    return result
end

local function findSceneFolder(arg1)
    local momentScene = arg1:FindFirstChild("MomentScene")
    if momentScene ~= nil then
        return momentScene
    end
    if arg1:FindFirstChild("Type") ~= nil then
        return arg1
    end
    if arg1:FindFirstChild("Args") ~= nil then
        return arg1
    end
    for _, child in arg1:GetChildren() do
        if child:FindFirstChild("Type") ~= nil or child:FindFirstChild("Args") ~= nil then
            return child
        end
    end
    return arg1
end

local function parseSceneAsset(arg1)
    local sceneFolder = findSceneFolder(arg1)

    local value = nil
    local type = if sceneFolder then sceneFolder:FindFirstChild("Type") else nil

    if type ~= nil and type:IsA("StringValue") then
        value = type.Value
    end

    local tbl1 = {}
    local args = if sceneFolder then sceneFolder:FindFirstChild("Args") else nil

    if args ~= nil then
        for _, child in args:GetChildren() do
            tbl1[child.Name] = readValue(child)
        end
    end

    return { type = value, args = tbl1 }
end

return parseSceneAsset
