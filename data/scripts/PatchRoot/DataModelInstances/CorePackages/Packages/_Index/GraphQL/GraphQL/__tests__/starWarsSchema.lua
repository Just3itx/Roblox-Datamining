-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Error = LuauPolyfill.Error
local Map = LuauPolyfill.Map

local _invariant = require(scriptParentParent.jsutils.invariant).invariant

local GraphQLSchema = require(scriptParentParent.type.schema).GraphQLSchema
local GraphQLString = require(scriptParentParent.type.scalars).GraphQLString
local definition = require(scriptParentParent.type.definition)
local GraphQLList = definition.GraphQLList
local GraphQLNonNull = definition.GraphQLNonNull
local GraphQLEnumType = definition.GraphQLEnumType
local GraphQLInterfaceType = definition.GraphQLInterfaceType
local GraphQLObjectType = definition.GraphQLObjectType

local starWarsData = require(script.Parent.starWarsData)
local getFriends = starWarsData.getFriends
local getHero = starWarsData.getHero
local getHuman = starWarsData.getHuman
local getDroid = starWarsData.getDroid

local var1 = nil
local var2 = nil
local var3 = nil

local graphQlEnumType = GraphQLEnumType.new({
    name = "Episode",
    description = "One of the films in the Star Wars Trilogy",
    values = Map.new({
        {
            "NEW_HOPE",
            { value = 4, description = "Released in 1977." }
        },
        {
            "EMPIRE",
            { value = 5, description = "Released in 1980." }
        },
        {
            "JEDI",
            { value = 6, description = "Released in 1983." }
        }
    })
})

var1 = GraphQLInterfaceType.new({
    name = "Character",
    description = "A character in the Star Wars Trilogy",
    fields = function()
        return Map.new({
            {
                "id",
                {
                    type = GraphQLNonNull.new(GraphQLString),
                    description = "The id of the character."
                }
            },
            {
                "name",
                { type = GraphQLString, description = "The name of the character." }
            },
            {
                "friends",
                {
                    type = GraphQLList.new(var1),
                    description = "The friends of the character, or an empty list if they have none."
                }
            },
            {
                "appearsIn",
                {
                    type = GraphQLList.new(graphQlEnumType),
                    description = "Which movies they appear in."
                }
            },
            {
                "secretBackstory",
                { type = GraphQLString, description = "All secrets about their past." }
            }
        })
    end,
    resolveType = function(arg1)
        if arg1.type == "Human" then
            return var2.name
        elseif arg1.type == "Droid" then
            return var3.name
        end

        assert(false)
    end
})

var2 = GraphQLObjectType.new({
    name = "Human",
    description = "A humanoid creature in the Star Wars universe.",
    fields = function()
        return Map.new({
            {
                "id",
                {
                    type = GraphQLNonNull.new(GraphQLString),
                    description = "The id of the human."
                }
            },
            {
                "name",
                { type = GraphQLString, description = "The name of the human." }
            },
            {
                "friends",
                {
                    type = GraphQLList.new(var1),
                    description = "The friends of the human, or an empty list if they have none.",
                    resolve = function(arg1)
                        return getFriends(arg1)
                    end
                }
            },
            {
                "appearsIn",
                {
                    type = GraphQLList.new(graphQlEnumType),
                    description = "Which movies they appear in."
                }
            },
            {
                "homePlanet",
                {
                    type = GraphQLString,
                    description = "The home planet of the human, or null if unknown."
                }
            },
            {
                "secretBackstory",
                {
                    type = GraphQLString,
                    description = "Where are they from and how they came to be who they are.",
                    resolve = function()
                        error(Error("secretBackstory is secret."))
                    end
                }
            }
        })
    end,
    interfaces = { var1 }
})

var3 = GraphQLObjectType.new({
    name = "Droid",
    description = "A mechanical creature in the Star Wars universe.",
    fields = function()
        return Map.new({
            {
                "id",
                {
                    type = GraphQLNonNull.new(GraphQLString),
                    description = "The id of the droid."
                }
            },
            {
                "name",
                { type = GraphQLString, description = "The name of the droid." }
            },
            {
                "friends",
                {
                    type = GraphQLList.new(var1),
                    description = "The friends of the droid, or an empty list if they have none.",
                    resolve = function(arg1)
                        return getFriends(arg1)
                    end
                }
            },
            {
                "appearsIn",
                {
                    type = GraphQLList.new(graphQlEnumType),
                    description = "Which movies they appear in."
                }
            },
            {
                "secretBackstory",
                {
                    type = GraphQLString,
                    description = "Construction date and the name of the designer.",
                    resolve = function()
                        error(Error("secretBackstory is secret."))
                    end
                }
            },
            {
                "primaryFunction",
                { type = GraphQLString, description = "The primary function of the droid." }
            }
        })
    end,
    interfaces = { var1 }
})

local graphQlObjectType = GraphQLObjectType.new({
    name = "Query",
    fields = function()
        return Map.new({
            {
                "hero",
                {
                    type = var1,
                    args = {
                        episode = {
                            description = "If omitted, returns the hero of the whole saga. If provided, returns the hero of that particular episode.",
                            type = graphQlEnumType
                        }
                    },
                    resolve = function(_, arg1)
                        return getHero(arg1.episode)
                    end
                }
            },
            {
                "human",
                {
                    type = var2,
                    args = {
                        id = {
                            description = "id of the human",
                            type = GraphQLNonNull.new(GraphQLString)
                        }
                    },
                    resolve = function(_, arg1)
                        return getHuman(arg1.id)
                    end
                }
            },
            {
                "droid",
                {
                    type = var3,
                    args = {
                        id = {
                            description = "id of the droid",
                            type = GraphQLNonNull.new(GraphQLString)
                        }
                    },
                    resolve = function(_, arg1)
                        return getDroid(arg1.id)
                    end
                }
            }
        })
    end
})

return {
    StarWarsSchema = GraphQLSchema.new({ query = graphQlObjectType, types = { var2, var3 } })
}
