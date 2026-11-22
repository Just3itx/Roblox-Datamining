-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionService = game:GetService("CollectionService")

local Constants = require(script.Parent.Constants)
local _sponsoredAdViewabilityTypes = require(script.Parent.sponsoredAdViewabilityTypes)

local tbl1 = ({})

local num1 = 0

return {
    bind = function(instance: Instance, arg1)
        local bool1 = arg1.mediaType == "video"
        if arg1.mediaType ~= "image" and not bool1 then
            return function() end
        end
        if bool1 ~= (arg1.videoPlaybackStateRef ~= nil) then
            return function() end
        end
        if arg1.isFullscreen == true and not bool1 then
            return function() end
        end
        num1 += 1
        local str1 = tostring(num1)
        tbl1[str1] = arg1
        instance:SetAttribute(Constants.ViewabilityTargetIdAttribute, str1)
        CollectionService:AddTag(instance, Constants.CandidateTag)

        return function()
            if instance:GetAttribute(Constants.ViewabilityTargetIdAttribute) == str1 then
                CollectionService:RemoveTag(instance, Constants.CandidateTag)
                instance:SetAttribute(Constants.ViewabilityTargetIdAttribute, nil)
            end
            tbl1[str1] = nil
        end
    end,
    get = function(str1: string)
        return tbl1[str1]
    end,
    _clear = function()
        for value in tbl1 do
            tbl1[value] = nil
        end
    end,
    _size = function(): number
        local num2 = 0
        for _ in tbl1 do
            num2 += 1
        end
        return num2
    end
}
