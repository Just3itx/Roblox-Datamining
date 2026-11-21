-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")

local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent
local React = require(AvatarExperienceCatalogParent.React)

local Stores = require(AvatarExperienceCatalog.Stores)

return React.createContext((Stores()))
