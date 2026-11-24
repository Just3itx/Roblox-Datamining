-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Players = game:GetService("Players")

local Constants = require(scriptParentParent.Constants)

local function getLocalPlayerCharacter(): Model? -- Luacid: Inlined by compiler; 1 call site recovered
    local localPlayer = Players.LocalPlayer
    return if localPlayer then localPlayer.Character else nil
end

return function(arg1)
    local result = {}
    local tbl1 = ({})
    arg1 = arg1 or getLocalPlayerCharacter()

    if not arg1 then
        return result
    end

    local humanoid = arg1:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        return result
    end

    local humanoidDescription = humanoid:FindFirstChildOfClass("HumanoidDescription")
    if not humanoidDescription then
        return result
    end

    for value, value2 in Constants.AssetTypeIdStringToHumanoidDescriptionProp do
        if Constants.AssetTypeIdToAccessoryTypeEnum[value] ~= nil then
            continue
        end

        local var1 = humanoidDescription[value2] or ""
        for _, value3 in string.split(var1) do
            local var2 = tonumber(value3)
            if var2 and var2 ~= 0 and not tbl1[var2] then
                tbl1[var2] = true
                table.insert(result, var2)
            end
        end
    end

    for _, value in (humanoidDescription:GetAccessories(true)) do
        if value.AssetId and value.AssetId ~= 0 and not tbl1[value.AssetId] then
            tbl1[value.AssetId] = true
            table.insert(result, value.AssetId)
        end
    end

    return result
end
