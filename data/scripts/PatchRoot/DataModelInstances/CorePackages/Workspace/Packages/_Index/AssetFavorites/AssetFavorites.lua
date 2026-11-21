-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
return {
    DeleteFavoriteForAsset = require(script.Requests.DeleteFavoriteForAsset),
    GetFavoriteForAsset = require(script.Requests.GetFavoriteForAsset),
    PostFavoriteForAsset = require(script.Requests.PostFavoriteForAsset),
    useAssetFavoriting = require(script.Hooks.useAssetFavoriting),
    useLocalUserId = require(script.Hooks.useLocalUserId),
    ["jest.config"] = script["jest.config"]
}
