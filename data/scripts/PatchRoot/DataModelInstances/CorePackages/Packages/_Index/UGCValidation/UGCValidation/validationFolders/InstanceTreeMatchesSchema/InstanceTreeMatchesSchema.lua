-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Constants = require(scriptParentParentParent.Constants)
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local module = {
    categories = {
        ValidationEnums.UploadCategory.LAYERED_CLOTHING,
        ValidationEnums.UploadCategory.EYEBROW_EYELASH,
        ValidationEnums.UploadCategory.RIGID_ACCESSORY,
        ValidationEnums.UploadCategory.EMOTE_ANIMATION,
        ValidationEnums.UploadCategory.MAKEUP
    },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance },
    expectedFailures = {}
}
function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance

    if Constants.BANNED_NAMES[rootInstance.Name] then
        arg1:fail(ErrorSourceStrings.Keys.InstanceTreeBannedName, { InstancePath = rootInstance:GetFullName() })
    end

    for _, descendant in rootInstance:GetDescendants() do
        for _, className in Constants.BANNED_CLASS_NAMES do
            if not descendant:IsA(className) then
                continue
            end

            local instanceTreeBannedClass = ErrorSourceStrings.Keys.InstanceTreeBannedClass
            local tbl1 = {
                InstancePath = descendant:GetFullName(),
                ClassName = className
            }
            arg1:fail(instanceTreeBannedClass, tbl1)
        end

        if not Constants.BANNED_NAMES[descendant.Name] then
            continue
        end

        local instanceTreeBannedName = ErrorSourceStrings.Keys.InstanceTreeBannedName
        local tbl1 = {
            InstancePath = descendant:GetFullName()
        }
        arg1:fail(instanceTreeBannedName, tbl1)
    end
end

return module
