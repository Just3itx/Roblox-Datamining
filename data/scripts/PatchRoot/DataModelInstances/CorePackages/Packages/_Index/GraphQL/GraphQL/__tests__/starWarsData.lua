-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = require(scriptParentParentParent.LuauPolyfill).Array

local Promise = require(scriptParentParentParent.Promise)

local tbl1 = {
    type = "Human",
    id = "1000",
    name = "Luke Skywalker",
    friends = {
        "1002",
        "1003",
        "2000",
        "2001"
    },
    appearsIn = { 4, 5, 6 },
    homePlanet = "Tatooine"
}

local tbl2 = {
    type = "Human",
    id = "1001",
    name = "Darth Vader",
    friends = { "1004" },
    appearsIn = { 4, 5, 6 },
    homePlanet = "Tatooine"
}

local tbl3 = {
    type = "Human",
    id = "1002",
    name = "Han Solo",
    friends = { "1000", "1003", "2001" },
    appearsIn = { 4, 5, 6 }
}

local tbl4 = {
    type = "Human",
    id = "1003",
    name = "Leia Organa",
    friends = {
        "1000",
        "1002",
        "2000",
        "2001"
    },
    appearsIn = { 4, 5, 6 },
    homePlanet = "Alderaan"
}

local tbl5 = {
    type = "Human",
    id = "1004",
    name = "Wilhuff Tarkin",
    friends = { "1001" },
    appearsIn = { 4 }
}

local tbl6 = {
    [tbl1.id] = tbl1,
    [tbl2.id] = tbl2,
    [tbl3.id] = tbl3,
    [tbl4.id] = tbl4,
    [tbl5.id] = tbl5
}

local tbl7 = {
    type = "Droid",
    id = "2000",
    name = "C-3PO",
    friends = {
        "1000",
        "1002",
        "1003",
        "2001"
    },
    appearsIn = { 4, 5, 6 },
    primaryFunction = "Protocol"
}

local tbl8 = {
    type = "Droid",
    id = "2001",
    name = "R2-D2",
    friends = { "1000", "1002", "1003" },
    appearsIn = { 4, 5, 6 },
    primaryFunction = "Astromech"
}

local tbl9 = {
    [tbl7.id] = tbl7,
    [tbl8.id] = tbl8
}

local function getCharacter(str1: string)
    return Promise.resolve(tbl6[str1] or tbl9[str1])
end

return {
    getHuman = function(str1: string)
        return tbl6[str1]
    end,
    getCharacter = getCharacter,
    getDroid = function(str1: string)
        return tbl9[str1]
    end,
    getFriends = function(tbl10)
        return Array.map(tbl10.friends, function(arg1)
            return getCharacter(arg1)
        end)
    end,
    getHero = function(num1: number): {appearsIn: {number}, friends: {string}, homePlanet: string, id: string, name: string, type: string} | {appearsIn: {number}, friends: {string}, id: string, name: string, primaryFunction: string, type: string}
        return if num1 == 5 then tbl1 else tbl8
    end
}
