-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local getAllInstancesIsA = require(scriptParentParentParent.util.getAllInstancesIsA)

local getFFlagUGCValidateCurveAnimSingleRoot = require(scriptParentParentParent.flags.getFFlagUGCValidateCurveAnimSingleRoot)

local module = {}

function module.getData(arg1, arg2)
    local tbl1 = {}
    local tbl2 = {}

    for _, value in getAllInstancesIsA(arg1, "Animation") do
        local animationId = value.AnimationId
        if animationId == "" then
            continue
        end

        local preloadedCurveAnimation = arg2 and arg2.preloadedCurveAnimations[animationId]
        if preloadedCurveAnimation then
            table.insert(tbl1, preloadedCurveAnimation)
            table.insert(tbl2, value)
        else
            local success, result = pcall(function(): {Instance}
                return game:GetObjectsAllOrNone(animationId)
            end)

            if not success or result == nil then
                return nil
            end

            if getFFlagUGCValidateCurveAnimSingleRoot() then
                if #result ~= 1 or not result[1]:IsA("CurveAnimation") then
                    return nil
                end

                table.insert(tbl1, result[1])
                table.insert(tbl2, value)
            else
                for _, value2 in result do
                    if value2:IsA("CurveAnimation") then
                        table.insert(tbl1, value2)
                        table.insert(tbl2, value)
                    end
                end
            end
        end
    end
    return tbl1, tbl2
end

return module
