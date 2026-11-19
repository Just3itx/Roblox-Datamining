-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")
local scriptParent = script.Parent
local Rodux = require(CorePackages.Packages.Rodux)
local FavoriteAssets = require(scriptParent.FavoriteAssets)
local FavoriteBundles = require(scriptParent.FavoriteBundles)

return Rodux.combineReducers({ assets = FavoriteAssets, bundles = FavoriteBundles })
