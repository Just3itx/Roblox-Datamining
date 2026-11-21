-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
local AvatarExperienceSlotBasedEditorParent = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor").Parent
local _Categories = require(script.Parent.Parent.Enums.Categories)
local _ScreenLayout = require(script.Parent.Parent.Enums.ScreenLayout)
local _ItemView = require(script.Parent.Parent.Enums.ItemView)
local _createCategoryInventoryStore = require(script.Parent.Parent.Stores.createCategoryInventoryStore)
local _createSortAndFiltersStore = require(script.Parent.Parent.Stores.createSortAndFiltersStore)
local _createSlotBasedEditorStore = require(script.Parent.Parent.Stores.createSlotBasedEditorStore)
local _createThumbnailLatencyStore = require(script.Parent.Parent.Stores.createThumbnailLatencyStore)

local React = require(AvatarExperienceSlotBasedEditorParent.React)
local _Types = require(script.Parent.Parent.Types)

return (React.createContext(nil))
