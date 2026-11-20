-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local module = {
    categories = {
        ValidationEnums.UploadCategory.TORSO_AND_LIMBS,
        ValidationEnums.UploadCategory.DYNAMIC_HEAD,
        ValidationEnums.UploadCategory.LAYERED_CLOTHING,
        ValidationEnums.UploadCategory.EYEBROW_EYELASH
    },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance },
    expectedFailures = {}
}
function module.run(arg1, arg2)
    if arg2.consumerConfig.consumerEnv == ValidationEnums.ConsumerEnv.IEC or arg2.consumerConfig.source == "AutoSetup" then
        return
    end

    local rootInstance = arg2.rootInstance

    local descendants = rootInstance:GetDescendants()
    table.insert(descendants, rootInstance)

    for _, descendant in descendants do
        if not descendant:IsA("BaseWrap") or descendant:IsHSRReady() then
            continue
        end

        local hsrDataNotReady = ErrorSourceStrings.Keys.HSRDataNotReady
        local tbl1 = {
            InstancePath = descendant:GetFullName()
        }
        arg1:fail(hsrDataNotReady, tbl1)
    end
end

return module
