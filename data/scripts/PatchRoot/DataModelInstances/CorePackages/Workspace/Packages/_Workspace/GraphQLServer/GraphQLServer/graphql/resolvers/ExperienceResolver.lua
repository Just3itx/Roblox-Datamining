-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLServerParent = script:FindFirstAncestor("GraphQLServer").Parent
local Promise = require(GraphQLServerParent.Promise)
local Array = require(GraphQLServerParent.LuauPolyfill).Array
local _generatedTypes = require(script.Parent.Parent.generatedTypes)

return {
    Experience = {
        thumbnails = function(arg1, _, arg2)
            local thumbnails2 = arg2.dataLoaders.thumbnails
            if not thumbnails2 then
                return Promise.resolve({})
            end

            return (thumbnails2:load(arg1.universeId):andThen(function(arg3): {[any]: any} | {{url: any}}
                return if arg3 then {{
                    url = arg3.imageUrl
                }} else {}
            end):catch(function()
                return {}
            end))
        end
    },
    Query = {
        experienceThumbnails = function(_, arg1)
            return Array.map(arg1.universeIds, function(universeId)
                return { universeId = universeId }
            end)
        end
    }
}
