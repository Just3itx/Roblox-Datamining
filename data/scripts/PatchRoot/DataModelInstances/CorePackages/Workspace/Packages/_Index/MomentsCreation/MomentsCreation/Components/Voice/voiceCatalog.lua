-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")

local GetFIntMomentsTTSDefaultVoiceId = require(MomentsCreation.Flags.GetFIntMomentsTTSDefaultVoiceId)

local tbl1 = {
    { id = 9, name = "Retro voice #1", language = "English", gender = "male" },
    { id = 10, name = "Retro voice #2", language = "English", gender = "male" },
    { id = 1, name = "British male", language = "English (UK)", gender = "male" },
    { id = 2, name = "British female", language = "English (UK)", gender = "female" },
    { id = 3, name = "United States male #1", language = "English (US)", gender = "male" },
    { id = 4, name = "United States female #1", language = "English (US)", gender = "female" },
    { id = 5, name = "United States male #2", language = "English (US)", gender = "male" },
    { id = 6, name = "United States female #2", language = "English (US)", gender = "female" },
    { id = 7, name = "Australian male", language = "English (AU)", gender = "male" },
    { id = 8, name = "Australian female", language = "English (AU)", gender = "female" },
    { id = 11, name = "Host voice", language = "English", gender = "female" },
    { id = 101, name = "Spanish male", language = "Spanish", gender = "male" },
    { id = 102, name = "Spanish female", language = "Spanish", gender = "female" },
    { id = 201, name = "German male", language = "German", gender = "male" },
    { id = 202, name = "German female", language = "German", gender = "female" },
    { id = 301, name = "Italian male", language = "Italian", gender = "male" },
    { id = 302, name = "Italian female", language = "Italian", gender = "female" },
    { id = 401, name = "French male", language = "French", gender = "male" },
    { id = 402, name = "French female", language = "French", gender = "female" }
}

local tbl2 = {}
for _, value in tbl1 do
    tbl2[value.id] = value
end

local module = {}

function module.getDefaultVoiceId()
    return GetFIntMomentsTTSDefaultVoiceId()
end

function module.getVoiceById(num1: number)
    return tbl2[num1]
end

function module.getOrderedVoices()
    local defaultVoiceId = module.getDefaultVoiceId()
    local orderedVoices = {}
    local var1 = tbl2[defaultVoiceId]
    if var1 ~= nil then
        table.insert(orderedVoices, var1)
    end
    for _, value in tbl1 do
        if value.id ~= defaultVoiceId then
            table.insert(orderedVoices, value)
        end
    end
    return orderedVoices
end

return module
