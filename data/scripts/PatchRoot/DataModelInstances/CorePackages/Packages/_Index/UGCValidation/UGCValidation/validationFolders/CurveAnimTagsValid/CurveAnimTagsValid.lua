-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionService = game:GetService("CollectionService")

local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local module = {
    categories = { ValidationEnums.UploadCategory.EMOTE_ANIMATION, ValidationEnums.UploadCategory.ANIMATION },
    requiredData = { ValidationEnums.SharedDataMember.curveAnimations },
    expectedFailures = {},
    prereqTests = { ValidationEnums.ValidationModule.CurveAnimDataAvailable }
}

local function isTimeStamp(str1: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (#str1 > 30) and string.match(str1, "^[0-9]+$") ~= nil
end

function module.run(arg1, arg2)
    for _, curveAnimation in arg2.curveAnimations do
        for _, child in curveAnimation:GetChildren() do
            local descendants = child:GetDescendants()
            table.insert(descendants, child)

            local tbl1 = {}
            for _, descendant in descendants do
                if #CollectionService:GetTags(descendant) > 0 then
                    table.insert(tbl1, descendant:GetFullName())
                end
            end
            if #tbl1 > 0 then
                arg1:fail(ErrorSourceStrings.Keys.InstanceTagsFound, { ProblematicDescendantPaths = table.concat(tbl1, ", ") })

                return
            end
        end

        local tags = CollectionService:GetTags(curveAnimation)
        local tagsLen = #tags

        if tagsLen > 0 and (tagsLen > 1 or not isTimeStamp(tags[1])) then
            arg1:fail(ErrorSourceStrings.Keys.CurveAnim_InvalidTags)
            return
        end
    end
end

return module
