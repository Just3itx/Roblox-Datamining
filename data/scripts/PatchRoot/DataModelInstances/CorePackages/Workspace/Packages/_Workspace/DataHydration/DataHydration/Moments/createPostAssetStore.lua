-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Promise = require(DataHydrationParent.Promise)
local FFlagMomentsRenderAvatarPostsInFeed = require(DataHydrationParent.SharedFlags).FFlagMomentsRenderAvatarPostsInFeed

local createSingleEntityResolver = require(DataHydration.createSingleEntityResolver)
local _MomentsStoreTypes = require(script.Parent.MomentsStoreTypes)

local function createPostAssetStore(tbl1)
    local tbl2 = tbl1 or {}

    local var1 = tbl2.momentsService or game:GetService("MomentsService")
    local postDecoder = tbl2.postDecoder
    local singleEntityResolver = createSingleEntityResolver(function(num1: number)
        return Promise.new(function(callback, callback2)
            task.spawn(function()
                local tbl3 = table.pack(pcall(function()
                    if postDecoder == nil then
                        postDecoder = require(DataHydrationParent.ServiceContractsProto).posts.postasset.post.Post
                    end
                    local postAsyncResult = var1:FetchPostAsync(num1)
                    if not FFlagMomentsRenderAvatarPostsInFeed then
                        return postDecoder.decode(postAsyncResult)
                    end

                    if typeof(postAsyncResult) ~= "buffer" then
                        error(`FetchPostAsync returned {typeof(postAsyncResult)} instead of a buffer for Post {num1}`)
                    end

                    local var2 = postDecoder.decode(postAsyncResult)
                    if var2 == nil then
                        error(`Post decoder returned nil for Post {num1} ({buffer.len(postAsyncResult)} bytes)`)
                    end
                    return var2
                end))
                if tbl3[1] then
                    callback(tbl3[2])
                    return
                end
                callback2(tbl3[2])
            end)
        end)
    end, {
        resolver = { replaceItems = true }
    })

    return {
        getCachedPostAsset = singleEntityResolver.get,
        getAndFetchPostAsset = singleEntityResolver.getAndFetch,
        clear = singleEntityResolver.clear,
        dispose = singleEntityResolver.dispose
    }
end

return createPostAssetStore
