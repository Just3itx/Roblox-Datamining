-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Cryo = require(CorePackages.Packages.Cryo)
local Rodux = require(CorePackages.Packages.Rodux)

local Actions = script.Parent.Parent.Actions

local EmotesChanged = require(Actions.EmotesChanged)
local EquippedEmotesChanged = require(Actions.EquippedEmotesChanged)
local NumberEmotesLoadedChanged = require(Actions.NumberEmotesLoadedChanged)

local function createCurrentEmotes(arg1, equippedEmotes)
    local currentEmotes = ({})

    for _, value in ipairs(equippedEmotes) do
        local slot = value.Slot
        local valueName = value.Name

        if slot and valueName and arg1[valueName] then
            currentEmotes[slot] = valueName
        end
    end

    return currentEmotes
end

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[EmotesChanged.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(
        arg1,
        {
            emotesInfo = arg2.emotes,
            currentEmotes = createCurrentEmotes(arg2.emotes, arg1.equippedEmotes)
        }
    )
end

tbl1[EquippedEmotesChanged.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(
        arg1,
        {
            equippedEmotes = arg2.equippedEmotes,
            currentEmotes = createCurrentEmotes(arg1.emotesInfo, arg2.equippedEmotes)
        }
    )
end

tbl1[NumberEmotesLoadedChanged.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { numberEmotesLoaded = arg2.numberEmotesLoaded })
end

return createReducer({ emotesInfo = {}, equippedEmotes = {}, numberEmotesLoaded = -1, currentEmotes = {} }, tbl1)
