-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Cryo = require(scriptParentParentParent.Parent.Cryo)

local Constants = require(scriptParentParentParent.Constants)
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local valueToString = require(scriptParentParentParent.util.valueToString)

local module = {
    categories = {
        ValidationEnums.UploadCategory.TORSO_AND_LIMBS,
        ValidationEnums.UploadCategory.DYNAMIC_HEAD,
        ValidationEnums.UploadCategory.LAYERED_CLOTHING,
        ValidationEnums.UploadCategory.EYEBROW_EYELASH,
        ValidationEnums.UploadCategory.RIGID_ACCESSORY,
        ValidationEnums.UploadCategory.MAKEUP
    },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance, ValidationEnums.SharedDataMember.uploadEnum },
    expectedFailures = {}
}
local function comparitorMethodImpl(num1: number, num2: number, foundIn: string): boolean
    if foundIn == Constants.COMPARISON_METHODS.SMALLER then
        return num1 < num2
    end

    if foundIn == Constants.COMPARISON_METHODS.SMALLER_EQ then
        return num1 <= num2
    end

    if foundIn == Constants.COMPARISON_METHODS.FUZZY_EQ then
        return math.abs(num1 - num2) <= 0.00001
    end

    if foundIn == Constants.COMPARISON_METHODS.EXACT_EQ then
        return num1 == num2
    end

    if foundIn == Constants.COMPARISON_METHODS.GREATER_EQ then
        return num2 <= num1
    end

    if foundIn == Constants.COMPARISON_METHODS.GREATER then
        return num2 < num1
    end

    error("Invalid comparitor method: " .. foundIn)
end

local function doesPropertyMatchExpectations(arg1, none, foundIn: string)
    if none == Cryo.None then
        return arg1 == nil
    elseif typeof(none) == "table" and foundIn == Constants.COMPARISON_METHODS.FOUND_IN then
        local bool1 = false
        for _, value in none do
            bool1 = bool1 or doesPropertyMatchExpectations(arg1, value, Constants.COMPARISON_METHODS.EXACT_EQ)
        end
        return bool1
    elseif typeof(arg1) ~= typeof(none) then
        return false
    elseif typeof(none) == "number" then
        return comparitorMethodImpl(arg1, none, foundIn)
    elseif typeof(none) == "Vector3" then
        return comparitorMethodImpl(arg1.X, none.X, foundIn)
            and comparitorMethodImpl(arg1.Y, none.Y, foundIn)
            and comparitorMethodImpl(arg1.Z, none.Z, foundIn)
    elseif typeof(none) == "Color3" then
        return comparitorMethodImpl(arg1.R, none.R, foundIn)
            and comparitorMethodImpl(arg1.G, none.G, foundIn)
            and comparitorMethodImpl(arg1.B, none.B, foundIn)
    else
        return arg1 == none
    end
end

local function extractSubProperty(str1: string, cFrame) -- Luacid: unused: defined but never referenced
    if typeof(cFrame) == "CFrame" and str1 == "PositionMagnitude" then
        return true, cFrame.Position.Magnitude
    elseif typeof(cFrame) == "CFrame" and str1 == "Orientation" then
        return true, Vector3.new(cFrame:ToOrientation())
    elseif typeof(cFrame) == "CFrame" and str1 == "Position" then
        return true, cFrame.Position
    end

    return false
end

local function getAllActiveTestsOnProperty(arg1, str1: string, cFrame, arg2)
    if typeof(arg2) ~= "table" then
        return {{
            str1,
            cFrame,
            arg2,
            Constants.COMPARISON_METHODS.FUZZY_EQ
        }}
    end
    for value, value2 in arg2 do
        if value == Constants.INCLUSION_METHODS.INCLUSION_LIST then
            if table.find(value2, arg1) == nil then
                return {}
            end
        elseif value == Constants.INCLUSION_METHODS.EXCLUSION_LIST and table.find(value2, arg1) ~= nil then
            return {}
        end
    end

    local allActiveTestsOnProperty = {}
    for _, value in Constants.COMPARISON_METHODS do
        if arg2[value] == nil then
            continue
        end

        table.insert(allActiveTestsOnProperty, { str1, cFrame, arg2[value], value })
    end

    local num1 = 1

    while arg2[num1] ~= nil do
        local allActiveTestsOnProperty2 = getAllActiveTestsOnProperty(arg1, str1, cFrame, arg2[num1])
        table.move(
            allActiveTestsOnProperty2,
            1,
            #allActiveTestsOnProperty2,
            #allActiveTestsOnProperty + 1,
            allActiveTestsOnProperty
        )
        num1 += 1
    end

    for value, value2 in arg2 do
        local var1, bool1

        if typeof(cFrame) == "CFrame" and value == "PositionMagnitude" then
            var1 = cFrame.Position.Magnitude
            bool1 = true
        elseif typeof(cFrame) == "CFrame" and value == "Orientation" then
            var1 = Vector3.new(cFrame:ToOrientation())
            bool1 = true
        elseif typeof(cFrame) == "CFrame" and value == "Position" then
            var1 = cFrame.Position
            bool1 = true
        else
            bool1 = false
            var1 = nil
        end

        if not bool1 then
            continue
        end

        for _, value3 in (getAllActiveTestsOnProperty(arg1, value, var1, value2)) do
            value3[1] = str1 .. "." .. value3[1]
            table.insert(allActiveTestsOnProperty, value3)
        end
    end

    return allActiveTestsOnProperty
end

function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance
    local assetType = arg2.uploadEnum.assetType

    local descendants = rootInstance:GetDescendants()
    table.insert(descendants, rootInstance)

    for _, descendant in descendants do
        for value, value2 in Constants.PROPERTIES do
            if not descendant:IsA(value) then
                continue
            end

            for propertyName, value4 in value2 do
                local success, result = pcall(function()
                    return descendant[propertyName]
                end)

                if not success then
                    local propertyNotFound = ErrorSourceStrings.Keys.PropertyNotFound
                    local tbl1 = {
                        PropertyName = propertyName,
                        InstancePath = descendant:GetFullName()
                    }
                    arg1:fail(propertyNotFound, tbl1)
                else
                    for _, value5 in (getAllActiveTestsOnProperty(assetType, propertyName, result, value4)) do
                        local var1, var2, var3, comparisonMethod = table.unpack(value5)
                        if doesPropertyMatchExpectations(var2, var3, comparisonMethod) then
                            continue
                        end

                        local propertyValueInvalid = ErrorSourceStrings.Keys.PropertyValueInvalid
                        local tbl1 = {
                            PropertyName = var1,
                            InstancePath = descendant:GetFullName(),
                            ComparisonMethod = comparisonMethod,
                            ExpectedValue = valueToString(var3)
                        }
                        arg1:fail(propertyValueInvalid, tbl1)
                    end
                end
            end
        end
    end
end

return module
