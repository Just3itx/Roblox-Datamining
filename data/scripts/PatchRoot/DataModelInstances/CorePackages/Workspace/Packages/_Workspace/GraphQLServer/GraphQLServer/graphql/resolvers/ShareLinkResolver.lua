-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLServerParent = script:FindFirstAncestor("GraphQLServer").Parent
local _LuauPolyfill = require(GraphQLServerParent.LuauPolyfill)
local generatedTypes = require(script.Parent.Parent.generatedTypes)
local ShareLinkConnector = require(script.Parent.Parent.connectors.ShareLinkConnector)
local Cryo = require(GraphQLServerParent.Cryo)

return {
    ExperienceDetailsLink = {
        linkType = function()
            return generatedTypes.ShareLinkType.ExperienceDetails
        end,
        linkId = function(arg1)
            return arg1.linkId
        end,
        shortUrl = function(arg1)
            return arg1.shortUrl
        end,
        universeId = function(_, _, _, arg1)
            return arg1.variableValues.universeId
        end
    },
    Query = {
        experienceDetailsLinkByUniverseId = function(_, arg1, arg2, _)
            return ShareLinkConnector.fetchShareLink(
                Cryo.Dictionary.join({ linkType = generatedTypes.ShareLinkType.ExperienceDetails, data = arg1 }),
                arg2.fetchImpl
            )
        end
    }
}
